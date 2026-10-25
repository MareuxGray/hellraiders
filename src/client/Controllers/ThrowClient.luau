--!strict
-- Controller ThrowClient: throw wind-up and aim.
-- Owning blueprint file: 07 §7.12. Built in step S6. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local ThrowClient = {}

ThrowClient.Name = "ThrowClient"

function ThrowClient.init()
	-- Wired in S6.
end

function ThrowClient.start()
	-- Started in S6.
end

return ThrowClient
