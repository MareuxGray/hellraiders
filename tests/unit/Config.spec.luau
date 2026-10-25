-- Config integrity (02): the shared values that other systems depend on, plus the blueprint's own maths
-- (02 §2.2 rule, 02 §2.1 tower slots, 12 §12.5 wheel rows, 19 §19.6 crate odds, 13 §13.4 level curve).
local Shared = game:GetService("ReplicatedStorage").Shared
local Config = require(Shared.Config)

return function()
	describe("Config", function()
		it("is frozen", function()
			expect(table.isfrozen(Config)).to.equal(true)
		end)

		it("raid timing: failsafe + countdown + open + lockdown + reopen = 1305", function()
			local total = Config.Evac.AutoStartAt
				+ Config.Evac.Countdown
				+ Config.Evac.OpenWindow
				+ Config.Evac.Lockdown
				+ Config.Evac.ReopenWindow
			expect(total).to.equal(1305)
			expect(Config.Raid.MaxLength).to.equal(total)
			expect(Config.Raid.Length).to.equal(1200)
		end)

		it("tower flats total 64", function()
			local f = Config.Tower.Flats
			expect(f.Bunk + f.Executive + f.Penthouse).to.equal(64)
		end)

		it("attribute pool is reachable with five attributes in 3..7", function()
			expect(#Config.Attr.Names).to.equal(5)
			expect(Config.Attr.Pool).to.equal(25)
			expect(Config.Attr.Min * 5 <= Config.Attr.Pool).to.equal(true)
			expect(Config.Attr.Max * 5 >= Config.Attr.Pool).to.equal(true)
			for _, name in Config.Attr.Names do
				local curves = Config.Attr[name]
				expect(curves).to.be.ok()
				for _, curve in curves do
					expect(#curve).to.equal(5)
				end
			end
		end)

		it("wheel rows each total 100%", function()
			for _, row in Config.Wheel.Jumps do
				expect(row.Success + row.Consolation + row.Destroyed).to.equal(100)
			end
		end)

		it("Evac Pass crate odds total 100%", function()
			local c = Config.Shop.Crate
			expect(c.Common + c.Rare + c.Epic + c.Exotic).to.equal(100)
		end)

		it("level curve reaches 621,720 XP at level 100", function()
			local total = 0
			for n = 1, Config.XP.MaxLevel - 1 do
				total += Config.XP.Base + Config.XP.Step * (n - 1)
			end
			expect(total).to.equal(Config.XP.Level100Total)
		end)

		it("movement speeds match 02 §2.3", function()
			expect(Config.Move.Walk).to.equal(12)
			expect(Config.Move.Sprint).to.equal(22)
			expect(Config.Move.Crouch).to.equal(6)
			expect(Config.Move.Aim.Fwd).to.equal(8)
			expect(Config.Move.Aim.Back).to.equal(4.8)
			expect(Config.Move.JumpEnabled).to.equal(false)
		end)

		it("every gun has the 02 §2.8 columns", function()
			for name, gun in Config.Guns do
				expect(gun.Damage).to.be.a("number")
				expect(gun.RPM).to.be.a("number")
				expect(gun.Mag).to.be.a("number")
				expect(gun.Ammo).to.be.a("string")
				expect(gun.Falloff).to.be.a("number")
				expect(gun.MinDmg > 0 and gun.MinDmg <= 1).to.equal(true)
				expect(Config.Ammo.Stack[gun.Ammo]).to.be.ok()
				expect(gun.Item).to.be.a("string")
			end
			expect(Config.Guns.Longhorn.Damage).to.equal(70)
			expect(Config.Guns.Brace.Pellets).to.equal(8)
		end)

		it("struggle steps get harder and instant from 4", function()
			local steps = Config.Struggle.Steps
			expect(#steps).to.equal(3)
			for i = 2, #steps do
				expect(steps[i].Zone < steps[i - 1].Zone).to.equal(true)
				expect(steps[i].Limit < steps[i - 1].Limit).to.equal(true)
			end
			expect(Config.Struggle.InstantFrom).to.equal(4)
		end)

		it("tier colours exist for all six tiers", function()
			for _, tier in Config.Tier.Order do
				local rgb = Config.Tier[tier]
				expect(#rgb).to.equal(3)
				expect(Config.Tier.Shapes[tier]).to.be.a("string")
			end
		end)

		it("weekly conditions rotate over 8 named conditions", function()
			expect(#Config.Weekly.Conditions).to.equal(8)
		end)

		it("no placeholder place ids yet (PLACEHOLDER tracked in Handoff)", function()
			expect(Config.Places.Mall.Dev).to.equal(0)
			expect(Config.Places.StudioDefault).to.equal("Mall")
		end)
	end)
end
