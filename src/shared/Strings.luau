-- HellRaiders on-screen strings. Every key is copied from blueprint/21-hud-ui-controls-strings.md §21.10,
-- which wins over any other file for text. Flat keys ("STR" .. ".GROUP" .. ".NAME" joined) so tools/check_strings.py can verify them.
-- {x} marks a variable; fill with Strings.format(key, { x = value }).
-- Never invent text: a missing string is a question for Mareux (docs/questions.md).

local Strings = {}

local TEXT: { [string]: string } = {
	-- ACT
	["STR.ACT.SEARCH"] = "Search",
	["STR.ACT.OPEN"] = "Open",
	["STR.ACT.CLOSE"] = "Close",
	["STR.ACT.PICKUP"] = "Pick up",
	["STR.ACT.SHUTTER_UP"] = "Raise shutter",
	["STR.ACT.SHUTTER_HALF"] = "Half shutter",
	["STR.ACT.SHUTTER_DOWN"] = "Lower shutter",
	["STR.ACT.BARRICADE"] = "Barricade",
	["STR.ACT.WEDGE"] = "Wedge door",
	["STR.ACT.PRY"] = "Pry open",
	["STR.ACT.SWIPE"] = "Use keycard",
	["STR.ACT.CODE"] = "Enter code",
	["STR.ACT.FUEL"] = "Start generator",
	["STR.ACT.TERMINAL"] = "Trigger evac",
	["STR.ACT.REVIVE"] = "Revive",
	["STR.ACT.HEAL"] = "Treat",
	["STR.ACT.TAKEDOWN"] = "Takedown",
	["STR.ACT.SHOVE"] = "Shove",
	["STR.ACT.LADDER"] = "Climb",
	["STR.ACT.LIFT"] = "Call lift",
	["STR.ACT.LOOT"] = "Loot",
	["STR.ACT.HARVEST"] = "Harvest Dogtag",
	["STR.ACT.TURN_OFF"] = "Turn off",
	["STR.ACT.KNOCK"] = "Knock",
	["STR.ACT.ENTER"] = "Enter",
	["STR.ACT.TALK"] = "Talk",
	["STR.ACT.SIT"] = "Sit",
	["STR.ACT.CRAFT"] = "Craft",
	["STR.ACT.TRIP"] = "Check",
	-- RAID
	["STR.RAID.DEPLOY"] = "Gate {gate}. Doors opening.",
	["STR.RAID.TERMINALS_LIVE"] = "Security terminals are online.",
	["STR.RAID.FAILSAFE_SOON"] = "Automatic evac in 60 seconds.",
	["STR.RAID.FAILSAFE"] = "Automatic evac triggered.",
	["STR.RAID.LEAVE_CONFIRM"] = "Leave the raid? You'll lose everything you're carrying.",
	["STR.RAID.SEALED"] = "The mall has been sealed.",
	["STR.RAID.RECONNECT"] = "Reconnecting to your raid…",
	-- EVAC
	["STR.EVAC.REDALERT"] = "RED ALERT. Evac at the {exit}.",
	["STR.EVAC.HELIPAD"] = "Rooftop Helipad",
	["STR.EVAC.GARAGE"] = "Basement Garage",
	["STR.EVAC.OPEN"] = "Evac open. Get in.",
	["STR.EVAC.DEPART"] = "Departing…",
	["STR.EVAC.EXTRACTED"] = "Extracted.",
	["STR.EVAC.LOCKDOWN"] = "LOCKDOWN. Something came in with you.",
	["STR.EVAC.REOPEN"] = "Doors open. Last chance.",
	["STR.EVAC.EARLY"] = "Hold to depart now",
	-- INF
	["STR.INF.BITTEN"] = "You've been bitten. Find an Antidote, or don't.",
	["STR.INF.TURNING"] = "You're turning.",
	["STR.INF.CURED"] = "The fever breaks. You're clean.",
	["STR.INF.SUPPRESSED"] = "The burning fades… for now.",
	["STR.INF.SCAN_CLEAN"] = "No infection detected.",
	["STR.INF.SCAN_INFECTED"] = "INFECTED.",
	["STR.INF.THERMO"] = "Temperature: {temp}°C",
	-- MUT
	["STR.MUT.STALKER"] = "You've turned. Hunt.",
	["STR.MUT.SUPER"] = "You are the Supermutant.",
	["STR.MUT.GHOST"] = "You're dead. Your body isn't.",
	["STR.MUT.REVIVE"] = "Rise again? Second Wind ({price})",
	["STR.MUT.TOKEN_USED"] = "Revive Token used.",
	-- RAD
	["STR.RAD.BOUNTY"] = "Bounty sighting. {wing}.",
	["STR.RAD.JANITOR"] = "Maintenance staff on duty. Stay clear of the service corridors.",
	-- INV
	["STR.INV.FULL"] = "No room.",
	["STR.INV.OVERWEIGHT"] = "Overweight.",
	["STR.INV.SAFE"] = "Safe Pocket: kept if you die.",
	["STR.INV.BLUEPRINT"] = "Blueprint Slot: kept if you die.",
	["STR.INV.HANDOVER"] = "{player} wants to hand you {item}.",
	["STR.INV.HANDOVER_ACCEPT"] = "Accept",
	["STR.INV.HANDOVER_DECLINE"] = "Decline",
	-- LOOT
	["STR.LOOT.RELIC"] = "RELIC FOUND",
	["STR.LOOT.EMPTY"] = "Empty.",
	-- CRF
	["STR.CRF.LEARNED"] = "Blueprint learned: {item}.",
	["STR.CRF.KNOWN"] = "Known",
	["STR.CRF.QUEUED"] = "Crafting: {item} · {time}",
	["STR.CRF.DONE"] = "Ready at your workbench: {item}.",
	["STR.CRF.MISSING"] = "Missing materials.",
	-- RES
	["STR.RES.EXTRACTED"] = "EXTRACTED",
	["STR.RES.DIED"] = "YOU DIED",
	["STR.RES.CAUSE"] = "{cause}",
	["STR.RES.KILLED_BY_RAIDER"] = "Killed by a raider",
	["STR.RES.HAUL"] = "Haul value: {value} MC",
	["STR.RES.LOST"] = "Lost: {value} MC",
	["STR.RES.PAYOUT"] = "Death payout: {value} MC · {xp} XP",
	["STR.RES.BLUEPRINT_NEW"] = "New blueprint!",
	["STR.RES.HELPED"] = "Helped by a stranger ×{n}",
	["STR.RES.RETIRED"] = "{survivor} is gone. Pick your next survivor.",
	-- TWR
	["STR.TWR.WELCOME"] = "High-Rise Tower {n}",
	["STR.TWR.READONLY"] = "Tower records are busy. You can play, but flat changes are paused.",
	["STR.TWR.RELOCATED"] = "While you were away, your flat moved to High-Rise Tower {n}. Everything is safe.",
	["STR.TWR.TICKET_GRANTED"] = "The slot was taken, so you got a Move Ticket. Use it any time.",
	["STR.TWR.SWITCH_INSTANCE"] = "Your friend is in another part of the tower. Join them?",
	["STR.TWR.FULL"] = "No vacancies at your tier. Join the waitlist?",
	["STR.TWR.WAITLIST"] = "You're #{n} on the waitlist.",
	["STR.TWR.CLAIM"] = "A flat is free! You have 48 hours to claim it.",
	["STR.TWR.MOVED"] = "Welcome home.",
	["STR.TWR.CONDEMNED"] = "Condemned",
	["STR.TWR.KNOCK"] = "{player} is knocking.",
	-- FLT
	["STR.FLT.RENT_DUE"] = "Rent due: {value} MC. Perks paused until paid.",
	["STR.FLT.RENT_PAID"] = "Rent paid until {date}.",
	["STR.FLT.OVERFLOW"] = "Overflow Crate has items. They'll be sold in {days} days.",
	["STR.FLT.BUILD_INVALID"] = "Can't place here.",
	["STR.FLT.CAP"] = "Furniture limit reached.",
	-- FLEA
	["STR.FLEA.LOCKED"] = "The Flea opens at level 5.",
	["STR.FLEA.CONFIRM"] = "Buy {item} for {price} MC? Balance after: {balance} MC",
	["STR.FLEA.PAID_RESTRICTED"] = "This item can't be traded in your region.",
	["STR.FLEA.LISTED"] = "Listed for 48 hours.",
	["STR.FLEA.SOLD"] = "Sold: {item} for {price} MC (tax {tax} MC).",
	["STR.FLEA.EXPIRED"] = "Listing expired. {item} is in your mail.",
	["STR.FLEA.PRICE_RANGE"] = "Price must be between {min} and {max} MC.",
	["STR.FLEA.WARN_HIGH"] = "This is {pct}% of the usual price ({avg} MC). Hold to buy anyway.",
	["STR.FLEA.WARN_LOW"] = "This is only {pct}% of the usual price ({avg} MC). Hold to list anyway.",
	["STR.FLEA.BARTER_VALUE"] = "You give about {give} MC. You get about {get} MC.",
	["STR.FLEA.HISTORY"] = "Your Flea history",
	-- VEN
	["STR.VEN.CONFIRM_SELL"] = "Sell {item} for {price} MC?",
	-- MAIL
	["STR.MAIL.NEW"] = "You have mail.",
	["STR.MAIL.CLAIM"] = "Claim",
	-- INS
	["STR.INS.RETURNED"] = "Insured gear returned: {items}.",
	["STR.INS.TAKEN"] = "{item} was taken by a raider.",
	["STR.INS.REPO"] = "Lost gear is in Repossession for 24 hours.",
	-- BNT
	["STR.BNT.CONTRIBUTE"] = "Put a price on their head",
	["STR.BNT.CLAIMED"] = "Bounty collected: {value} MC",
	["STR.BNT.JUSTICE"] = "Justice: +{value} MC",
	["STR.BNT.WANTED"] = "WANTED · {value} MC",
	["STR.BNT.TOP10"] = "You're on the Most Wanted Wall.",
	["STR.BNT.ENDED"] = "Your bounty has ended.",
	["STR.BNT.TICKET"] = "Claim Ticket: +25% on this target",
	["STR.BNT.ESCORT_DONE"] = "Client extracted. +{value} MC",
	["STR.BNT.ESCORT_FAIL"] = "Client lost.",
	-- REL
	["STR.REL.FOUND_YOURS"] = "Someone found your {relic}.",
	["STR.REL.FOUND_LOST"] = "Your lost {item} turned up. Someone extracted it from {wing}.",
	["STR.REL.RETURNED"] = "It found its way back to you.",
	["STR.REL.PRESSED"] = "Pressed! One copy is yours. The other is out there now.",
	["STR.REL.ENGRAVED"] = "Engraved: {title}",
	["STR.REL.NOW_PLAYING"] = "Now playing: {title}",
	-- SUR
	["STR.SUR.DRAFT"] = "Choose your survivor",
	["STR.SUR.ODDS"] = "Odds",
	["STR.SUR.REROLL_LOCKED"] = "Rerolls are only possible before a survivor's first raid.",
	-- PRG
	["STR.PRG.LEVELUP"] = "Level {n}!",
	["STR.PRG.UNLOCK"] = "Unlocked: {thing}",
	-- CON
	["STR.CON.DONE"] = "Contract complete: {name}",
	["STR.CON.ALL"] = "All daily contracts done! +{value} MC",
	-- ACH
	["STR.ACH.UNLOCKED"] = "Achievement: {name}",
	-- WHEEL
	["STR.WHEEL.PITY"] = "Robux spins since last success: {n}/10",
	["STR.WHEEL.RESTRICTED"] = "Spins aren't available in your region. Use the Fixed Trade-up.",
	["STR.WHEEL.SUCCESS"] = "Success!",
	["STR.WHEEL.DOWNGRADE"] = "Swapped for another blueprint.",
	["STR.WHEEL.DESTROYED"] = "Destroyed.",
	-- SHOP
	["STR.SHOP.ODDS"] = "Odds",
	["STR.SHOP.OWNED"] = "Owned",
	["STR.SHOP.GIFT"] = "Gift",
	["STR.SHOP.TOKEN"] = "Your purchase was saved as a {token}.",
	-- PASS
	["STR.PASS.TIER"] = "Tier {n}",
	["STR.PASS.CATCHUP"] = "Double Pass XP this week!",
	-- QL
	["STR.QL.FRIENDLY"] = "Friendly!",
	["STR.QL.DONTSHOOT"] = "Don't shoot!",
	["STR.QL.FOLLOW"] = "Follow me",
	["STR.QL.HELP"] = "Help!",
	["STR.QL.DANGER"] = "Danger!",
	["STR.QL.THANKS"] = "Thanks",
	["STR.QL.OVERHERE"] = "Over here",
	["STR.QL.WAIT"] = "Wait",
	-- TUT
	["STR.TUT.MOVE"] = "Move and look around.",
	["STR.TUT.CROUCH"] = "Crouch to stay quiet.",
	["STR.TUT.THROW"] = "Throw something to lure it away.",
	["STR.TUT.STRUGGLE_OK"] = "Nice. Every grab gets harder.",
	["STR.TUT.BITTEN"] = "You're infected. Find the Antidote in the pharmacy kiosk.",
	["STR.TUT.SKIP"] = "Skip Orientation",
	-- HINT
	["STR.HINT.CONTAINER"] = "Hold to search. Rare items take longer to reveal.",
	["STR.HINT.CRAWL"] = "Hold Crouch to crawl through.",
	["STR.HINT.LOCKED"] = "Locked. Find a keycard, or pry it with a crowbar.",
	["STR.HINT.SHUTTER"] = "Lower a shutter to hide. Half lets you peek.",
	["STR.HINT.GENERATOR"] = "Fuel a generator to power this wing. Light shows you, too.",
	["STR.HINT.GLASS"] = "Broken glass crunches. Watch your step.",
	["STR.HINT.REDALERT"] = "Get to the exit before the doors close.",
	["STR.HINT.OVERWEIGHT"] = "Too heavy: slower and louder.",
	["STR.HINT.FUEL"] = "Fuel Can: starts a generator.",
	["STR.HINT.KEYCARD"] = "Keycards open stockrooms and safes.",
	["STR.HINT.CURE"] = "Bitten. Antidotes are in Med Safes. Suppressants buy time.",
	["STR.HINT.TOWER"] = "This is your tower. Your flat is upstairs. Raids leave from the Transit Gates.",
	["STR.HINT.FLEA"] = "The Flea is open. Buy and sell with other players.",
	-- UI
	["STR.UI.CONFIRM"] = "Confirm",
	["STR.UI.CANCEL"] = "Cancel",
	["STR.UI.BACK"] = "Back",
	["STR.UI.CLOSE"] = "Close",
	["STR.UI.LOADING"] = "Loading…",
	["STR.UI.ERROR"] = "Something went wrong. Try again.",
	["STR.UI.SAVING"] = "Saving…",
	["STR.UI.PLACEHOLDER"] = "[placeholder]",
}

-- NPC subtitles (21 §21.10 "NPCs"): one per VO-NPC-xxx line. Placeholder text until the voice script is written in P1.
-- Key form STR.NPC.<NAME>.<n>; <n> is the line number within that NPC (1-based). Names are upper-cased, no spaces.
local NPC_LINES: { { name: string, key: string, count: number } } = {
	{ name = "Marla", key = "MARLA", count = 10 },
	{ name = "Okafor", key = "OKAFOR", count = 10 },
	{ name = "Lenny", key = "LENNY", count = 10 },
	{ name = "June", key = "JUNE", count = 6 },
	{ name = "Reyes", key = "REYES", count = 10 },
	{ name = "Pip", key = "PIP", count = 4 },
	{ name = "Vex", key = "VEX", count = 10 },
	{ name = "Sully", key = "SULLY", count = 6 },
	{ name = "Dr. Halloran", key = "DR_HALLORAN", count = 6 },
	{ name = "Sal", key = "SAL", count = 6 },
}

for _, npc in NPC_LINES do
	for n = 1, npc.count do
		TEXT[`STR.NPC.{npc.key}.{n}`] = `[{npc.name} line {n}]`
	end
end

--- Returns the text for a key, or a visible marker when the key is missing (so a typo shows on screen in tests,
--- never silently). Missing keys are also logged once.
local warned: { [string]: boolean } = {}
function Strings.get(key: string): string
	local text = TEXT[key]
	if text == nil then
		if not warned[key] then
			warned[key] = true
			warn(`STRING MISSING {key}`)
		end
		return `[{key}]`
	end
	return text
end

--- Fills {x} variables. Unknown variables are left as-is so they are visible.
function Strings.format(key: string, vars: { [string]: any }?): string
	local text = Strings.get(key)
	if vars == nil then
		return text
	end
	return (
		string.gsub(text, "{(%w+)}", function(name)
			local value = vars[name]
			if value == nil then
				return "{" .. name .. "}"
			end
			return tostring(value)
		end)
	)
end

function Strings.has(key: string): boolean
	return TEXT[key] ~= nil
end

--- Every key (for tests and the admin Strings audit).
function Strings.keys(): { string }
	local keys = {}
	for key in TEXT do
		table.insert(keys, key)
	end
	table.sort(keys)
	return keys
end

Strings.Text = table.freeze(TEXT)

return Strings
