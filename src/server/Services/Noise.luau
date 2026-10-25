--!strict
-- Service Noise: noise events, floor rules, multi-floor.
-- Owning blueprint file: 06 §6.1. Built in step S8. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Noise = {}

Noise.Name = "Noise"

function Noise.init()
	-- Wired in S8.
end

function Noise.start()
	-- Started in S8.
end

return Noise
