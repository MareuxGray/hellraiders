--!strict
-- Net (25 §25.4): every remote channel, the per-player token-bucket rate limits and the argument validator.
-- The server creates all remotes in ReplicatedStorage.Net at start (`Net.server()`); clients wait for them
-- (`Net.client()`). RemoteFunctions exist only for UI queries that need a reply and for the single admin remote
-- (22 §22.1); they are never called server → client.
-- The pure parts (channel table, Bucket, check) run in Lune for tests.

local Config = require(script.Parent.Config)

export type Direction = "ClientToServer" | "ServerToClient" | "Both"
export type Channel = {
	name: string,
	kind: "RemoteEvent" | "RemoteFunction",
	direction: Direction,
	rate: { PerSecond: number, Burst: number }?, -- client → server limit; nil = Config.Net.RateDefault
	owner: string, -- blueprint section
	note: string?,
}

local Net = {}

Net.Channels = table.freeze({
	{
		name = "Input",
		kind = "RemoteEvent",
		direction = "ClientToServer",
		owner = "25 §25.4",
		note = "actions: context, sprint state, crouch, roll, slide",
	},
	{
		name = "Fire",
		kind = "RemoteEvent",
		direction = "ClientToServer",
		rate = Config.Net.RateFire,
		owner = "07 §7.2",
		note = "capped per weapon RPM in Services.Combat",
	},
	{ name = "Melee", kind = "RemoteEvent", direction = "ClientToServer", owner = "07 §7.9" },
	{ name = "Throw", kind = "RemoteEvent", direction = "ClientToServer", owner = "07 §7.12" },
	{
		name = "Inventory",
		kind = "RemoteEvent",
		direction = "Both",
		rate = Config.Net.RateInventory,
		owner = "11 §11.5",
	},
	{ name = "Container", kind = "RemoteEvent", direction = "Both", owner = "11 §11.4" },
	{
		name = "StatsState",
		kind = "RemoteEvent",
		direction = "ServerToClient",
		owner = "05 §5.1",
		note = "owner only",
	},
	{
		name = "PoseState",
		kind = "RemoteEvent",
		direction = "Both",
		rate = Config.Net.RatePose,
		owner = "04 §4.10",
		note = "client → server → others, 20 Hz",
	},
	{
		name = "Noise",
		kind = "RemoteEvent",
		direction = "ServerToClient",
		owner = "06 §6.1",
		note = "clients in range, for audio",
	},
	{ name = "Struggle", kind = "RemoteEvent", direction = "Both", owner = "09 §9.2" },
	{ name = "Raid", kind = "RemoteEvent", direction = "Both", owner = "03", note = "state, clock sync" },
	{ name = "Evac", kind = "RemoteEvent", direction = "Both", owner = "10" },
	{
		name = "Infection",
		kind = "RemoteEvent",
		direction = "ServerToClient",
		owner = "09",
		note = "owner only; never reveals a Sleeper to others",
	},
	{ name = "Ui", kind = "RemoteEvent", direction = "Both", owner = "21", note = "panel data" },
	{
		name = "UiQuery",
		kind = "RemoteFunction",
		direction = "ClientToServer",
		owner = "21",
		note = "UI queries that need a reply",
	},
	{ name = "Shop", kind = "RemoteEvent", direction = "Both", owner = "19" },
	{
		name = "ShopQuery",
		kind = "RemoteFunction",
		direction = "ClientToServer",
		owner = "19",
		note = "prices, odds tables, policy",
	},
	{ name = "Social", kind = "RemoteEvent", direction = "Both", owner = "20" },
	{
		name = "Admin",
		kind = "RemoteFunction",
		direction = "ClientToServer",
		owner = "22 §22.1",
		note = "the one admin remote; server checks admin status every call",
	},
} :: { Channel })

local channelByName: { [string]: Channel } = {}
for _, ch in Net.Channels do
	channelByName[ch.name] = ch
end
Net.ChannelByName = table.freeze(channelByName)

-- ---------------------------------------------------------------- Token bucket (25 §25.4)

export type Bucket = {
	tokens: number,
	perSecond: number,
	burst: number,
	last: number,
	dropped: number,
	strikes: { number }, -- timestamps of strikes in the last minute
}

local Bucket = {}
Net.Bucket = Bucket

function Bucket.new(perSecond: number, burst: number, now: number?): Bucket
	return { tokens = burst, perSecond = perSecond, burst = burst, last = now or 0, dropped = 0, strikes = {} }
end

--- Takes one token at time `now` (seconds). Returns true if allowed. Over the limit: drop and count; a drop
--- is a strike, and `Config.Net.StrikesPerMinute` strikes in 60 s make `strike()` return true once (SecurityEvent).
function Bucket.take(bucket: Bucket, now: number): boolean
	local elapsed = math.max(0, now - bucket.last)
	bucket.last = now
	bucket.tokens = math.min(bucket.burst, bucket.tokens + elapsed * bucket.perSecond)
	if bucket.tokens >= 1 then
		bucket.tokens -= 1
		return true
	end
	bucket.dropped += 1
	table.insert(bucket.strikes, now)
	return false
end

--- True when the bucket has reached the strike threshold within the last 60 s (then clears the strikes).
function Bucket.strike(bucket: Bucket, now: number): boolean
	local recent = {}
	for _, t in bucket.strikes do
		if now - t <= 60 then
			table.insert(recent, t)
		end
	end
	bucket.strikes = recent
	if #recent >= Config.Net.StrikesPerMinute then
		bucket.strikes = {}
		return true
	end
	return false
end

--- Rate config for a channel.
function Net.rateFor(channelName: string): { PerSecond: number, Burst: number }
	local ch = channelByName[channelName]
	return (ch and ch.rate) or Config.Net.RateDefault
end

-- ---------------------------------------------------------------- Schema validation (25 §25.4)

-- Schema: { fieldName = "number" | "string" | "boolean" | "Vector3" | "CFrame" | "Instance" | "table" |
--           { type = ..., min = n?, max = n?, maxLength = n?, oneOf = {...}?, optional = true? } }
export type FieldRule = {
	type: string,
	min: number?,
	max: number?,
	maxLength: number?,
	oneOf: { any }?,
	optional: boolean?,
}
export type Schema = { [string]: string | FieldRule }

local function ruleOf(rule: string | FieldRule): FieldRule
	if typeof(rule) == "string" then
		return { type = rule :: string }
	end
	return rule :: FieldRule
end

--- Validates `args` (a table of named fields) against `schema`. Returns ok, problem.
--- Numbers must be finite; strings are length-capped (default 256); unknown fields are rejected.
function Net.check(schema: Schema, args: any): (boolean, string?)
	if typeof(args) ~= "table" then
		return false, "args not a table"
	end
	for field, rawRule in schema do
		local rule = ruleOf(rawRule)
		local value = (args :: any)[field]
		if value == nil then
			if rule.optional then
				continue
			end
			return false, `missing {field}`
		end
		local t = typeof(value)
		if t ~= rule.type then
			return false, `{field}: expected {rule.type}, got {t}`
		end
		if t == "number" then
			local n = value :: number
			if n ~= n or n == math.huge or n == -math.huge then
				return false, `{field}: not finite`
			end
			if rule.min and n < rule.min then
				return false, `{field}: below {rule.min}`
			end
			if rule.max and n > rule.max then
				return false, `{field}: above {rule.max}`
			end
		elseif t == "string" then
			local maxLength = rule.maxLength or 256
			if #(value :: string) > maxLength then
				return false, `{field}: longer than {maxLength}`
			end
		end
		if rule.oneOf then
			local found = false
			for _, allowed in rule.oneOf do
				if allowed == value then
					found = true
					break
				end
			end
			if not found then
				return false, `{field}: not an allowed value`
			end
		end
	end
	for field in args :: { [any]: any } do
		if typeof(field) ~= "string" or schema[field] == nil then
			return false, `unexpected field {tostring(field)}`
		end
	end
	return true, nil
end

-- ---------------------------------------------------------------- Security event listeners

local securityListeners: { (userId: number, channel: string, detail: string) -> () } = {}

--- Services.Analytics subscribes here to write `SecurityEvent` audit lines (25 §25.8).
function Net.onSecurityEvent(fn: (userId: number, channel: string, detail: string) -> ()): () -> ()
	table.insert(securityListeners, fn)
	return function()
		local i = table.find(securityListeners, fn)
		if i then
			table.remove(securityListeners, i)
		end
	end
end

function Net.raiseSecurityEvent(userId: number, channel: string, detail: string)
	for _, fn in securityListeners do
		fn(userId, channel, detail)
	end
end

-- ---------------------------------------------------------------- Roblox side

local remotes: { [string]: Instance } = {}
local buckets: { [number]: { [string]: Bucket } } = {}

local function folder(): Instance
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local existing = ReplicatedStorage:FindFirstChild("Net")
	if existing then
		return existing
	end
	local f = Instance.new("Folder")
	f.Name = "Net"
	f.Parent = ReplicatedStorage
	return f
end

--- Server: create every remote (idempotent) and the per-player bucket bookkeeping.
function Net.server()
	local f = folder()
	for _, ch in Net.Channels do
		local remote = f:FindFirstChild(ch.name)
		if remote == nil then
			remote = Instance.new(ch.kind)
			remote.Name = ch.name
			remote.Parent = f
		end
		remotes[ch.name] = remote
	end
	local Players = game:GetService("Players")
	Players.PlayerRemoving:Connect(function(player)
		buckets[player.UserId] = nil
	end)
	return remotes
end

--- Client: wait for every remote.
function Net.client()
	local f = game:GetService("ReplicatedStorage"):WaitForChild("Net")
	for _, ch in Net.Channels do
		remotes[ch.name] = f:WaitForChild(ch.name)
	end
	return remotes
end

function Net.remote(name: string): Instance
	local r = remotes[name]
	if r == nil then
		error(`Net: remote {name} not ready (call Net.server() or Net.client() first)`, 2)
	end
	return r
end

--- Server-side gate for a client → server call: rate limit, then schema. Returns ok.
function Net.gate(player: Player, channelName: string, schema: Schema?, args: any): boolean
	local userId = player.UserId
	local perPlayer = buckets[userId]
	if perPlayer == nil then
		perPlayer = {}
		buckets[userId] = perPlayer
	end
	local bucket = perPlayer[channelName]
	if bucket == nil then
		local rate = Net.rateFor(channelName)
		bucket = Bucket.new(rate.PerSecond, rate.Burst, os.clock())
		perPlayer[channelName] = bucket
	end
	local now = os.clock()
	if not Bucket.take(bucket, now) then
		if Bucket.strike(bucket, now) then
			Net.raiseSecurityEvent(userId, channelName, "rate limit strikes")
		end
		return false
	end
	if schema then
		local ok, problem = Net.check(schema, args)
		if not ok then
			Net.raiseSecurityEvent(userId, channelName, `bad args: {problem}`)
			return false
		end
	end
	return true
end

return Net
