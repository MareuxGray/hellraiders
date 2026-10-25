--!strict
-- Controller MoveSpeed: Humanoid.WalkSpeed owner from Config and the stats packet.
-- Owning blueprint file: 04 §4.1. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local MoveSpeed = {}

MoveSpeed.Name = "MoveSpeed"

function MoveSpeed.init()
	-- Wired in S1.
end

function MoveSpeed.start()
	-- Started in S1.
end

return MoveSpeed
