--!strict
-- Server Bootstrap (25 §25.2): decides which place this server is, requires that place's services in order,
-- calls every `init()` then every `start()`, and prints the start order and the PLACEHOLDERS summary (25 §25.3).
-- Place gating reads Config.Places against game.PlaceId (dev and live ids). In Studio with an unknown PlaceId the
-- server boots as Config.Places.StudioDefault so every place can be tested before the universe exists.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Config = require(Shared:WaitForChild("Config"))
local Net = require(Shared:WaitForChild("Net"))
local AssetRegistry = require(Shared:WaitForChild("AssetRegistry"))

local Services = script.Parent:WaitForChild("Services")

-- Which services each place starts (25 §25.2 place gating). Order matters: Data and Session first.
local RAID_SERVICES = {
	"Stats",
	"Movement",
	"Ragdoll",
	"Combat",
	"Melee",
	"Throwables",
	"Inventory",
	"Loot",
	"Noise",
	"World",
	"AI",
	"Infection",
	"Mutants",
	"RaidFlow",
	"Evac",
	"Crafting",
}
local PLACE_SERVICES: { [string]: { string } } = {
	Arrival = { "Data", "Analytics", "Session", "Tower" },
	Tower = {
		"Data",
		"Analytics",
		"Session",
		"Movement",
		"Ragdoll",
		"Inventory",
		"Crafting",
		"Wheel",
		"Survivors",
		"Progression",
		"Tower",
		"Residency",
		"Flats",
		"Economy",
		"Flea",
		"Bounties",
		"Relics",
		"Shop",
		"Matchmaker",
		"Social",
		"Admin",
	},
	Mall = { "Data", "Analytics", "Session" },
}
for _, name in RAID_SERVICES do
	table.insert(PLACE_SERVICES.Mall, name)
end
for _, name in { "Progression", "Shop", "Social", "Relics", "Bounties", "Admin" } do
	table.insert(PLACE_SERVICES.Mall, name)
end

local function resolvePlace(): (string, string)
	local placeId = game.PlaceId
	for name, ids in Config.Places do
		if typeof(ids) == "table" and (ids :: any).Dev then
			if placeId ~= 0 and (placeId == (ids :: any).Dev or placeId == (ids :: any).Live) then
				local universe = if placeId == (ids :: any).Live then "Live" else "Dev"
				return name, universe
			end
		end
	end
	if RunService:IsStudio() then
		-- An attribute on Workspace lets a test place override the default (tests/scenes set it).
		local override = workspace:GetAttribute("HellRaidersPlace")
		if typeof(override) == "string" and PLACE_SERVICES[override] then
			return override, "Studio"
		end
		return Config.Places.StudioDefault, "Studio"
	end
	error(`Bootstrap: PlaceId {placeId} is not in Config.Places (fill the Dev/Live ids, see Handoff.md)`)
end

local placeName, universe = resolvePlace()
print(`HellRaiders server · place {placeName} ({universe}) · PlaceId {game.PlaceId} · JobId {game.JobId}`)
workspace:SetAttribute("HellRaidersPlace", placeName)

Net.server()

local loaded: { { name: string, service: any } } = {}
for _, name in PLACE_SERVICES[placeName] do
	local module = Services:FindFirstChild(name)
	if module == nil then
		error(`Bootstrap: service {name} missing from Services`)
	end
	table.insert(loaded, { name = name, service = require(module) })
end

local t0 = os.clock()
for _, entry in loaded do
	local ok, err = pcall(entry.service.init)
	if not ok then
		error(`Bootstrap: {entry.name}.init failed: {err}`)
	end
end
for _, entry in loaded do
	local ok, err = pcall(entry.service.start)
	if not ok then
		error(`Bootstrap: {entry.name}.start failed: {err}`)
	end
	print(`  start {entry.name}`)
end
print(`HellRaiders server · {#loaded} services up in {string.format("%.1f", (os.clock() - t0) * 1000)} ms`)
AssetRegistry.printSummary()
