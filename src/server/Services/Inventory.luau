--!strict
-- Service Inventory: grid, slots, containers, corpses (ported, extended).
-- Owning blueprint file: 11 §11.5. Built in step S4. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Inventory = {}

Inventory.Name = "Inventory"

function Inventory.init()
	-- Wired in S4.
end

function Inventory.start()
	-- Started in S4.
end

return Inventory
