--!strict
-- Service Shop: products, receipts, PolicyService.
-- Owning blueprint file: 19. Built in step F11. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.

local Shop = {}

Shop.Name = "Shop"

function Shop.init()
	-- Wired in F11.
end

function Shop.start()
	-- Started in F11.
end

return Shop
