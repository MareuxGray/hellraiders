--!strict
-- Service RaidFlow: raid state machine, clock, results, Orientation Run.
-- Owning blueprint file: 03. Built in step S3. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local RaidFlow = {}

RaidFlow.Name = "RaidFlow"

function RaidFlow.init()
	-- Wired in S3.
end

function RaidFlow.start()
	-- Started in S3.
end

return RaidFlow
