--!strict
-- Controller Traverse: Adaptive Motions traversal (ported, extended).
-- Owning blueprint file: 04 §4.6. Built in step S5. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Traverse = {}

Traverse.Name = "Traverse"

function Traverse.init()
	-- Wired in S5.
end

function Traverse.start()
	-- Started in S5.
end

return Traverse
