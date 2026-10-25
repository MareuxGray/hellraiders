--!strict
-- Service Survivors: generation, Survivor Draft, rerolls, retirement.
-- Owning blueprint file: 13 §13.1–13.3. Built in step S14. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Survivors = {}

Survivors.Name = "Survivors"

function Survivors.init()
	-- Wired in S14.
end

function Survivors.start()
	-- Started in S14.
end

return Survivors
