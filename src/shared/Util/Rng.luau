--!strict
-- Rng: seeded, deterministic random numbers (25 §25.2 Util/Rng). Pure Luau so server rolls (loot, struggle
-- needle seed, survivor generation) replay identically in tests and on the client when the seed is shared
-- (09 §9.2: client and server run the same needle from the same seed). SplitMix-style 32-bit generator.

export type Rng = { state: number }

local Rng = {}
Rng.__index = Rng

local MOD = 2 ^ 32

local function mix(x: number): number
	-- xorshift-multiply mixing on 32-bit integers (bit32 keeps everything in range)
	x = bit32.bxor(x, bit32.rshift(x, 16))
	x = (x * 0x45d9f3b) % MOD
	x = bit32.bxor(x, bit32.rshift(x, 16))
	x = (x * 0x45d9f3b) % MOD
	x = bit32.bxor(x, bit32.rshift(x, 16))
	return x
end

--- A new generator. Equal seeds give equal sequences. `seed` may be any number or string.
function Rng.new(seed: number | string): Rng
	local s: number
	if typeof(seed) == "string" then
		s = 0
		for i = 1, #(seed :: string) do
			s = (s * 31 + string.byte(seed :: string, i)) % MOD
		end
	else
		s = math.floor(seed :: number) % MOD
	end
	return setmetatable({ state = mix(s + 0x9e3779b9) }, Rng) :: any
end

--- Next raw 32-bit integer.
function Rng.nextRaw(self: Rng): number
	self.state = (self.state + 0x9e3779b9) % MOD
	return mix(self.state)
end

--- Uniform float in [0, 1).
function Rng.nextNumber(self: Rng, min: number?, max: number?): number
	local u = Rng.nextRaw(self) / MOD
	if min and max then
		return min + u * (max - min)
	end
	return u
end

--- Uniform integer in [a, b].
function Rng.nextInteger(self: Rng, a: number, b: number): number
	assert(b >= a, "nextInteger: b < a")
	return a + math.floor(Rng.nextNumber(self) * (b - a + 1))
end

--- One element of a non-empty list.
function Rng.pick<T>(self: Rng, list: { T }): T
	assert(#list > 0, "pick: empty list")
	return list[Rng.nextInteger(self, 1, #list)]
end

--- Weighted pick over { { value, weight } ... } or over a list with a weight accessor.
function Rng.weighted<T>(self: Rng, entries: { T }, weightOf: (T) -> number): T
	local total = 0
	for _, e in entries do
		total += weightOf(e)
	end
	assert(total > 0, "weighted: total weight 0")
	local target = Rng.nextNumber(self) * total
	local acc = 0
	for _, e in entries do
		acc += weightOf(e)
		if target < acc then
			return e
		end
	end
	return entries[#entries]
end

--- In-place Fisher–Yates shuffle.
function Rng.shuffle<T>(self: Rng, list: { T }): { T }
	for i = #list, 2, -1 do
		local j = Rng.nextInteger(self, 1, i)
		list[i], list[j] = list[j], list[i]
	end
	return list
end

--- Survivor attribute generation (13 §13.2): start every attribute at Config.Attr.Min, then add the remaining
--- points one at a time to random attributes below Config.Attr.Max. Pure so 10,000-run tests can verify it.
function Rng.generateAttributes(
	self: Rng,
	names: { string },
	min: number,
	max: number,
	pool: number
): { [string]: number }
	local attrs: { [string]: number } = {}
	for _, n in names do
		attrs[n] = min
	end
	local left = pool - min * #names
	assert(left >= 0 and left <= (max - min) * #names, "generateAttributes: pool not reachable")
	while left > 0 do
		local eligible = {}
		for _, n in names do
			if attrs[n] < max then
				table.insert(eligible, n)
			end
		end
		local n = Rng.pick(self, eligible)
		attrs[n] += 1
		left -= 1
	end
	return attrs
end

return Rng
