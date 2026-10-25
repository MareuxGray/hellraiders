--!strict
-- Service Progression: XP, levels, reputations, contracts, achievements, collection.
-- Owning blueprint file: 13. Built in step S14, F10. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Progression = {}

Progression.Name = "Progression"

function Progression.init()
	-- Wired in S14, F10.
end

function Progression.start()
	-- Started in S14, F10.
end

return Progression
