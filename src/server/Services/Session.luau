--!strict
-- Service Session: join flow, claim/respawn rule (ported), teleports.
-- Owning blueprint file: 25 §25.2, 03. Built in step S1 (claim), S3 (teleports). S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Session = {}

Session.Name = "Session"

function Session.init()
	-- Wired in S1 (claim), S3 (teleports).
end

function Session.start()
	-- Started in S1 (claim), S3 (teleports).
end

return Session
