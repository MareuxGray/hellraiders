--!strict
-- Service Loot: rolling, reveal timing, world item claims.
-- Owning blueprint file: 11 §11.6. Built in step S4. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Loot = {}

Loot.Name = "Loot"

function Loot.init()
	-- Wired in S4.
end

function Loot.start()
	-- Started in S4.
end

return Loot
