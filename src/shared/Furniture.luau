--!strict
-- Furniture catalogue (15 §15.9) with footprint, price, notes, functional perks (15 §15.4), wallpapers and floors.
-- Models MDL-FUR-001…036, catalogue icons UI-FUR-001…056, wallpapers TEX-WAL-*, floors TEX-FLR-*.

export type Furniture = {
	id: string,
	name: string,
	footprint: { number }?, -- studs { w, d }; nil for wall / surface items
	placement: "Floor" | "Wall" | "Surface" | "Terrace",
	priceMC: number?,
	priceRobux: number?,
	loot: string?, -- tier when it drops in raids (ITM-DEC-*)
	lootItem: string?,
	colours: number?,
	light: boolean?,
	functional: string?, -- perk key in Config.Flat.Perks
	penthouseOnly: boolean?,
	variants: number?,
	model: string?,
	icon: string,
}

local list: { Furniture } = {
	{ id = "FUR-001", name = "Army cot", footprint = { 3, 7 }, placement = "Floor", priceMC = 1000 },
	{ id = "FUR-002", name = "Old sofa", footprint = { 7, 3 }, placement = "Floor", priceMC = 4000, colours = 3 },
	{
		id = "FUR-003",
		name = "Leather sofa",
		footprint = { 8, 3.5 },
		placement = "Floor",
		priceMC = 25000,
		priceRobux = 99,
		colours = 12,
	},
	{ id = "FUR-004", name = "Armchair", footprint = { 3, 3 }, placement = "Floor", priceMC = 3000 },
	{ id = "FUR-005", name = "Coffee table", footprint = { 4, 2.5 }, placement = "Floor", priceMC = 2000 },
	{ id = "FUR-006", name = "Dining table + 4 chairs", footprint = { 6, 4 }, placement = "Floor", priceMC = 6000 },
	{ id = "FUR-007", name = "Crate table", footprint = { 3, 3 }, placement = "Floor", priceMC = 500 },
	{ id = "FUR-008", name = "Bookshelf", footprint = { 4, 1.5 }, placement = "Floor", priceMC = 3500 },
	{ id = "FUR-009", name = "Floor lamp", footprint = { 1, 1 }, placement = "Floor", priceMC = 1500, light = true },
	{ id = "FUR-010", name = "Workbench lamp", placement = "Wall", priceMC = 800, light = true },
	{
		id = "FUR-011",
		name = "String lights",
		placement = "Wall",
		priceMC = 2000,
		priceRobux = 25,
		light = true,
		colours = 6,
	},
	{ id = "FUR-012", name = 'Neon sign "OPEN"', placement = "Wall", priceRobux = 49, light = true },
	{ id = "FUR-013", name = "Neon sign skull", placement = "Wall", priceRobux = 79, light = true },
	{
		id = "FUR-014",
		name = "Neon arcade cabinet",
		footprint = { 2, 2 },
		placement = "Floor",
		loot = "Epic",
		lootItem = "ITM-DEC-001",
	},
	{ id = "FUR-015", name = "CRT TV", footprint = { 2, 1.5 }, placement = "Floor", priceMC = 2500 },
	{ id = "FUR-016", name = "Flat-screen TV", placement = "Wall", priceMC = 12000 },
	{ id = "FUR-017", name = "Potted plant", footprint = { 1, 1 }, placement = "Floor", priceMC = 1200, variants = 3 },
	{ id = "FUR-018", name = "Dead plant", footprint = { 1, 1 }, placement = "Floor", priceMC = 100 },
	{ id = "FUR-019", name = "Rug", footprint = { 6, 4 }, placement = "Floor", priceMC = 2000, variants = 5 },
	{ id = "FUR-020", name = "Poster", placement = "Wall", priceMC = 300, variants = 10 },
	{ id = "FUR-021", name = "Graffiti wall decal", placement = "Wall", priceRobux = 25, variants = 8 },
	{ id = "FUR-022", name = "Gun safe (decor)", footprint = { 2, 2 }, placement = "Floor", priceMC = 8000 },
	{ id = "FUR-023", name = "Punching bag", footprint = { 2, 2 }, placement = "Floor", priceMC = 6000 },
	{ id = "FUR-024", name = "Fish tank", footprint = { 4, 1.5 }, placement = "Floor", priceMC = 18000 },
	{ id = "FUR-025", name = "Mannequin", footprint = { 1, 1 }, placement = "Floor", priceMC = 10000 },
	{
		id = "FUR-026",
		name = "Mall bench",
		footprint = { 6, 2 },
		placement = "Floor",
		loot = "Rare",
		lootItem = "ITM-DEC-002",
	},
	{
		id = "FUR-027",
		name = "Shopping trolley",
		footprint = { 2, 3 },
		placement = "Floor",
		loot = "Uncommon",
		lootItem = "ITM-DEC-003",
	},
	{ id = "FUR-028", name = "Golden escalator sign", placement = "Wall", loot = "Exotic", lootItem = "ITM-DEC-004" },
	{
		id = "FUR-029",
		name = "Coffee Bar",
		footprint = { 4, 2 },
		placement = "Floor",
		priceMC = 20000,
		priceRobux = 99,
		functional = "WellRested",
	},
	{
		id = "FUR-030",
		name = "Upgraded Armory Bench",
		footprint = { 6, 2 },
		placement = "Floor",
		priceMC = 35000,
		priceRobux = 149,
		functional = "ArmoryMounts",
	},
	{
		id = "FUR-031",
		name = "Vintage Jukebox",
		footprint = { 2, 2 },
		placement = "Floor",
		priceMC = 15000,
		priceRobux = 99,
		functional = "Jukebox",
	},
	{
		id = "FUR-032",
		name = "Security Terminal Desk",
		footprint = { 4, 2 },
		placement = "Floor",
		priceMC = 30000,
		priceRobux = 149,
		functional = "Desk",
	},
	{
		id = "FUR-033",
		name = "Radio Set",
		footprint = { 1, 1 },
		placement = "Floor",
		priceMC = 3000,
		functional = "Radio",
	},
	{ id = "FUR-034", name = "Penthouse bar", footprint = { 8, 2 }, placement = "Floor", priceRobux = 199 },
	{ id = "FUR-035", name = "Grand piano", footprint = { 6, 5 }, placement = "Floor", priceRobux = 299 },
	{
		id = "FUR-036",
		name = "Hot tub",
		footprint = { 8, 8 },
		placement = "Terrace",
		priceRobux = 399,
		penthouseOnly = true,
	},
} :: { Furniture }

for i, f in list do
	f.model = string.format("MDL-FUR-%03d", i)
	f.icon = string.format("UI-FUR-%03d", i)
end

-- Wallpapers (12) and floorings (8): 1,000–6,000 MC, 4 wallpapers and 2 floors at 49 R$. Which ones are Robux
-- and the exact MC price per surface are not in the blueprint: PLACEHOLDER low-end prices, the last 4 / 2 are
-- Robux (question Q-007). Icons continue UI-FUR-037…056.
local surfaces = {}
local icon = 36
for i = 1, 12 do
	icon += 1
	table.insert(surfaces, {
		id = string.format("WAL-%03d", i),
		name = `[Wallpaper {i}]`,
		placement = "Surface",
		priceMC = if i <= 8 then 1000 else nil,
		priceRobux = if i > 8 then 49 else nil,
		texture = string.format("TEX-WAL-%03d", i),
		icon = string.format("UI-FUR-%03d", icon),
	})
end
for i = 1, 8 do
	icon += 1
	table.insert(surfaces, {
		id = string.format("FLR-%03d", i),
		name = `[Flooring {i}]`,
		placement = "Surface",
		priceMC = if i <= 6 then 1000 else nil,
		priceRobux = if i > 6 then 49 else nil,
		texture = string.format("TEX-FLR-%03d", i),
		icon = string.format("UI-FUR-%03d", icon),
	})
end

local byId: { [string]: any } = {}
for _, f in list do
	byId[f.id] = f
end
for _, s in surfaces do
	byId[s.id] = s
end

return table.freeze({
	List = table.freeze(list),
	Surfaces = table.freeze(surfaces),
	ById = table.freeze(byId),
	Count = #list,
	Tabs = table.freeze({
		"Seating",
		"Tables",
		"Storage",
		"Lighting",
		"Wall",
		"Floor",
		"Electronics",
		"Plants",
		"Functional",
		"Trophies",
		"Wallpaper",
		"Flooring",
	}),
})
