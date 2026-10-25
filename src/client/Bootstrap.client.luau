--!strict
-- Client Bootstrap (25 §25.2): waits for the remotes, requires every controller for this place, calls every
-- `init()` then every `start()`, and prints the PLACEHOLDERS summary (25 §25.3). The server writes the place name
-- to the Workspace attribute HellRaidersPlace; raid-only controllers start only in the Mall.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Net = require(Shared:WaitForChild("Net"))
local AssetRegistry = require(Shared:WaitForChild("AssetRegistry"))

local Controllers = script.Parent:WaitForChild("Controllers")

local COMMON =
	{ "Input", "CameraRig", "MoveSpeed", "Gait", "Body", "Actions", "RemotePose", "Audio", "Hud", "Ui", "AdminClient" }
local RAID_ONLY = {
	"ProcPose",
	"Traverse",
	"RailPlanner",
	"Aim",
	"Weapons",
	"MeleeClient",
	"ThrowClient",
	"Fear",
	"Struggle",
	"Reveal",
}
local TOWER_ONLY = { "Build" }

Net.client()

local placeName = workspace:GetAttribute("HellRaidersPlace")
while typeof(placeName) ~= "string" do
	workspace:GetAttributeChangedSignal("HellRaidersPlace"):Wait()
	placeName = workspace:GetAttribute("HellRaidersPlace")
end
print(`HellRaiders client · place {placeName}`)

local names = table.clone(COMMON)
if placeName == "Mall" then
	for _, n in RAID_ONLY do
		table.insert(names, n)
	end
elseif placeName == "Tower" then
	for _, n in TOWER_ONLY do
		table.insert(names, n)
	end
end

local loaded: { { name: string, controller: any } } = {}
for _, name in names do
	local module = Controllers:FindFirstChild(name)
	if module == nil then
		error(`Bootstrap: controller {name} missing from Controllers`)
	end
	table.insert(loaded, { name = name, controller = require(module) })
end

for _, entry in loaded do
	local ok, err = pcall(entry.controller.init)
	if not ok then
		error(`Bootstrap: {entry.name}.init failed: {err}`)
	end
end
for _, entry in loaded do
	local ok, err = pcall(entry.controller.start)
	if not ok then
		error(`Bootstrap: {entry.name}.start failed: {err}`)
	end
	print(`  start {entry.name}`)
end
print(`HellRaiders client · {#loaded} controllers up`)
AssetRegistry.printSummary()
