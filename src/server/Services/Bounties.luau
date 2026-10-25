--!strict
-- Service Bounties: anonymous bounties, Dogtags, roles.
-- Owning blueprint file: 17. Built in step F6. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Bounties = {}

Bounties.Name = "Bounties"

function Bounties.init()
	-- Wired in F6.
end

function Bounties.start()
	-- Started in F6.
end

return Bounties
