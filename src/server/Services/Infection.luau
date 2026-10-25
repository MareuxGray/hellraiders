--!strict
-- Service Infection: struggles, bites, Sleepers, symptoms, sabotage, cures.
-- Owning blueprint file: 09. Built in step S10. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Infection = {}

Infection.Name = "Infection"

function Infection.init()
	-- Wired in S10.
end

function Infection.start()
	-- Started in S10.
end

return Infection
