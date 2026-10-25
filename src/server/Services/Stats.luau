--!strict
-- Service Stats: Stats v2 primary stats at 10 Hz, owner-only StatsState packet.
-- Owning blueprint file: 05. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Stats = {}

Stats.Name = "Stats"

function Stats.init()
	-- Wired in S1.
end

function Stats.start()
	-- Started in S1.
end

return Stats
