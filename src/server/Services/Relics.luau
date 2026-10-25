--!strict
-- Service Relics: Relic records, world pool, vinyls.
-- Owning blueprint file: 18. Built in step F7. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Relics = {}

Relics.Name = "Relics"

function Relics.init()
	-- Wired in F7.
end

function Relics.start()
	-- Started in F7.
end

return Relics
