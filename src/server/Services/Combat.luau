--!strict
-- Service Combat: hit validation, 250 ms rewind buffer, damage by zone.
-- Owning blueprint file: 07. Built in step S6. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Combat = {}

Combat.Name = "Combat"

function Combat.init()
	-- Wired in S6.
end

function Combat.start()
	-- Started in S6.
end

return Combat
