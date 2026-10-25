--!strict
-- Controller MeleeClient: melee, shove, takedown client.
-- Owning blueprint file: 07 §7.9–7.11. Built in step S6. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local MeleeClient = {}

MeleeClient.Name = "MeleeClient"

function MeleeClient.init()
	-- Wired in S6.
end

function MeleeClient.start()
	-- Started in S6.
end

return MeleeClient
