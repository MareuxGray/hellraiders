--!strict
-- Service Admin: admin commands (server side of Remotes.Admin).
-- Owning blueprint file: 22. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Admin = {}

Admin.Name = "Admin"

function Admin.init()
	-- Wired in S1.
end

function Admin.start()
	-- Started in S1.
end

return Admin
