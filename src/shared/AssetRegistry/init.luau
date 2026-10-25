--!strict
-- AssetRegistry (25 §25.3). Every asset in the game is used through this module by its blueprint id
-- (e.g. "ANIM-MOV-001"). Entries come from the generated Data_<KIND>.luau files (tools/gen_shared.py reads
-- tools/assets_master.py, and real ids from tools/asset_ids.json). An entry with id 0 is a placeholder:
-- `get` returns a safe stand-in for its kind and logs `PLACEHOLDER <id> <desc>` once per server/client.
--
-- Pure functions (`lookup`, `get`, `countByStep`, `placeholdersFor`) work in Lune for tests. Instance-building
-- helpers (`model`, `uiImage`, `vfx`) need Roblox and return nil elsewhere.

local KINDS = { "MDL", "ANIM", "SFX", "MUS", "VO", "UI", "VFX", "TEX" }

export type Kind = "MDL" | "ANIM" | "SFX" | "MUS" | "VO" | "UI" | "VFX" | "TEX"
export type Entry = {
	kind: Kind,
	id: number,
	step: string,
	desc: string,
	size: { number }?,
}
export type Resolved = {
	assetId: string, -- "rbxassetid://123" or a built-in rbxasset path; "" for silence
	real: boolean,
	entry: Entry,
}

local AssetRegistry = {}

-- Placeholder stand-ins by kind. These are the only asset ids allowed outside the data tables, because they
-- are the placeholder layer itself (25 §25.3). Default R15 clips and Roblox built-in sounds.
local PLACEHOLDER = {
	ANIM = {
		Default = "rbxassetid://507766666", -- R15 idle
		Idle = "rbxassetid://507766666",
		Walk = "rbxassetid://507777826",
		Run = "rbxassetid://507767714",
		Climb = "rbxassetid://507765644",
		Fall = "rbxassetid://507767968",
	},
	SFX = "rbxasset://sounds/button.wav",
	VO = "rbxasset://sounds/electronicpingshort.wav",
	MUS = "", -- silence
	UI = "", -- grey rounded square drawn by uiImage()
	VFX = "", -- white burst built by vfx()
	TEX = "", -- flat colour
	MDL = "", -- grey box built by model()
	Colour = { 128, 128, 128 },
}

local data: { [string]: Entry } = {}
for _, kind in KINDS do
	local module = (script :: any):FindFirstChild(`Data_{kind}`)
	if module then
		for id, entry in require(module) :: { [string]: Entry } do
			data[id] = entry
		end
	end
end

local logged: { [string]: boolean } = {}
local summaryPrinted = false

local function isRoblox(): boolean
	return typeof(game) ~= "nil" and typeof(Instance) ~= "nil"
end

--- The raw entry, or nil for an unknown id (an unknown id is a programming error: ids come from 27).
function AssetRegistry.lookup(assetId: string): Entry?
	return data[assetId]
end

--- All entries (read-only use).
function AssetRegistry.all(): { [string]: Entry }
	return data
end

local function logPlaceholder(assetId: string, entry: Entry)
	if logged[assetId] then
		return
	end
	logged[assetId] = true
	print(`PLACEHOLDER {assetId} {entry.desc}`)
end

--- Resolves an id to a usable asset string. Unknown ids error, so a typo fails loudly in tests.
--- `hint` picks a closer ANIM placeholder ("Idle", "Walk", "Run", "Climb", "Fall").
function AssetRegistry.get(assetId: string, hint: string?): Resolved
	local entry = data[assetId]
	if entry == nil then
		error(`AssetRegistry: unknown asset id {assetId} (every id must be in blueprint/27-assets.md)`, 2)
	end
	if entry.id ~= 0 then
		return { assetId = `rbxassetid://{entry.id}`, real = true, entry = entry }
	end
	logPlaceholder(assetId, entry)
	local stand: string
	if entry.kind == "ANIM" then
		stand = PLACEHOLDER.ANIM[hint or "Default"] or PLACEHOLDER.ANIM.Default
	else
		stand = (PLACEHOLDER :: any)[entry.kind] or ""
	end
	return { assetId = stand, real = false, entry = entry }
end

--- True when the id has a real asset.
function AssetRegistry.isReal(assetId: string): boolean
	local entry = data[assetId]
	return entry ~= nil and entry.id ~= 0
end

--- Placeholder counts by kind, e.g. { ANIM = 140, SFX = 210 }.
function AssetRegistry.placeholderCounts(): { [string]: number }
	local counts = {}
	for _, entry in data do
		if entry.id == 0 then
			counts[entry.kind] = (counts[entry.kind] or 0) + 1
		end
	end
	return counts
end

--- Total entries by kind.
function AssetRegistry.counts(): { [string]: number }
	local counts = {}
	for _, entry in data do
		counts[entry.kind] = (counts[entry.kind] or 0) + 1
	end
	return counts
end

--- Entry count for one step (S0…P1).
function AssetRegistry.countByStep(step: string): number
	local n = 0
	for _, entry in data do
		if entry.step == step then
			n += 1
		end
	end
	return n
end

--- Placeholder ids for a step, sorted, for the admin Placeholders tab export (22 §22.6).
function AssetRegistry.placeholdersFor(step: string): { string }
	local ids = {}
	for id, entry in data do
		if entry.step == step and entry.id == 0 then
			table.insert(ids, id)
		end
	end
	table.sort(ids)
	return ids
end

--- Formats the "Asset requests" text for a step in the 27 table format (22 §22.6).
function AssetRegistry.assetRequestText(step: string): string
	local lines = { `Asset requests · Step {step}`, "| Id | Kind | What | Placeholder size |", "|---|---|---|---|" }
	for _, id in AssetRegistry.placeholdersFor(step) do
		local e = data[id]
		local size = if e.size then `{e.size[1]}x{e.size[2]}x{e.size[3]}` else "—"
		table.insert(lines, `| {id} | {e.kind} | {e.desc} | {size} |`)
	end
	return table.concat(lines, "\n")
end

--- One summary line at server and client start: `PLACEHOLDERS ANIM 140 SFX 210 ...` (25 §25.3).
function AssetRegistry.printSummary(): string
	local counts = AssetRegistry.placeholderCounts()
	local parts = { "PLACEHOLDERS" }
	for _, kind in KINDS do
		table.insert(parts, `{kind} {counts[kind] or 0}`)
	end
	local line = table.concat(parts, " ")
	if not summaryPrinted then
		summaryPrinted = true
		print(line)
	end
	return line
end

-- ---------------------------------------------------------------- Roblox-only placeholder builders

--- Grey box sized from the entry's placeholder size, attribute Placeholder = true, and a BillboardGui label
--- of the id in Studio only (25 §25.3). Returns nil outside Roblox.
function AssetRegistry.model(assetId: string): Instance?
	if not isRoblox() then
		return nil
	end
	local resolved = AssetRegistry.get(assetId)
	local entry = resolved.entry
	local size = entry.size or { 4, 4, 4 }
	local part = Instance.new("Part")
	part.Name = assetId
	part.Anchored = true
	part.Size = Vector3.new(size[1], size[2], size[3])
	part.Color = Color3.fromRGB(PLACEHOLDER.Colour[1], PLACEHOLDER.Colour[2], PLACEHOLDER.Colour[3])
	part.Material = Enum.Material.SmoothPlastic
	part:SetAttribute("Placeholder", not resolved.real)
	part:SetAttribute("AssetId", assetId)
	local RunService = game:GetService("RunService")
	if not resolved.real and RunService:IsStudio() then
		local gui = Instance.new("BillboardGui")
		gui.Size = UDim2.fromOffset(200, 40)
		gui.AlwaysOnTop = true
		gui.StudsOffsetWorldSpace = Vector3.new(0, size[2] / 2 + 1, 0)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.fromScale(1, 1)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextStrokeTransparency = 0.5
		label.TextScaled = true
		label.Text = `{assetId}\n{entry.desc}`
		label.Parent = gui
		gui.Parent = part
	end
	return part
end

--- Grey rounded square with the id text, for UI placeholders. Returns nil outside Roblox.
function AssetRegistry.uiImage(assetId: string): Instance?
	if not isRoblox() then
		return nil
	end
	local resolved = AssetRegistry.get(assetId)
	if resolved.real then
		local image = Instance.new("ImageLabel")
		image.Name = assetId
		image.BackgroundTransparency = 1
		image.Image = resolved.assetId
		return image
	end
	local frame = Instance.new("TextLabel")
	frame.Name = assetId
	frame.BackgroundColor3 = Color3.fromRGB(PLACEHOLDER.Colour[1], PLACEHOLDER.Colour[2], PLACEHOLDER.Colour[3])
	frame.TextColor3 = Color3.new(1, 1, 1)
	frame.TextScaled = true
	frame.Text = assetId
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame
	return frame
end

--- Simple white ParticleEmitter burst for VFX placeholders. Returns nil outside Roblox.
function AssetRegistry.vfx(assetId: string): Instance?
	if not isRoblox() then
		return nil
	end
	AssetRegistry.get(assetId)
	local emitter = Instance.new("ParticleEmitter")
	emitter.Name = assetId
	emitter.Color = ColorSequence.new(Color3.new(1, 1, 1))
	emitter.Rate = 0
	emitter.Lifetime = NumberRange.new(0.4, 0.8)
	emitter.Speed = NumberRange.new(4, 8)
	return emitter
end

--- Sound instance for SFX/VO/MUS ids with the placeholder applied. Returns nil outside Roblox.
function AssetRegistry.sound(assetId: string): Instance?
	if not isRoblox() then
		return nil
	end
	local resolved = AssetRegistry.get(assetId)
	local sound = Instance.new("Sound")
	sound.Name = assetId
	sound.SoundId = resolved.assetId
	sound:SetAttribute("Placeholder", not resolved.real)
	return sound
end

AssetRegistry.Kinds = table.freeze(table.clone(KINDS))
AssetRegistry.Placeholder = table.freeze(PLACEHOLDER)

return AssetRegistry
