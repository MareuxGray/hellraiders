--!strict
-- Service Tower: tower records, live instances, annexes, routing.
-- Owning blueprint file: 14. Built in step S3 (routing), F1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Tower = {}

Tower.Name = "Tower"

function Tower.init()
	-- Wired in S3 (routing), F1.
end

function Tower.start()
	-- Started in S3 (routing), F1.
end

return Tower
