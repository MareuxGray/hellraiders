--!strict
-- Controller ProcPose: joints during traversal (ported).
-- Owning blueprint file: 04 §4.6. Built in step S5. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local ProcPose = {}

ProcPose.Name = "ProcPose"

function ProcPose.init()
	-- Wired in S5.
end

function ProcPose.start()
	-- Started in S5.
end

return ProcPose
