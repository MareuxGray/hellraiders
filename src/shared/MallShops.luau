--!strict
-- The 48 galleria shops (23 §23.3.1). Types and counts are from the blueprint; the invented brand names are not
-- listed anywhere in the blueprint, so every name is a PLACEHOLDER "[Shop type n]" (question Q-003 in
-- docs/questions.md). Floor and row placement is set in the S2 grey-box; `alarmMarked` follows 23 §23.3.1.
-- Container mix per type follows the 23 table (2 containers per shop, 11 §11.3 / 23 §23.7).

export type ShopType = {
	type: string,
	count: number,
	containers: { string }, -- LootTables class ids typical for the type
	note: string?,
}

local MallShops = {}

MallShops.Types = table.freeze({
	{ type = "Apparel", count = 10, containers = { "Shelf", "Till", "Locker" } },
	{ type = "Shoes", count = 4, containers = { "Shelf", "Till" } },
	{ type = "ToysAndGames", count = 4, containers = { "Shelf", "Till", "Display" } },
	{ type = "BooksAndMusic", count = 4, containers = { "Shelf", "Till" } },
	{ type = "Jewellery", count = 3, containers = { "Display", "Till", "Locker" } },
	{
		type = "SportingGoods",
		count = 3,
		containers = { "Shelf", "WeaponCrate", "Toolbox" },
		note = "1 weapon crate per shop",
	},
	{ type = "Hardware", count = 2, containers = { "Toolbox", "Shelf" } },
	{ type = "PhoneAndGadgets", count = 4, containers = { "Display", "Shelf" }, note = "3 inside Electronics" },
	{ type = "PharmacyKiosk", count = 2, containers = { "MedCabinet" }, note = "pharmacy kiosk / optician" },
	{ type = "Cafe", count = 6, containers = { "Till", "Shelf" } },
	{ type = "Salon", count = 3, containers = { "Locker", "MedCabinet" } },
	{ type = "Arcade", count = 1, containers = { "Till", "Display" }, note = "Pixel Palace, First floor south row" },
	{ type = "PawnAndGold", count = 1, containers = { "Display", "Till" } },
	{
		type = "ArmyCheckpoint",
		count = 1,
		containers = { "WeaponCrate", "WeaponCrate", "Locker" },
		note = "Ground, south row; 2 weapon crates",
	},
} :: { ShopType })

-- Alarm-marked shop types (12 shops, 23 §23.3.1): Jewellery ×3, VoltMart (Electronics), Phone ×2, Pawn ×1,
-- Sporting ×2, Toys ×1, Apparel ×2.
MallShops.AlarmMarked = table.freeze({
	Jewellery = 3,
	Electronics = 1,
	PhoneAndGadgets = 2,
	PawnAndGold = 1,
	SportingGoods = 2,
	ToysAndGames = 1,
	Apparel = 2,
})

local list = {}
local n = 0
for _, t in MallShops.Types do
	for i = 1, t.count do
		n += 1
		table.insert(list, {
			id = string.format("SHOP-%02d", n),
			type = t.type,
			name = `[{t.type} {i}]`, -- PLACEHOLDER invented brand name
			containers = t.containers,
		})
	end
end
MallShops.List = table.freeze(list)
MallShops.Count = n
MallShops.Wings = table.freeze({
	FoodCourt = "North",
	Pharmacy = "North",
	DepartmentStore = "North",
	Electronics = "East",
	Cinema = "East",
	SecurityOffice = "Service",
	Maintenance = "Service",
	Garage = "Service",
})

return MallShops
