--!strict
-- Controller Aim: aiming, no crosshair on PC, mobile dot.
-- Owning blueprint file: 07 §7.2. Built in step S6. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Aim = {}

Aim.Name = "Aim"

function Aim.init()
	-- Wired in S6.
end

function Aim.start()
	-- Started in S6.
end

return Aim
