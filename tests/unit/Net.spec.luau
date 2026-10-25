-- Net (25 §25.4): channel table, token bucket and schema validation.
local Shared = game:GetService("ReplicatedStorage").Shared
local Net = require(Shared.Net)
local Config = require(Shared.Config)

return function()
	describe("Net channels", function()
		it("defines every 25 §25.4 channel plus the admin remote", function()
			for _, name in
				{
					"Input",
					"Fire",
					"Melee",
					"Throw",
					"Inventory",
					"Container",
					"StatsState",
					"PoseState",
					"Noise",
					"Struggle",
					"Raid",
					"Evac",
					"Infection",
					"Ui",
					"Shop",
					"Social",
					"Admin",
				}
			do
				expect(Net.ChannelByName[name]).to.be.ok()
			end
			expect(Net.ChannelByName.Admin.kind).to.equal("RemoteFunction")
			expect(Net.ChannelByName.Infection.direction).to.equal("ServerToClient")
		end)

		it("rate limits per channel (25 §25.4)", function()
			expect(Net.rateFor("Inventory").PerSecond).to.equal(30)
			expect(Net.rateFor("Fire").PerSecond).to.equal(15)
			expect(Net.rateFor("PoseState").PerSecond).to.equal(25)
			expect(Net.rateFor("Input").PerSecond).to.equal(20)
			expect(Net.rateFor("Input").Burst).to.equal(40)
		end)

		it("RemoteFunctions are never server → client", function()
			for _, ch in Net.Channels do
				if ch.kind == "RemoteFunction" then
					expect(ch.direction).to.equal("ClientToServer")
				end
			end
		end)
	end)

	describe("Net.Bucket", function()
		it("allows the burst, then drops, then refills at the rate", function()
			local b = Net.Bucket.new(20, 40, 0)
			local allowed = 0
			for _ = 1, 50 do
				if Net.Bucket.take(b, 0) then
					allowed += 1
				end
			end
			expect(allowed).to.equal(40)
			expect(b.dropped).to.equal(10)
			expect(Net.Bucket.take(b, 0.5)).to.equal(true) -- 10 tokens refilled
			local again = 1
			for _ = 1, 20 do
				if Net.Bucket.take(b, 0.5) then
					again += 1
				end
			end
			expect(again).to.equal(10)
		end)

		it("raises a strike after Config.Net.StrikesPerMinute drops within 60 s", function()
			local b = Net.Bucket.new(1, 1, 0)
			Net.Bucket.take(b, 0)
			for _ = 1, Config.Net.StrikesPerMinute - 1 do
				Net.Bucket.take(b, 0)
				expect(Net.Bucket.strike(b, 0)).to.equal(false)
			end
			Net.Bucket.take(b, 0)
			expect(Net.Bucket.strike(b, 0)).to.equal(true)
			expect(Net.Bucket.strike(b, 0)).to.equal(false) -- cleared after a strike
		end)
	end)

	describe("Net.check", function()
		local schema = {
			weaponId = { type = "string", maxLength = 16 },
			clientTime = { type = "number", min = 0 },
			zone = { type = "string", oneOf = { "Head", "Torso" }, optional = true },
			hit = "boolean",
		}

		it("accepts valid args", function()
			local ok, problem = Net.check(schema, { weaponId = "P9", clientTime = 12.5, hit = true })
			expect(ok).to.equal(true)
			expect(problem).to.equal(nil)
		end)

		it("rejects missing, wrong type, non-finite, out of range, too long, not allowed, unexpected", function()
			expect((Net.check(schema, { clientTime = 1, hit = true }))).to.equal(false)
			expect((Net.check(schema, { weaponId = 5, clientTime = 1, hit = true }))).to.equal(false)
			expect((Net.check(schema, { weaponId = "P9", clientTime = 0 / 0, hit = true }))).to.equal(false)
			expect((Net.check(schema, { weaponId = "P9", clientTime = math.huge, hit = true }))).to.equal(false)
			expect((Net.check(schema, { weaponId = "P9", clientTime = -1, hit = true }))).to.equal(false)
			expect((Net.check(schema, { weaponId = string.rep("x", 17), clientTime = 1, hit = true }))).to.equal(false)
			expect((Net.check(schema, { weaponId = "P9", clientTime = 1, hit = true, zone = "Leg" }))).to.equal(false)
			expect((Net.check(schema, { weaponId = "P9", clientTime = 1, hit = true, extra = 1 }))).to.equal(false)
			expect((Net.check(schema, "nope"))).to.equal(false)
		end)

		it("security listeners receive raised events and can unsubscribe", function()
			local got = nil
			local off = Net.onSecurityEvent(function(userId, channel, detail)
				got = { userId, channel, detail }
			end)
			Net.raiseSecurityEvent(7, "Fire", "test")
			expect(got[1]).to.equal(7)
			expect(got[2]).to.equal("Fire")
			off()
			got = nil
			Net.raiseSecurityEvent(8, "Fire", "test")
			expect(got).to.equal(nil)
		end)
	end)
end
