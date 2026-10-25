-- AssetRegistry (25 §25.3, 27): every id, counts per kind from 27 §27.1, placeholder resolution and logging.
local Shared = game:GetService("ReplicatedStorage").Shared
local AssetRegistry = require(Shared.AssetRegistry)

return function()
	describe("AssetRegistry", function()
		it("holds all 1,951 assets with the 27 §27.1 kind counts", function()
			local counts = AssetRegistry.counts()
			expect(counts.MDL).to.equal(442)
			expect(counts.ANIM).to.equal(191)
			expect(counts.SFX).to.equal(341)
			expect(counts.MUS).to.equal(75)
			expect(counts.VO).to.equal(232)
			expect(counts.UI).to.equal(493)
			expect(counts.VFX).to.equal(49)
			expect(counts.TEX).to.equal(128)
			local total = 0
			for _, n in counts do
				total += n
			end
			expect(total).to.equal(1951)
		end)

		it("per-step counts match the 26 Asset requests", function()
			expect(AssetRegistry.countByStep("S1")).to.equal(86)
			expect(AssetRegistry.countByStep("S2")).to.equal(157)
			expect(AssetRegistry.countByStep("S4")).to.equal(227)
			expect(AssetRegistry.countByStep("F11")).to.equal(320)
			expect(AssetRegistry.countByStep("S0")).to.equal(0)
		end)

		it("every entry has kind, step, desc and a numeric id", function()
			for id, e in AssetRegistry.all() do
				expect(string.sub(id, 1, #e.kind)).to.equal(e.kind)
				expect(e.step).to.be.a("string")
				expect(e.desc).to.be.a("string")
				expect(e.id).to.be.a("number")
				if e.kind == "MDL" then
					expect(e.size).to.be.ok()
					expect(#e.size).to.equal(3)
				end
			end
		end)

		it("resolves placeholders by kind", function()
			local anim = AssetRegistry.get("ANIM-MOV-001")
			expect(anim.real).to.equal(false)
			expect(anim.assetId).to.equal(AssetRegistry.Placeholder.ANIM.Default)
			expect(AssetRegistry.get("ANIM-MOV-002", "Walk").assetId).to.equal(AssetRegistry.Placeholder.ANIM.Walk)
			expect(AssetRegistry.get("SFX-UI-001").assetId).to.equal(AssetRegistry.Placeholder.SFX)
			expect(AssetRegistry.get("MUS-RAID-001").assetId).to.equal("")
			expect(AssetRegistry.isReal("MDL-RAID-001")).to.equal(false)
		end)

		it("errors on an unknown id", function()
			expect(function()
				AssetRegistry.get("MDL-NOPE-999")
			end).to.throw("unknown asset id")
		end)

		it("placeholder summary counts every entry while nothing is real", function()
			local line = AssetRegistry.printSummary()
			expect(string.sub(line, 1, 12)).to.equal("PLACEHOLDERS")
			expect(string.find(line, "MDL 442", 1, true)).to.be.ok()
			expect(string.find(line, "UI 493", 1, true)).to.be.ok()
		end)

		it("exports an Asset requests block in the 27 table format", function()
			local ids = AssetRegistry.placeholdersFor("S3")
			expect(#ids).to.equal(14)
			expect(ids[1]).to.equal("ANIM-ACT-020")
			local text = AssetRegistry.assetRequestText("S3")
			expect(string.find(text, "| MDL-TWR-080 | MDL |", 1, true)).to.be.ok()
			expect(string.find(text, "16x12x16", 1, true)).to.be.ok()
		end)

		it("Instance builders return nil outside Roblox", function()
			expect(AssetRegistry.model("MDL-CON-001")).to.equal(nil)
			expect(AssetRegistry.sound("SFX-UI-001")).to.equal(nil)
		end)
	end)
end
