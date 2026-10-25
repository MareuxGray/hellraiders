--!strict
-- Controller RailPlanner: traversal edge planning (ported).
-- Owning blueprint file: 04 §4.6. Built in step S5. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local RailPlanner = {}

RailPlanner.Name = "RailPlanner"

function RailPlanner.init()
	-- Wired in S5.
end

function RailPlanner.start()
	-- Started in S5.
end

return RailPlanner
