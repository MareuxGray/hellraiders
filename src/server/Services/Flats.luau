--!strict
-- Service Flats: interiors, furniture, displays.
-- Owning blueprint file: 15. Built in step S16, F2. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Flats = {}

Flats.Name = "Flats"

function Flats.init()
	-- Wired in S16, F2.
end

function Flats.start()
	-- Started in S16, F2.
end

return Flats
