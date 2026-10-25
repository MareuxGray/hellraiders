--!strict
-- Grid: inventory grid maths (11 §11.5). Pure Luau, no Roblox types, so Services.Inventory, the client inventory
-- UI and the unit tests share one implementation. Cells are 1-based (x across, y down). Items occupy w×h cells
-- and may be rotated (swaps w and h). Stacks are the caller's business: the grid only knows occupancy.

export type Placed = { uid: string, x: number, y: number, w: number, h: number, rot: boolean }
export type Grid = {
	w: number,
	h: number,
	cells: { [number]: string? }, -- index (y - 1) * w + x → uid
	items: { [string]: Placed },
}

local Grid = {}

function Grid.new(w: number, h: number): Grid
	assert(w >= 1 and h >= 1, "grid must be at least 1×1")
	return { w = w, h = h, cells = {}, items = {} }
end

local function index(grid: Grid, x: number, y: number): number
	return (y - 1) * grid.w + x
end

--- Effective footprint after rotation.
function Grid.footprint(w: number, h: number, rot: boolean): (number, number)
	if rot then
		return h, w
	end
	return w, h
end

--- True if a w×h item (already rotated) fits at x, y ignoring the cells held by `ignoreUid`.
function Grid.fits(grid: Grid, x: number, y: number, w: number, h: number, ignoreUid: string?): boolean
	if x < 1 or y < 1 or x + w - 1 > grid.w or y + h - 1 > grid.h then
		return false
	end
	for cy = y, y + h - 1 do
		for cx = x, x + w - 1 do
			local occupant = grid.cells[index(grid, cx, cy)]
			if occupant ~= nil and occupant ~= ignoreUid then
				return false
			end
		end
	end
	return true
end

--- Places an item. Returns false if it doesn't fit. Rejects duplicate uids (25 §25.9: duplicate uids rejected).
function Grid.place(grid: Grid, uid: string, x: number, y: number, w: number, h: number, rot: boolean): boolean
	if grid.items[uid] ~= nil then
		return false
	end
	local fw, fh = Grid.footprint(w, h, rot)
	if not Grid.fits(grid, x, y, fw, fh) then
		return false
	end
	for cy = y, y + fh - 1 do
		for cx = x, x + fw - 1 do
			grid.cells[index(grid, cx, cy)] = uid
		end
	end
	grid.items[uid] = { uid = uid, x = x, y = y, w = w, h = h, rot = rot }
	return true
end

function Grid.remove(grid: Grid, uid: string): Placed?
	local placed = grid.items[uid]
	if placed == nil then
		return nil
	end
	local fw, fh = Grid.footprint(placed.w, placed.h, placed.rot)
	for cy = placed.y, placed.y + fh - 1 do
		for cx = placed.x, placed.x + fw - 1 do
			grid.cells[index(grid, cx, cy)] = nil
		end
	end
	grid.items[uid] = nil
	return placed
end

--- Moves (and optionally rotates) an item already in the grid. Atomic: on failure nothing changes.
function Grid.move(grid: Grid, uid: string, x: number, y: number, rot: boolean): boolean
	local placed = grid.items[uid]
	if placed == nil then
		return false
	end
	local fw, fh = Grid.footprint(placed.w, placed.h, rot)
	if not Grid.fits(grid, x, y, fw, fh, uid) then
		return false
	end
	Grid.remove(grid, uid)
	return Grid.place(grid, uid, x, y, placed.w, placed.h, rot)
end

--- First free top-left position for a w×h item, scanning top-left to bottom-right (pickup "first free slot",
--- 11 §11.7). Tries unrotated then rotated. Returns x, y, rot or nil.
function Grid.findFree(grid: Grid, w: number, h: number): (number?, number?, boolean?)
	for _, rot in { false, true } do
		local fw, fh = Grid.footprint(w, h, rot)
		if rot and fw == fh then
			break
		end
		for y = 1, grid.h - fh + 1 do
			for x = 1, grid.w - fw + 1 do
				if Grid.fits(grid, x, y, fw, fh) then
					return x, y, rot
				end
			end
		end
	end
	return nil, nil, nil
end

function Grid.at(grid: Grid, x: number, y: number): string?
	if x < 1 or y < 1 or x > grid.w or y > grid.h then
		return nil
	end
	return grid.cells[index(grid, x, y)]
end

function Grid.count(grid: Grid): number
	local n = 0
	for _ in grid.items do
		n += 1
	end
	return n
end

function Grid.freeCells(grid: Grid): number
	local used = 0
	for _ in grid.cells do
		used += 1
	end
	return grid.w * grid.h - used
end

--- Serialises to the profile's item list shape { uid, x, y, rot } (25 §25.5), sorted by uid for stable saves.
function Grid.serialize(grid: Grid): { Placed }
	local out = {}
	for _, placed in grid.items do
		table.insert(out, table.clone(placed))
	end
	table.sort(out, function(a, b)
		return a.uid < b.uid
	end)
	return out
end

--- Rebuilds a grid from serialised items; items that no longer fit are returned as overflow (15 §15.6).
function Grid.deserialize(w: number, h: number, items: { Placed }): (Grid, { Placed })
	local grid = Grid.new(w, h)
	local overflow = {}
	for _, placed in items do
		if not Grid.place(grid, placed.uid, placed.x, placed.y, placed.w, placed.h, placed.rot) then
			table.insert(overflow, placed)
		end
	end
	return grid, overflow
end

return Grid
