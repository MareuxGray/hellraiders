--!strict
-- Controller Actions: action clips: roll, slide, pickup, throw, reload… (ported).
-- Owning blueprint file: 04 §4.1. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Actions = {}

Actions.Name = "Actions"

function Actions.init()
	-- Wired in S1.
end

function Actions.start()
	-- Started in S1.
end

return Actions
