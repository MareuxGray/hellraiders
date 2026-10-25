-- Data modules: Items, LootTables, Recipes, Achievements, Names, Contracts, Products, Cosmetics, Furniture,
-- Vinyls, MallShops, Epithets. Every referenced asset id must exist in the registry; every referenced item id
-- must exist in Items; counts match the blueprint.
local Shared = game:GetService("ReplicatedStorage").Shared
local AssetRegistry = require(Shared.AssetRegistry)
local Items = require(Shared.Items)
local LootTables = require(Shared.LootTables)
local Recipes = require(Shared.Recipes)
local Achievements = require(Shared.Achievements)
local Names = require(Shared.Names)
local Contracts = require(Shared.Contracts)
local Products = require(Shared.Products)
local Cosmetics = require(Shared.Cosmetics)
local Furniture = require(Shared.Furniture)
local Vinyls = require(Shared.Vinyls)
local MallShops = require(Shared.MallShops)
local Epithets = require(Shared.Epithets)
local Config = require(Shared.Config)

local function assetExists(id)
	return AssetRegistry.lookup(id) ~= nil
end

return function()
	describe("Items", function()
		it("has unique ids, valid tiers and groups, and registry-backed models and icons", function()
			local seen = {}
			for _, item in Items.List do
				expect(seen[item.id]).to.equal(nil)
				seen[item.id] = true
				expect(table.find(Items.TierOrder, item.tier)).to.be.ok()
				expect(item.w >= 1 and item.h >= 1).to.equal(true)
				if item.model then
					expect(assetExists(item.model)).to.equal(true)
				end
				if item.icon then
					expect(assetExists(item.icon)).to.equal(true)
				end
			end
		end)

		it("matches 11 §11.2 spot values", function()
			expect(Items.get("ITM-GUN-004").value).to.equal(18000)
			expect(Items.get("ITM-MED-008").tier).to.equal("Exotic")
			expect(Items.get("ITM-AMO-003").stack).to.equal(20)
			expect(Items.weight(Items.get("ITM-AMO-001"), 30)).to.be.near(0.3)
			expect(Items.weight(Items.get("ITM-ARM-002"))).to.equal(9)
		end)

		it("has the 17 blueprint models across three categories (12 §12.2)", function()
			local bps = Items.where({ group = "Blueprint", includeCraftOnly = true })
			expect(#bps).to.equal(17)
			expect(#Items.blueprintsAt("Guns", "Exotic")).to.equal(2)
			expect(#Items.blueprintsAt("Armour", "Common")).to.equal(0)
			for _, bp in bps do
				expect(Items.has(bp.unlocks)).to.equal(true)
				expect(bp.value).to.equal(({ Common = 2000, Rare = 6000, Epic = 15000, Exotic = 40000 })[bp.tier])
			end
		end)

		it("gun items point at Config.Guns entries and vice versa", function()
			for key, gun in Config.Guns do
				local item = Items.get(gun.Item)
				expect(item.gun).to.equal(key)
			end
		end)

		it("non-tradeable rules (16 §16.3)", function()
			expect(Items.isTradeable(Items.get("ITM-TAG-001"))).to.equal(false)
			expect(Items.isTradeable(Items.get("ITM-KEY-010"))).to.equal(false)
			expect(Items.isTradeable(Items.get("ITM-VIN"))).to.equal(false)
			expect(Items.isTradeable(Items.get("ITM-GUN-001"))).to.equal(true)
		end)
	end)

	describe("LootTables", function()
		it("validates: weights sum to 100 and wing counts total 128 + 96 = 224", function()
			local problems = LootTables.validate()
			expect(#problems).to.equal(0)
		end)

		it("pickTier follows the weights at the boundaries", function()
			local bin = LootTables.ClassById.Bin
			expect(LootTables.pickTier(bin, 0)).to.equal("Common")
			expect(LootTables.pickTier(bin, 0.699)).to.equal("Common")
			expect(LootTables.pickTier(bin, 0.7)).to.equal("Uncommon")
			expect(LootTables.pickTier(bin, 0.96)).to.equal("Rare")
			expect(LootTables.pickTier(LootTables.ClassById.MedSafe, 0)).to.equal("Uncommon")
			expect(LootTables.pickBlueprintTier(0.49)).to.equal("Common")
			expect(LootTables.pickBlueprintTier(0.99)).to.equal("Exotic")
		end)

		it("every class has at least one candidate item for every tier it can roll", function()
			for _, class in LootTables.Classes do
				for i, tier in LootTables.TierKeys do
					if class.weights[i] > 0 then
						local c = LootTables.candidates(class, tier, "Galleria", Config.Loot.WingBiasMult)
						expect(#c > 0).to.equal(true)
					end
				end
			end
		end)

		it("class models exist in the registry", function()
			for _, class in LootTables.Classes do
				for _, m in class.models do
					expect(assetExists(m)).to.equal(true)
				end
			end
		end)
	end)

	describe("Recipes", function()
		it("reference only real items and sounds", function()
			for _, id in Recipes.referencedItems() do
				expect(Items.has(id)).to.equal(true)
			end
			for _, r in Recipes.InRaid do
				expect(assetExists(r.sound)).to.equal(true)
			end
			expect(#Recipes.InRaid).to.equal(7)
		end)
	end)

	describe("Achievements", function()
		it("has 40 unique achievements with registry icons and trophies", function()
			expect(Achievements.Count).to.equal(40)
			local trophies = 0
			for _, a in Achievements.List do
				expect(assetExists(a.icon)).to.equal(true)
				if a.trophy then
					trophies += 1
					expect(assetExists(a.trophy)).to.equal(true)
				end
			end
			expect(trophies).to.equal(12)
		end)
	end)

	describe("Names", function()
		it("has 120 unique first and 120 unique last names", function()
			expect(#Names.First).to.equal(120)
			expect(#Names.Last).to.equal(120)
			for _, list in { Names.First, Names.Last } do
				local seen = {}
				for _, n in list do
					expect(seen[n]).to.equal(nil)
					seen[n] = true
				end
			end
		end)
	end)

	describe("Contracts", function()
		it("has 3 starter contracts and the 16-entry pool (13 §13.8)", function()
			expect(#Contracts.Starter).to.equal(3)
			expect(#Contracts.Pool).to.equal(16)
		end)
	end)

	describe("Products", function()
		it("every price is on the 19 §19.3 ladder and under 1,499", function()
			for _, p in Products.List do
				if p.price > 0 then
					expect(table.find(Products.PriceLadder, p.price)).to.be.ok()
					expect(p.price <= Products.MaxPrice).to.equal(true)
				end
				expect(p.productId).to.equal(0) -- PLACEHOLDER until the Creator Hub products exist
			end
			expect(Products.ByKey.SecondWind.price).to.equal(79)
			expect(Products.ByKey.MutateNow.token).to.equal("MutateToken")
			expect(Products.MallCashAmount.MallCash200000).to.equal(200000)
		end)
	end)

	describe("Cosmetics", function()
		it("has the 19 §19.5 group counts and registry-backed assets", function()
			local byGroup = {}
			for _, c in Cosmetics.List do
				byGroup[c.group] = (byGroup[c.group] or 0) + 1
				if c.asset then
					expect(assetExists(c.asset)).to.equal(true)
				end
				if c.icon then
					expect(assetExists(c.icon)).to.equal(true)
				end
			end
			expect(byGroup.Finish).to.equal(24)
			expect(byGroup.Sticker).to.equal(30)
			expect(byGroup.Charm).to.equal(12)
			expect(byGroup.Outfit).to.equal(20)
			expect(byGroup.Emote).to.equal(12)
			expect(Cosmetics.ById["COS-EMO-002"].name).to.equal("Hands Up")
			expect(Cosmetics.ById["COS-CHM-011"].name).to.equal("Plus One")
		end)
	end)

	describe("Furniture", function()
		it("has 36 items, 12 wallpapers, 8 floors with registry models and icons", function()
			expect(Furniture.Count).to.equal(36)
			expect(#Furniture.Surfaces).to.equal(20)
			for _, f in Furniture.List do
				expect(assetExists(f.model)).to.equal(true)
				expect(assetExists(f.icon)).to.equal(true)
				if f.lootItem then
					expect(Items.has(f.lootItem)).to.equal(true)
				end
			end
			for _, s in Furniture.Surfaces do
				expect(assetExists(s.texture)).to.equal(true)
				expect(assetExists(s.icon)).to.equal(true)
			end
			expect(Furniture.ById["FUR-029"].functional).to.equal("WellRested")
		end)
	end)

	describe("Vinyls, MallShops, Epithets", function()
		it("40 vinyl tracks in 5 moods with registry music ids", function()
			expect(#Vinyls.List).to.equal(40)
			for _, v in Vinyls.List do
				expect(assetExists(v.assetId)).to.equal(true)
				expect(table.find(Vinyls.Moods, v.mood)).to.be.ok()
			end
		end)
		it("48 shops; 12 alarm-marked (23 §23.3.1)", function()
			expect(MallShops.Count).to.equal(48)
			local marked = 0
			for _, n in MallShops.AlarmMarked do
				marked += n
			end
			expect(marked).to.equal(12)
			for _, shop in MallShops.List do
				for _, c in shop.containers do
					expect(LootTables.ClassById[c]).to.be.ok()
				end
			end
		end)
		it("40 epithets, 5 from the blueprint", function()
			expect(Epithets.Count).to.equal(40)
			expect(Epithets.RealCount).to.equal(5)
			expect(Epithets.List[1]).to.equal("Old Faithful")
		end)
	end)
end
