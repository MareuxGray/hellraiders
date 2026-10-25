--!strict
-- Service Matchmaker: MemoryStore queue and leader election.
-- Owning blueprint file: 20 §20.8. Built in step S15. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Matchmaker = {}

Matchmaker.Name = "Matchmaker"

function Matchmaker.init()
	-- Wired in S15.
end

function Matchmaker.start()
	-- Started in S15.
end

return Matchmaker
