--!strict
-- Controller Ui: one child module per screen.
-- Owning blueprint file: 21 §21.5. Built in step S3 onward. S0 ships the empty contract only (25 §25.2):
-- init() wires signals and must not yield; start() may yield. Bootstrap calls every init, then every start.
-- Children arrive with their steps, one per UI-* screen id in 21 §21.5 (Arrival, SurvivorDraft, Deploy, Insurance,
-- HaulTally, DeathScreen, RaidSummary, LiftPicker, Concierge, Party, Nameplate, Stash, Workbench, FlatTerminal,
-- BuildCatalogue, Gunsmith, Collection, Vendor, Flea, Mail, Bounties, Relics, Shop, Pass, Catalyst, Lab, Wheel,
-- Comms, Settings, Admin).
local Ui = {}

Ui.Name = "Ui"

function Ui.init()
	-- Wired in S3 onward.
end

function Ui.start()
	-- Started in S3 onward.
end

return Ui
