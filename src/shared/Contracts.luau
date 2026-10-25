--!strict
-- Contracts (13 §13.8): starter contracts and the daily/weekly pool. Rewards are in Config.Contracts.
-- Each pool entry is a condition kind with a target; the exact number is rolled per contract from `targets`.
-- Only conditions listed in 13 §13.8 exist here.

export type Contract = {
	id: string,
	name: string,
	kind: string, -- condition kind handled by Services.Progression
	targets: { number }?, -- possible N values; nil for yes/no conditions
	param: string?, -- wing, exit, etc. when the condition needs one
}

local Contracts = {}

Contracts.Starter = table.freeze({
	{ id = "CON-S01", name = "Extract once", kind = "Extract", targets = { 1 } },
	{ id = "CON-S02", name = "Open 10 containers", kind = "OpenContainers", targets = { 10 } },
	{ id = "CON-S03", name = "Win a struggle", kind = "WinStruggle", targets = { 1 } },
} :: { Contract })

--- Daily and weekly pool (13 §13.8). Each is doable in one raid.
Contracts.Pool = table.freeze({
	{ id = "CON-P01", name = "Extract with {n} MC of loot", kind = "ExtractValue", targets = { 3000, 6000, 9000 } },
	{ id = "CON-P02", name = "Open {n} containers in {wing}", kind = "OpenContainersInWing", targets = { 5, 8, 12 } },
	{ id = "CON-P03", name = "Kill {n} zombies with melee", kind = "MeleeKills", targets = { 5, 10, 15 } },
	{ id = "CON-P04", name = "Take down {n} Walkers", kind = "Takedowns", targets = { 2, 3, 5 } },
	{ id = "CON-P05", name = "Start a generator", kind = "StartGenerator" },
	{ id = "CON-P06", name = "Extract with a Rare+ blueprint", kind = "ExtractBlueprintRarePlus" },
	{ id = "CON-P07", name = "Cure a Sleeper (yourself)", kind = "CureSelf" },
	{ id = "CON-P08", name = "Revive a stranger", kind = "ReviveStranger" },
	{ id = "CON-P09", name = "Survive a Lockdown", kind = "SurviveLockdown" },
	{ id = "CON-P10", name = "Use a scanner", kind = "UseScanner" },
	{ id = "CON-P11", name = "Extract from the Helipad", kind = "ExtractExit", param = "Helipad" },
	{ id = "CON-P12", name = "Extract from the Garage", kind = "ExtractExit", param = "Garage" },
	{ id = "CON-P13", name = "Craft {n} items in raid", kind = "CraftInRaid", targets = { 2, 3, 5 } },
	{ id = "CON-P14", name = "Break {n} glass panes", kind = "BreakGlass", targets = { 5, 10, 20 } },
	{ id = "CON-P15", name = "Extract without firing a shot", kind = "ExtractNoShots" },
	{ id = "CON-P16", name = "Play as a Ghost and cause a struggle", kind = "GhostStruggle" },
} :: { Contract })

Contracts.Wings = table.freeze({
	"FoodCourt",
	"Pharmacy",
	"DepartmentStore",
	"Electronics",
	"Cinema",
	"SecurityOffice",
	"Maintenance",
	"Garage",
})

return Contracts
