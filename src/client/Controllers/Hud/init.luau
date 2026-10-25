--!strict
-- Controller Hud: one child module per raid HUD element.
-- Owning blueprint file: 21 §21.3. Built in step S4 onward. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.
-- Children arrive with their steps: WeaponPanel, QuickBar, SquadList, Vitals, StatusIcons, StaminaArc, WeightBar,
-- Prompt, EvacMarker, EvacTimer, TerminalRing, CatalystIcon, WantedTag, VipRadio, Pings, SquadTags, StruggleBar,
-- SleeperVeins, ScannerResult, GhostTools, SupermutantKit, StalkerKit, RevivePrompt, DownedBar, DamageDirection,
-- Toasts, Subtitles, TowerHud (21 §21.3, §21.6).
local Hud = {}

Hud.Name = "Hud"

function Hud.init()
	-- Wired in S4 onward.
end

function Hud.start()
	-- Started in S4 onward.
end

return Hud
