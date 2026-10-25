-- Service and controller contract (25 §25.2): every module in the layout exists and exports init() and start().
local ServerScriptService = game:GetService("ServerScriptService")
local Services = ServerScriptService.Server.Services

local EXPECTED_SERVICES = {
	"Data",
	"Session",
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
	"Analytics",
}
local EXPECTED_AI = { "Director", "Walker", "Crawler", "Sprinter", "Janitor", "Senses", "Paths" }

return function()
	describe("Services", function()
		it("every 25 §25.2 service exists and follows the init/start contract", function()
			for _, name in EXPECTED_SERVICES do
				local module = Services:FindFirstChild(name)
				expect(module).to.be.ok()
				local service = require(module)
				expect(service.Name).to.equal(name)
				expect(service.init).to.be.a("function")
				expect(service.start).to.be.a("function")
				expect(function()
					service.init()
					service.start()
				end).never.to.throw()
			end
		end)

		it("AI has its seven children", function()
			for _, name in EXPECTED_AI do
				expect(Services.AI:FindFirstChild(name)).to.be.ok()
			end
		end)
	end)
end
