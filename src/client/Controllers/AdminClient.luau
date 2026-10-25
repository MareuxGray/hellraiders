--!strict
-- Controller AdminClient: admin menu front end and debug overlay host.
-- Owning blueprint file: 22 §22.2, §22.4. Built in step S1. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local AdminClient = {}

AdminClient.Name = "AdminClient"

function AdminClient.init()
	-- Wired in S1.
end

function AdminClient.start()
	-- Started in S1.
end

return AdminClient
