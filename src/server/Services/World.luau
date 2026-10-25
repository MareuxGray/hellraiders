--!strict
-- Service World: shutters, doors, glass, generators, alarms, elevators, destructibles.
-- Owning blueprint file: 06. Built in step S9. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local World = {}

World.Name = "World"

function World.init()
	-- Wired in S9.
end

function World.start()
	-- Started in S9.
end

return World
