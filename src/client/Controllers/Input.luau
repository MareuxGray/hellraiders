--!strict
-- Controller Input: every binding, device detection, rebinding storage.
-- Owning blueprint file: 21 §21.2. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Input = {}

Input.Name = "Input"

function Input.init()
	-- Wired in S1.
end

function Input.start()
	-- Started in S1.
end

return Input
