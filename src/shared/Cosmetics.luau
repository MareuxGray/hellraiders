--!strict
-- Cosmetics catalogue (19 §19.5). The blueprint fixes groups, counts, id ranges, asset ranges and how many of each
-- group are MC, Robux or earned, with price ranges. Individual names and exact prices are not in the blueprint,
-- so each row's name is a PLACEHOLDER "[Group n]" and its price is the low end of its range (question Q-005 in
-- docs/questions.md). Source: "MC" | "Robux" | "Pass" | "Collection" | "Achievement" | "Level" | "Free" | "Weekly".

export type Cosmetic = {
	id: string,
	group: string,
	name: string,
	source: string,
	priceMC: number?,
	priceRobux: number?,
	asset: string?, -- TEX-/MDL-/VFX-/ANIM-/UI- id
	icon: string?, -- UI-COS-* id
}

local Cosmetics = {}

type GroupDef = {
	group: string,
	prefix: string,
	count: number,
	assetPrefix: string?,
	-- allocation in order: list of { source, count, priceMC?, priceRobux? }
	alloc: { { source: string, count: number, priceMC: number?, priceRobux: number? } },
}

local GROUPS: { GroupDef } = {
	{
		group = "Finish",
		prefix = "COS-FIN",
		count = 24,
		assetPrefix = "TEX-FIN",
		alloc = {
			{ source = "MC", count = 8, priceMC = 5000 },
			{ source = "Robux", count = 12, priceRobux = 49 },
			{ source = "Pass", count = 4 },
		},
	},
	{
		group = "Sticker",
		prefix = "COS-STK",
		count = 30,
		assetPrefix = "TEX-STK",
		alloc = {
			{ source = "MC", count = 10, priceMC = 1000 },
			{ source = "Robux", count = 14, priceRobux = 25 },
			{ source = "Collection", count = 6 },
		},
	},
	{
		group = "Charm",
		prefix = "COS-CHM",
		count = 12,
		assetPrefix = "MDL-CHM",
		alloc = { { source = "Robux", count = 10, priceRobux = 49 }, { source = "Achievement", count = 2 } },
	},
	{
		group = "Outfit",
		prefix = "COS-OUT",
		count = 20,
		assetPrefix = "MDL-OUT",
		alloc = {
			{ source = "MC", count = 8, priceMC = 10000 },
			{ source = "Robux", count = 8, priceRobux = 99 },
			{ source = "Level", count = 4 },
		},
	},
	{
		group = "DeathEffect",
		prefix = "COS-DTH",
		count = 6,
		assetPrefix = "VFX-DTH",
		alloc = { { source = "Robux", count = 6, priceRobux = 79 } },
	},
	{
		group = "MutationEffect",
		prefix = "COS-MFX",
		count = 6,
		assetPrefix = "VFX-MFX",
		alloc = { { source = "Robux", count = 6, priceRobux = 99 } },
	},
	{
		group = "VoicePack",
		prefix = "COS-VOX",
		count = 4,
		alloc = { { source = "Robux", count = 4, priceRobux = 149 } },
	},
	{
		group = "Flare",
		prefix = "COS-FLR",
		count = 6,
		assetPrefix = "VFX-FLR",
		alloc = { { source = "Robux", count = 6, priceRobux = 49 } },
	},
	{
		group = "Emote",
		prefix = "COS-EMO",
		count = 12,
		assetPrefix = "ANIM-EMO",
		alloc = { { source = "Free", count = 4 }, { source = "Robux", count = 8, priceRobux = 49 } },
	},
	{
		group = "DoorBanner",
		prefix = "COS-BAN",
		count = 10,
		alloc = { { source = "Robux", count = 10, priceRobux = 25 } },
	},
	{
		group = "NameplateFrame",
		prefix = "COS-NPF",
		count = 6,
		assetPrefix = "UI-NPF",
		alloc = { { source = "Level", count = 3 }, { source = "Robux", count = 3, priceRobux = 49 } },
	},
}

-- Names the blueprint does give.
local KNOWN_NAMES: { [string]: string } = {
	["COS-VOX-001"] = "Veteran",
	["COS-VOX-002"] = "Rookie",
	["COS-VOX-003"] = "Calm Medic",
	["COS-VOX-004"] = "Radio Static",
	["COS-EMO-001"] = "Wave",
	["COS-EMO-002"] = "Hands Up",
	["COS-EMO-003"] = "Point",
	["COS-EMO-004"] = "Thumbs Up",
	["COS-CHM-011"] = "Plus One", -- referral charm (20 §20.9)
	["COS-DTH-006"] = "Nothing (default)",
}
-- Death effects named in 19 §19.5, in order.
local DEATH_NAMES = { "Blood mist", "Ash", "Paper tags", "Static glitch", "Crows", "Nothing (default)" }

local list: { Cosmetic } = {}
local iconIndex = 0
for _, def in GROUPS do
	local n = 0
	for _, a in def.alloc do
		for _ = 1, a.count do
			n += 1
			if def.group ~= "NameplateFrame" then
				iconIndex += 1
			end
			local id = string.format("%s-%03d", def.prefix, n)
			local name = KNOWN_NAMES[id] or (if def.group == "DeathEffect" then DEATH_NAMES[n] else `[{def.group} {n}]`)
			table.insert(list, {
				id = id,
				group = def.group,
				name = name,
				source = a.source,
				priceMC = a.priceMC,
				priceRobux = a.priceRobux,
				asset = if def.assetPrefix then string.format("%s-%03d", def.assetPrefix, n) else nil,
				-- Nameplate frames have their own art (UI-NPF-*) and no UI-COS icon (Q-011).
				icon = if def.group == "NameplateFrame"
					then string.format("UI-NPF-%03d", n)
					else string.format("UI-COS-%03d", iconIndex),
			})
		end
	end
	assert(n == def.count, `{def.group} allocation {n} != {def.count}`)
end
-- Door banner models are MDL-FLT-091…099 for the 9 shop banners; the weekly Tower Standing banner is MDL-FLT-090
-- and free (14 §14.13). The blueprint lists 10 door banners at 25–99 R$ and 9 shop banner models: the tenth is the
-- weekly one (question Q-006).
for i, c in list do
	if c.group == "DoorBanner" then
		local n = tonumber(string.sub(c.id, -3)) :: number
		if n <= 9 then
			c.asset = string.format("MDL-FLT-%03d", 90 + n)
		else
			c.asset = "MDL-FLT-090"
			c.source = "Weekly"
			c.priceRobux = nil
			c.name = "Tower Standing banner"
		end
		list[i] = c
	end
end

local byId: { [string]: Cosmetic } = {}
for _, c in list do
	byId[c.id] = c
end

Cosmetics.List = table.freeze(list)
Cosmetics.ById = table.freeze(byId)
Cosmetics.Groups = table.freeze(GROUPS)
Cosmetics.Count = #list -- 136 rows: 130 with UI-COS icons, 6 nameplate frames with UI-NPF art

return Cosmetics
