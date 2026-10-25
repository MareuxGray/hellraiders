--!strict
-- Controller Audio: music layers, zones, occlusion.
-- Owning blueprint file: 24. Built in step S8+. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Audio = {}

Audio.Name = "Audio"

function Audio.init()
	-- Wired in S8+.
end

function Audio.start()
	-- Started in S8+.
end

return Audio
