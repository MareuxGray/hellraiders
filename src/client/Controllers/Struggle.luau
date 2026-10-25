--!strict
-- Controller Struggle: struggle QTE client.
-- Owning blueprint file: 09 §9.2. Built in step S10. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Struggle = {}

Struggle.Name = "Struggle"

function Struggle.init()
	-- Wired in S10.
end

function Struggle.start()
	-- Started in S10.
end

return Struggle
