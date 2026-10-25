--!strict
-- Service Wheel: Blueprint Wheel and Fixed Trade-up.
-- Owning blueprint file: 12 §12.5–12.6. Built in step F8. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Wheel = {}

Wheel.Name = "Wheel"

function Wheel.init()
	-- Wired in F8.
end

function Wheel.start()
	-- Started in F8.
end

return Wheel
