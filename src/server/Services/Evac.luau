--!strict
-- Service Evac: terminals, Red Alert, exits, departure check, Lockdown, Reopen.
-- Owning blueprint file: 10. Built in step S12. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Evac = {}

Evac.Name = "Evac"

function Evac.init()
	-- Wired in S12.
end

function Evac.start()
	-- Started in S12.
end

return Evac
