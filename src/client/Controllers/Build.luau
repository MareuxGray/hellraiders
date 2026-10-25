--!strict
-- Controller Build: flat build mode.
-- Owning blueprint file: 15 §15.7. Built in step F2. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Build = {}

Build.Name = "Build"

function Build.init()
	-- Wired in F2.
end

function Build.start()
	-- Started in F2.
end

return Build
