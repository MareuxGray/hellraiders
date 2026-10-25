--!strict
-- Service Throwables: server-simulated throwables (ported, extended).
-- Owning blueprint file: 07 §7.12. Built in step S6. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Throwables = {}

Throwables.Name = "Throwables"

function Throwables.init()
	-- Wired in S6.
end

function Throwables.start()
	-- Started in S6.
end

return Throwables
