-- Strings (21 §21.10): every key from the blueprint table, the NPC placeholder family, and format().
local Shared = game:GetService("ReplicatedStorage").Shared
local Strings = require(Shared.Strings)

return function()
	describe("Strings", function()
		it("has every 21 §21.10 key (185) plus the 78 NPC placeholder lines", function()
			local keys = Strings.keys()
			local npc, other = 0, 0
			for _, k in keys do
				if string.sub(k, 1, 8) == "STR.NPC." then
					npc += 1
				else
					other += 1
				end
			end
			expect(other).to.equal(185)
			expect(npc).to.equal(78)
		end)

		it("returns exact blueprint text", function()
			expect(Strings.get("STR.ACT.SEARCH")).to.equal("Search")
			expect(Strings.get("STR.INF.BITTEN")).to.equal("You've been bitten. Find an Antidote, or don't.")
			expect(Strings.get("STR.EVAC.LOCKDOWN")).to.equal("LOCKDOWN. Something came in with you.")
			expect(Strings.get("STR.ACT.TRIP")).to.equal("Check")
		end)

		it("formats variables and leaves unknown ones visible", function()
			expect(Strings.format("STR.RAID.DEPLOY", { gate = "A" })).to.equal("Gate A. Doors opening.")
			expect(Strings.format("STR.FLEA.CONFIRM", { item = "P9", price = 3000, balance = 2000 })).to.equal(
				"Buy P9 for 3000 MC? Balance after: 2000 MC"
			)
			expect(Strings.format("STR.PRG.LEVELUP", {})).to.equal("Level {n}!")
		end)

		it("a missing key is visible, not silent", function()
			expect(Strings.get("STR.NOPE.MISSING")).to.equal("[STR.NOPE.MISSING]")
			expect(Strings.has("STR.NOPE.MISSING")).to.equal(false)
		end)

		it("NPC placeholder lines follow the 21 §21.10 form", function()
			expect(Strings.get("STR.NPC.MARLA.1")).to.equal("[Marla line 1]")
			expect(Strings.get("STR.NPC.DR_HALLORAN.6")).to.equal("[Dr. Halloran line 6]")
			expect(Strings.has("STR.NPC.PIP.5")).to.equal(false)
		end)
	end)
end
