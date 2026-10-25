--!strict
-- Service Analytics: AnalyticsService events and the audit log.
-- Owning blueprint file: 25 §25.8. Built in step S3. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Analytics = {}

Analytics.Name = "Analytics"

function Analytics.init()
	-- Wired in S3.
end

function Analytics.start()
	-- Started in S3.
end

return Analytics
