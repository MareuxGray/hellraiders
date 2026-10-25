--!strict
-- Service Mutants: Stalker, Supermutant, Ghost tools.
-- Owning blueprint file: 09 §9.10–9.14. Built in step S10, S13. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Mutants = {}

Mutants.Name = "Mutants"

function Mutants.init()
	-- Wired in S10, S13.
end

function Mutants.start()
	-- Started in S10, S13.
end

return Mutants
