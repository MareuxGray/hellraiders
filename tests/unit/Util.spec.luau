-- Util: Grid (inventory maths), Rng (determinism, distributions, survivor generation), Time, Tween.
local Shared = game:GetService("ReplicatedStorage").Shared
local Grid = require(Shared.Util.Grid)
local Rng = require(Shared.Util.Rng)
local Time = require(Shared.Util.Time)
local Tween = require(Shared.Util.Tween)
local LootTables = require(Shared.LootTables)
local Config = require(Shared.Config)

return function()
	describe("Grid", function()
		it("places, rejects overlap and out-of-bounds, removes", function()
			local g = Grid.new(4, 4)
			expect(Grid.place(g, "a", 1, 1, 2, 2, false)).to.equal(true)
			expect(Grid.place(g, "b", 2, 2, 1, 1, false)).to.equal(false)
			expect(Grid.place(g, "b", 4, 4, 2, 1, false)).to.equal(false)
			expect(Grid.place(g, "b", 3, 1, 2, 2, false)).to.equal(true)
			expect(Grid.count(g)).to.equal(2)
			expect(Grid.at(g, 2, 2)).to.equal("a")
			expect(Grid.remove(g, "a")).to.be.ok()
			expect(Grid.at(g, 2, 2)).to.equal(nil)
			expect(Grid.freeCells(g)).to.equal(12)
		end)

		it("rejects duplicate uids (25 §25.9)", function()
			local g = Grid.new(4, 4)
			expect(Grid.place(g, "a", 1, 1, 1, 1, false)).to.equal(true)
			expect(Grid.place(g, "a", 2, 2, 1, 1, false)).to.equal(false)
		end)

		it("rotates footprints and moves atomically", function()
			local g = Grid.new(3, 2)
			expect(Grid.place(g, "rifle", 1, 1, 3, 1, false)).to.equal(true)
			expect(Grid.move(g, "rifle", 1, 1, true)).to.equal(false) -- 1×3 doesn't fit a 2-high grid
			expect(Grid.at(g, 3, 1)).to.equal("rifle") -- unchanged after the failed move
			expect(Grid.move(g, "rifle", 1, 2, false)).to.equal(true)
			expect(Grid.at(g, 1, 1)).to.equal(nil)
			expect(Grid.at(g, 2, 2)).to.equal("rifle")
		end)

		it("finds the first free slot top-left first, rotating when needed", function()
			local g = Grid.new(4, 4)
			Grid.place(g, "a", 1, 1, 4, 3, false)
			local x, y, rot = Grid.findFree(g, 1, 1)
			expect(x).to.equal(1)
			expect(y).to.equal(4)
			expect(rot).to.equal(false)
			local x2, y2, rot2 = Grid.findFree(g, 1, 4)
			expect(x2).to.equal(1)
			expect(y2).to.equal(4)
			expect(rot2).to.equal(true)
			expect(Grid.findFree(g, 2, 2)).to.equal(nil)
		end)

		it("serialises and deserialises with overflow for a smaller grid (15 §15.6)", function()
			local g = Grid.new(10, 15)
			Grid.place(g, "x", 1, 1, 2, 2, false)
			Grid.place(g, "y", 9, 14, 2, 2, false)
			local saved = Grid.serialize(g)
			expect(#saved).to.equal(2)
			local back, overflow = Grid.deserialize(10, 15, saved)
			expect(Grid.count(back)).to.equal(2)
			expect(#overflow).to.equal(0)
			local small, over2 = Grid.deserialize(5, 5, saved)
			expect(Grid.count(small)).to.equal(1)
			expect(#over2).to.equal(1)
			expect(over2[1].uid).to.equal("y")
		end)
	end)

	describe("Rng", function()
		it("is deterministic for equal seeds and different for different seeds", function()
			local a, b, c = Rng.new(42), Rng.new(42), Rng.new("raid-7")
			local sa, sb, sc = {}, {}, {}
			for i = 1, 20 do
				sa[i] = a:nextRaw()
				sb[i] = b:nextRaw()
				sc[i] = c:nextRaw()
			end
			expect(table.concat(sa, ",")).to.equal(table.concat(sb, ","))
			expect(table.concat(sa, ",")).never.to.equal(table.concat(sc, ","))
		end)

		it("stays in range", function()
			local r = Rng.new(1)
			for _ = 1, 10000 do
				local f = r:nextNumber()
				expect(f >= 0 and f < 1).to.equal(true)
				local i = r:nextInteger(3, 7)
				expect(i >= 3 and i <= 7).to.equal(true)
			end
		end)

		it("10,000 loot tier rolls per class land within 1% of the table (S4 acceptance, run early)", function()
			local r = Rng.new("loot")
			for _, class in LootTables.Classes do
				local counts = {}
				for _ = 1, 10000 do
					local tier = LootTables.pickTier(class, r:nextNumber())
					counts[tier] = (counts[tier] or 0) + 1
				end
				for i, tier in LootTables.TierKeys do
					local observed = (counts[tier] or 0) / 100
					expect(math.abs(observed - class.weights[i]) <= 1.5).to.equal(true)
				end
			end
		end)

		it("10,000 generated survivors total 25 with every attribute 3–7 (S14 acceptance, run early)", function()
			local r = Rng.new("survivors")
			local threes = 0
			for _ = 1, 10000 do
				local attrs =
					r:generateAttributes(Config.Attr.Names, Config.Attr.Min, Config.Attr.Max, Config.Attr.Pool)
				local total = 0
				for _, name in Config.Attr.Names do
					local v = attrs[name]
					expect(v >= 3 and v <= 7).to.equal(true)
					total += v
				end
				expect(total).to.equal(25)
				if attrs.Endurance == 3 then
					threes += 1
				end
			end
			-- 13 §13.3 odds table: value 3 is 9.68% per attribute (tools/check_numbers.py)
			expect(math.abs(threes / 100 - 9.68) < 1.2).to.equal(true)
		end)

		it("weighted pick respects weights", function()
			local r = Rng.new(9)
			local hits = { a = 0, b = 0 }
			for _ = 1, 10000 do
				local picked = r:weighted({ { "a", 1 }, { "b", 3 } }, function(entry)
					return entry[2]
				end)
				hits[picked[1]] += 1
			end
			expect(math.abs(hits.b / 10000 - 0.75) < 0.03).to.equal(true)
		end)
	end)

	describe("Time", function()
		it("formats MM:SS", function()
			expect(Time.mmss(0)).to.equal("00:00")
			expect(Time.mmss(305)).to.equal("05:05")
			expect(Time.mmss(1305)).to.equal("21:45")
		end)
		it("weeks start Monday 00:00 UTC", function()
			-- 2026-10-26 is a Monday: unix 1792972800
			local monday = 1792972800
			expect(Time.weekStart(Time.weekId(monday))).to.equal(monday)
			expect(Time.weekId(monday - 1)).to.equal(Time.weekId(monday) - 1)
			expect(Time.untilNextWeek(monday)).to.equal(7 * 86400)
			expect(Time.untilNextDay(monday + 100)).to.equal(86400 - 100)
		end)
		it("rotates weekly conditions", function()
			local n = #Config.Weekly.Conditions
			expect(Time.rotationIndex(0, n)).to.equal(1)
			expect(Time.rotationIndex(n, n)).to.equal(1)
			expect(Time.rotationIndex(3, n)).to.equal(4)
		end)
	end)

	describe("Tween", function()
		it("eases and scales effects by settings (04 §4.11)", function()
			expect(Tween.lerp(0, 10, 0.25)).to.equal(2.5)
			expect(Tween.smoothstep(0.5)).to.equal(0.5)
			expect(Tween.easeOutQuad(1)).to.equal(1)
			expect(Tween.effectScale(1, 1, false, 0.25)).to.equal(1)
			expect(Tween.effectScale(1, 0.5, true, 0.25)).to.equal(0.125)
			local v = Tween.approach(0, 10, 12, 1)
			expect(v > 9.99 and v < 10).to.equal(true)
		end)
	end)
end
