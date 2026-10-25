--!strict
-- Controller Reveal: container reveal client.
-- Owning blueprint file: 11 §11.4. Built in step S4. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Reveal = {}

Reveal.Name = "Reveal"

function Reveal.init()
	-- Wired in S4.
end

function Reveal.start()
	-- Started in S4.
end

return Reveal
