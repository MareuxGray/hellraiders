--!strict
-- Service Ragdoll: Motor6D ↔ BallSocket swap, get-up (ported).
-- Owning blueprint file: 04 §4.8. Built in step S5. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Ragdoll = {}

Ragdoll.Name = "Ragdoll"

function Ragdoll.init()
	-- Wired in S5.
end

function Ragdoll.start()
	-- Started in S5.
end

return Ragdoll
