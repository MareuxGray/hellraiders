--!strict
-- Crafting recipes (12 §12.1 in-raid, §12.3 flat workbench tiers, §12.4 repair, §12.6 trade-up).
-- Ingredient counts and times are copied from 12. Flat workbench crafting unlocks per learned blueprint; its
-- material cost depends only on the output tier (Config.Craft.FlatTiers).

export type Recipe = {
	id: string,
	name: string,
	ingredients: { { id: string, n: number } },
	where: "Inventory" | "Bench",
	time: number,
	output: string,
	outputQty: number?,
	sound: string, -- SFX-CRF-* id
}

local Recipes = {}

Recipes.InRaid = table.freeze({
	{
		id = "RCP-001",
		name = "Molotov",
		ingredients = { { id = "ITM-MAT-002", n = 2 }, { id = "ITM-MAT-001", n = 1 } },
		where = "Inventory",
		time = 4,
		output = "ITM-THR-004",
		sound = "SFX-CRF-003",
	},
	{
		id = "RCP-002",
		name = "Noise Decoy",
		ingredients = { { id = "ITM-MAT-005", n = 1 }, { id = "ITM-MAT-004", n = 1 } },
		where = "Inventory",
		time = 5,
		output = "ITM-THR-003",
		sound = "SFX-CRF-004",
	},
	{
		id = "RCP-003",
		name = "Improvised Bandage",
		ingredients = { { id = "ITM-MAT-013", n = 2 }, { id = "ITM-MAT-003", n = 1 } },
		where = "Inventory",
		time = 3,
		output = "ITM-MED-001",
		sound = "SFX-CRF-001",
	},
	{
		id = "RCP-004",
		name = "UV Stun Flare",
		ingredients = { { id = "ITM-GER-001", n = 1 }, { id = "ITM-MAT-003", n = 1 }, { id = "ITM-GER-002", n = 1 } },
		where = "Bench",
		time = 6,
		output = "ITM-THR-005",
		sound = "SFX-CRF-001",
	},
	{
		id = "RCP-005",
		name = "Improvised Suppressant",
		ingredients = { { id = "ITM-MAT-006", n = 1 }, { id = "ITM-MAT-007", n = 1 } },
		where = "Bench",
		time = 6,
		output = "ITM-MED-010",
		sound = "SFX-CRF-003",
	},
	{
		id = "RCP-006",
		name = "Door Wedge",
		ingredients = { { id = "ITM-MAT-008", n = 2 } },
		where = "Bench",
		time = 4,
		output = "ITM-GER-005",
		sound = "SFX-CRF-002",
	},
	{
		id = "RCP-007",
		name = "Planks ×3",
		ingredients = { { id = "ITM-MAT-008", n = 2 }, { id = "ITM-MAT-003", n = 1 } },
		where = "Bench",
		time = 5,
		output = "ITM-GER-006",
		outputQty = 3,
		sound = "SFX-CRF-005",
	},
} :: { Recipe })

--- Flat workbench material lists by output tier (12 §12.3). MC and minutes are in Config.Craft.FlatTiers.
Recipes.FlatMaterials = table.freeze({
	Common = { { id = "ITM-MAT-008", n = 4 }, { id = "ITM-MAT-009", n = 1 } },
	Rare = { { id = "ITM-MAT-008", n = 4 }, { id = "ITM-MAT-009", n = 3 }, { id = "ITM-MAT-010", n = 1 } },
	Epic = { { id = "ITM-MAT-009", n = 6 }, { id = "ITM-MAT-010", n = 2 }, { id = "ITM-MAT-011", n = 2 } },
	Exotic = { { id = "ITM-MAT-010", n = 4 }, { id = "ITM-MAT-011", n = 3 }, { id = "ITM-MAT-012", n = 1 } },
})

--- Every item id referenced by a recipe (for the integrity test).
function Recipes.referencedItems(): { string }
	local seen: { [string]: boolean } = {}
	local out = {}
	local function add(id: string)
		if not seen[id] then
			seen[id] = true
			table.insert(out, id)
		end
	end
	for _, r in Recipes.InRaid do
		add(r.output)
		for _, ing in r.ingredients do
			add(ing.id)
		end
	end
	for _, mats in Recipes.FlatMaterials do
		for _, ing in mats do
			add(ing.id)
		end
	end
	table.sort(out)
	return out
end

return Recipes
