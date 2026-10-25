--!strict
-- Controller Fear: post-processing and camera requests from fear and health.
-- Owning blueprint file: 05 §5.4, §5.6. Built in step S7. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Fear = {}

Fear.Name = "Fear"

function Fear.init()
	-- Wired in S7.
end

function Fear.start()
	-- Started in S7.
end

return Fear
