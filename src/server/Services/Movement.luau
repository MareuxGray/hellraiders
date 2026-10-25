--!strict
-- Service Movement: server checks for speed and teleports.
-- Owning blueprint file: 25 §25.9. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Movement = {}

Movement.Name = "Movement"

function Movement.init()
	-- Wired in S1.
end

function Movement.start()
	-- Started in S1.
end

return Movement
