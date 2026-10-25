--!strict
-- Service AI: Director, Walker, Crawler, Sprinter, Janitor, Senses and Paths live as children of this module.
-- Owning blueprint file: 08. Built in step S8. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.
-- Children: Director, Walker, Crawler, Sprinter, Janitor, Senses, Paths. The AI is built new in S8 (08 code decision).
local AI = {}

AI.Name = "AI"

function AI.init()
	-- Wired in S8.
end

function AI.start()
	-- Started in S8.
end

return AI
