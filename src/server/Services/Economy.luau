--!strict
-- Service Economy: vendors, insurance, repossession, mail.
-- Owning blueprint file: 16. Built in step S16, F4, F5. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Economy = {}

Economy.Name = "Economy"

function Economy.init()
	-- Wired in S16, F4, F5.
end

function Economy.start()
	-- Started in S16, F4, F5.
end

return Economy
