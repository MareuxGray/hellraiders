--!strict
-- Service Crafting: in-raid and flat workbench crafting.
-- Owning blueprint file: 12. Built in step S14, S16. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Crafting = {}

Crafting.Name = "Crafting"

function Crafting.init()
	-- Wired in S14, S16.
end

function Crafting.start()
	-- Started in S14, S16.
end

return Crafting
