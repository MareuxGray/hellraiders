--!strict
-- Loot tables (11 §11.3, §11.6; 23 §23.7). Container classes with model ids, slot ranges, open hold, tier weights
-- (Common/Uncommon/Rare/Epic/Exotic, sum 100) and category bias; wing bias; fixed placements; per-wing container
-- counts for the map audit. Rolling itself is Services.Loot (S4); this module only holds the data and the pure
-- weighted pick, so it can be tested headlessly.

local Items = require(script.Parent.Items)

export type ContainerClass = {
	id: string,
	name: string,
	models: { string },
	slots: { number }, -- { min, max }
	openHold: number,
	locked: string?, -- "Keycard" | "Code" | "Room" (room needs a keycard)
	weights: { number }, -- C, U, R, E, X
	bias: { string }, -- Items.Group names favoured by this class; empty = any
	exclude: { string }?, -- groups never in this class
	blueprintChance: number?, -- overrides Config.Loot.BlueprintChance
}

local LootTables = {}

LootTables.TierKeys = table.freeze({ "Common", "Uncommon", "Rare", "Epic", "Exotic" })

LootTables.Classes = table.freeze({
	{
		id = "Bin",
		name = "Trash bin / rubble",
		models = { "MDL-CON-001", "MDL-CON-002" },
		slots = { 2, 3 },
		openHold = 1.2,
		weights = { 70, 25, 5, 0, 0 },
		bias = { "Material", "Throwable" },
	},
	{
		id = "Shelf",
		name = "Shelf / rack",
		models = { "MDL-CON-003", "MDL-CON-004" },
		slots = { 3, 5 },
		openHold = 1.2,
		weights = { 60, 30, 9, 1, 0 },
		bias = {},
		exclude = { "Gun" },
	},
	{
		id = "Till",
		name = "Till / register",
		models = { "MDL-CON-005" },
		slots = { 2, 4 },
		openHold = 1.2,
		weights = { 40, 40, 17, 3, 0 },
		bias = { "Valuable", "Keycard" },
	},
	{
		id = "Locker",
		name = "Locker / staff bag",
		models = { "MDL-CON-006", "MDL-CON-007" },
		slots = { 3, 5 },
		openHold = 1.2,
		weights = { 50, 32, 14, 4, 0 },
		bias = { "Gear", "Medical", "Ammo" },
	},
	{
		id = "Display",
		name = "Display case",
		models = { "MDL-CON-008" },
		slots = { 2, 3 },
		openHold = 1.2,
		weights = { 30, 35, 25, 9, 1 },
		bias = { "Valuable", "Attachment" },
	},
	{
		id = "MedCabinet",
		name = "Med cabinet",
		models = { "MDL-CON-009" },
		slots = { 3, 5 },
		openHold = 1.2,
		weights = { 45, 35, 17, 3, 0 },
		bias = { "Medical" },
		exclude = {
			"Gun",
			"Melee",
			"Ammo",
			"Attachment",
			"Armour",
			"Pack",
			"Gear",
			"Keycard",
			"Throwable",
			"Material",
			"Valuable",
			"Decor",
		},
	},
	{
		id = "MedSafe",
		name = "Med Safe",
		models = { "MDL-CON-010" },
		slots = { 4, 4 },
		openHold = 2.0,
		locked = "Code",
		weights = { 0, 30, 45, 20, 5 },
		bias = { "Medical" },
		exclude = {
			"Gun",
			"Melee",
			"Ammo",
			"Attachment",
			"Armour",
			"Pack",
			"Gear",
			"Keycard",
			"Throwable",
			"Material",
			"Valuable",
			"Decor",
		},
		blueprintChance = 0,
	},
	{
		id = "WeaponCrate",
		name = "Weapon crate",
		models = { "MDL-CON-011" },
		slots = { 3, 4 },
		openHold = 1.2,
		weights = { 20, 40, 28, 10, 2 },
		bias = { "Gun", "Ammo", "Attachment", "Armour" },
		blueprintChance = 0.08,
	},
	{
		id = "StockroomCrate",
		name = "Stockroom crate",
		models = { "MDL-CON-012" },
		slots = { 4, 6 },
		openHold = 1.2,
		locked = "Room",
		weights = { 10, 30, 35, 20, 5 },
		bias = {},
		blueprintChance = 0.15,
	},
	{
		id = "Toolbox",
		name = "Toolbox",
		models = { "MDL-CON-013" },
		slots = { 3, 4 },
		openHold = 1.2,
		weights = { 50, 35, 13, 2, 0 },
		bias = { "Material", "Melee" },
	},
	-- F9 catalyst crate (19 §19.7)
	{
		id = "SupplyCrate",
		name = "High-Roller supply crate",
		models = { "MDL-CON-020" },
		slots = { 8, 8 },
		openHold = 1.2,
		weights = { 0, 0, 40, 45, 15 },
		bias = {},
		blueprintChance = 0.5,
	},
} :: { ContainerClass })

local classById: { [string]: ContainerClass } = {}
for _, class in LootTables.Classes do
	classById[class.id] = class
end
LootTables.ClassById = table.freeze(classById)

--- 11 §11.3 wing bias: favoured groups (weight ×2 per Config.Loot.WingBiasMult) and favoured item ids.
LootTables.WingBias = table.freeze({
	Electronics = { groups = { "Material" }, items = { "ITM-MAT-010", "ITM-VAL-008", "ITM-MAT-005" } },
	Pharmacy = { groups = { "Medical" }, items = {} },
	DepartmentStore = { groups = { "Valuable", "Pack" }, items = {} },
	FoodCourt = { groups = { "Material" }, items = { "ITM-MAT-002" } },
	SecurityOffice = { groups = { "Gun", "Keycard" }, items = {} },
	Cinema = { groups = { "Valuable" }, items = { "ITM-GER-002" } },
	Maintenance = { groups = { "Material" }, items = { "ITM-GER-007", "ITM-GER-006" } },
	Garage = { groups = {}, items = {} },
	Galleria = { groups = {}, items = {} },
})

--- 11 §11.6 fixed placements per raid.
LootTables.Fixed = table.freeze({
	Antidotes = { min = 1, max = 3, containers = "MedSafe", item = "ITM-MED-008" },
	Keycards = {
		items = { "ITM-KEY-001", "ITM-KEY-002", "ITM-KEY-003", "ITM-KEY-004", "ITM-KEY-005" },
		containers = { "Till", "Locker" },
		securityDrawers = true,
	},
	FuelCans = { count = 3, item = "ITM-GER-007", nearGenerators = true },
	SafeCodeNotes = { perWingWithSafes = 1, item = "ITM-KEY-010", wings = { "Pharmacy", "SecurityOffice" } },
	WorldRelicContainers = { "Display", "StockroomCrate", "Locker" },
})

--- 23 §23.7 containers by wing, class order: Bin, Shelf, Till, Locker, Display, MedCabinet, MedSafe, WeaponCrate,
--- StockroomCrate, Toolbox. Galleria shops add 2 per shop × 48 = 96 (by shop type).
LootTables.WingCounts = table.freeze({
	FoodCourt = {
		Bin = 6,
		Shelf = 4,
		Till = 6,
		Locker = 2,
		Display = 1,
		MedCabinet = 1,
		MedSafe = 0,
		WeaponCrate = 0,
		StockroomCrate = 3,
		Toolbox = 1,
	},
	Pharmacy = {
		Bin = 1,
		Shelf = 3,
		Till = 1,
		Locker = 1,
		Display = 0,
		MedCabinet = 6,
		MedSafe = 3,
		WeaponCrate = 0,
		StockroomCrate = 2,
		Toolbox = 0,
	},
	DepartmentStore = {
		Bin = 2,
		Shelf = 6,
		Till = 4,
		Locker = 2,
		Display = 4,
		MedCabinet = 0,
		MedSafe = 0,
		WeaponCrate = 0,
		StockroomCrate = 3,
		Toolbox = 1,
	},
	Electronics = {
		Bin = 1,
		Shelf = 3,
		Till = 2,
		Locker = 1,
		Display = 4,
		MedCabinet = 0,
		MedSafe = 0,
		WeaponCrate = 0,
		StockroomCrate = 3,
		Toolbox = 1,
	},
	Cinema = {
		Bin = 3,
		Shelf = 1,
		Till = 2,
		Locker = 2,
		Display = 1,
		MedCabinet = 1,
		MedSafe = 0,
		WeaponCrate = 0,
		StockroomCrate = 0,
		Toolbox = 1,
	},
	SecurityOffice = {
		Bin = 1,
		Shelf = 1,
		Till = 0,
		Locker = 4,
		Display = 0,
		MedCabinet = 1,
		MedSafe = 1,
		WeaponCrate = 3,
		StockroomCrate = 2,
		Toolbox = 0,
	},
	Maintenance = {
		Bin = 3,
		Shelf = 2,
		Till = 0,
		Locker = 2,
		Display = 0,
		MedCabinet = 1,
		MedSafe = 0,
		WeaponCrate = 0,
		StockroomCrate = 0,
		Toolbox = 5,
	},
	Garage = {
		Bin = 4,
		Shelf = 1,
		Till = 1,
		Locker = 2,
		Display = 0,
		MedCabinet = 0,
		MedSafe = 0,
		WeaponCrate = 1,
		StockroomCrate = 0,
		Toolbox = 4,
	},
})
LootTables.WingsTotal = 128
LootTables.GalleriaShops = 48
LootTables.PerShop = 2
LootTables.MapTotal = 224

--- Blueprint tier weights (11 §11.3): Common 50, Rare 30, Epic 15, Exotic 5.
LootTables.BlueprintTierWeights = table.freeze({ { "Common", 50 }, { "Rare", 30 }, { "Epic", 15 }, { "Exotic", 5 } })

--- Weighted pick over Items.Tier using a class's weights. `r` is a uniform random in [0, 1).
function LootTables.pickTier(class: ContainerClass, r: number, multipliers: { [string]: number }?): string
	local total = 0
	local adjusted = {}
	for i, key in LootTables.TierKeys do
		local w = class.weights[i]
		if multipliers and multipliers[key] then
			w *= multipliers[key]
		end
		adjusted[i] = w
		total += w
	end
	local target = r * total
	local acc = 0
	for i, key in LootTables.TierKeys do
		acc += adjusted[i]
		if target < acc then
			return key
		end
	end
	return LootTables.TierKeys[#LootTables.TierKeys]
end

--- Blueprint tier pick (`r` uniform in [0, 1)).
function LootTables.pickBlueprintTier(r: number): string
	local target = r * 100
	local acc = 0
	for _, row in LootTables.BlueprintTierWeights do
		acc += row[2]
		if target < acc then
			return row[1]
		end
	end
	return "Exotic"
end

--- Candidate items for a class at a tier, honouring exclude and bias. Bias is applied by weight (each favoured
--- group's items are counted `biasMult` times), so the result is a list of { item, weight }.
function LootTables.candidates(
	class: ContainerClass,
	tier: string,
	wing: string?,
	biasMult: number
): { { item: Items.Item, weight: number } }
	local out = {}
	local excluded: { [string]: boolean } = {}
	for _, g in class.exclude or {} do
		excluded[g] = true
	end
	local favoured: { [string]: boolean } = {}
	for _, g in class.bias do
		favoured[g] = true
	end
	local wingBias = if wing then (LootTables.WingBias :: any)[wing] else nil
	local wingGroups: { [string]: boolean } = {}
	local wingItems: { [string]: boolean } = {}
	if wingBias then
		for _, g in wingBias.groups do
			wingGroups[g] = true
		end
		for _, id in wingBias.items do
			wingItems[id] = true
		end
	end
	for _, item in Items.where({ tier = tier :: any }) do
		if item.group == "Blueprint" or item.group == "Relic" or item.group == "Tag" or item.raidOnly then
			continue
		end
		if excluded[item.group] then
			continue
		end
		local weight = 1
		if #class.bias > 0 and favoured[item.group] then
			weight *= biasMult
		end
		if wingGroups[item.group] or wingItems[item.id] then
			weight *= biasMult
		end
		table.insert(out, { item = item, weight = weight })
	end
	return out
end

--- Sum check used by tests and tools: every class's weights total 100.
function LootTables.validate(): { string }
	local problems = {}
	for _, class in LootTables.Classes do
		local sum = 0
		for _, w in class.weights do
			sum += w
		end
		if sum ~= 100 then
			table.insert(problems, `{class.id} weights sum {sum}`)
		end
	end
	local wings = 0
	for wing, counts in LootTables.WingCounts do
		for _, n in counts do
			wings += n
		end
		for id in counts do
			if not classById[id] then
				table.insert(problems, `{wing} names unknown class {id}`)
			end
		end
	end
	if wings ~= LootTables.WingsTotal then
		table.insert(problems, `wing containers {wings} != {LootTables.WingsTotal}`)
	end
	if wings + LootTables.GalleriaShops * LootTables.PerShop ~= LootTables.MapTotal then
		table.insert(problems, "map total mismatch")
	end
	return problems
end

return LootTables
