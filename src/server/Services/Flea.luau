--!strict
-- Service Flea: the Flea market.
-- Owning blueprint file: 16 §16.3. Built in step F4. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Flea = {}

Flea.Name = "Flea"

function Flea.init()
	-- Wired in F4.
end

function Flea.start()
	-- Started in F4.
end

return Flea
