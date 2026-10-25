--!strict
-- Controller Gait: ground locomotion clip blending (ported).
-- Owning blueprint file: 04 §4.2. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Gait = {}

Gait.Name = "Gait"

function Gait.init()
	-- Wired in S1.
end

function Gait.start()
	-- Started in S1.
end

return Gait
