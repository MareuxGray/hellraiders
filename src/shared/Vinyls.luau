--!strict
-- Vinyl music catalogue (18 §18.8): 40 tracks at launch in five moods of 8, each { id, title, artistCredit,
-- assetId (MUS-VIN-*), mood, licence }. Titles, credits and licences are PLACEHOLDERS until P1 confirms the
-- licensed catalogue (26 P1 step 5). Sleeves and colours are the Pressing Booth presets (18 §18.5).

export type Vinyl = {
	id: string,
	title: string,
	artistCredit: string,
	assetId: string, -- MUS-VIN-* registry id; the real rbxassetid lives in AssetRegistry
	mood: string,
	licence: string,
}

local MOODS = { "Mall Muzak", "Synth Night", "Grunge Garage", "Lo-fi Rooftop", "Doom Choir" }

local list: { Vinyl } = {}
for i = 1, 40 do
	local mood = MOODS[math.floor((i - 1) / 8) + 1]
	table.insert(list, {
		id = string.format("VIN-%03d", i),
		title = `[Vinyl track {i}]`,
		artistCredit = "[artist]",
		assetId = string.format("MUS-VIN-%03d", i),
		mood = mood,
		licence = "[pending P1]",
	})
end

return table.freeze({
	List = table.freeze(list),
	Moods = table.freeze(MOODS),
	PerMood = 8,
	Sleeves = table.freeze({
		"UI-VIN-001",
		"UI-VIN-002",
		"UI-VIN-003",
		"UI-VIN-004",
		"UI-VIN-005",
		"UI-VIN-006",
		"UI-VIN-007",
		"UI-VIN-008",
		"UI-VIN-009",
		"UI-VIN-010",
		"UI-VIN-011",
		"UI-VIN-012",
	}),
	Colours = table.freeze({ "Black", "Red", "Blue", "Gold", "Clear", "Green", "Purple", "Splatter" }),
})
