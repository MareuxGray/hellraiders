--!strict
-- Controller Weapons: weapon slots, firing client side, recoil, reload.
-- Owning blueprint file: 07. Built in step S6. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Weapons = {}

Weapons.Name = "Weapons"

function Weapons.init()
	-- Wired in S6.
end

function Weapons.start()
	-- Started in S6.
end

return Weapons
