--!strict
-- Controller Body: model yaw, leg twist, lean, foot grounding (ported).
-- Owning blueprint file: 04 §4.3. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Body = {}

Body.Name = "Body"

function Body.init()
	-- Wired in S1.
end

function Body.start()
	-- Started in S1.
end

return Body
