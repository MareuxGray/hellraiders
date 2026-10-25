--!strict
-- Service Social: voice routing, quick lines, pings, emotes, parties, referrals.
-- Owning blueprint file: 20. Built in step S15. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Social = {}

Social.Name = "Social"

function Social.init()
	-- Wired in S15.
end

function Social.start()
	-- Started in S15.
end

return Social
