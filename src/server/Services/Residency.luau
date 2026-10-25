--!strict
-- Service Residency: residency transactions, waitlists, Move-in, relocation.
-- Owning blueprint file: 14 §14.6–14.11. Built in step F1, F3. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Residency = {}

Residency.Name = "Residency"

function Residency.init()
	-- Wired in F1, F3.
end

function Residency.start()
	-- Started in F1, F3.
end

return Residency
