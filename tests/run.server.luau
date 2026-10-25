--!strict
-- Studio test runner (22 §22.8, 25 §25.2). Runs every tests/unit/*.spec.luau with TestEZ when the place starts in
-- Studio with the Workspace attribute RunTests = true, or when required from the command bar:
--   require(game.ServerScriptService.Tests.run)()
-- The same spec files run headlessly with Lune: `lune run tests/lune/run`.

local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local function run(): boolean
	local TestEZ = require(ServerScriptService:WaitForChild("DevPackages"):WaitForChild("TestEZ")) :: any
	local unit = ServerScriptService:WaitForChild("Tests"):WaitForChild("unit")
	local results = TestEZ.TestBootstrap:run({ unit })
	print(`TESTS passed {results.successCount} failed {results.failureCount} skipped {results.skippedCount}`)
	return results.failureCount == 0
end

if RunService:IsStudio() and workspace:GetAttribute("RunTests") == true then
	task.defer(run)
end

return run
