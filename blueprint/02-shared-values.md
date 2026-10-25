# 02 · Shared values (single source of truth)

Every other file points here for these values. If any file seems to disagree, **this file wins** for the values below. Units: distances in studs, times in seconds, speeds in studs per second, weights in kg, angles in degrees, money in Mall Cash (MC) unless marked R$. Every value is a key in `src/shared/Config.luau` (key in the last column).

---

## 2.1 Players, squads, servers

| Topic | Value | Config key |
|---|---|---|
| Squad size | 1–3 | `Squad.Max = 3` |
| Queue pools | Solo, Duo, Trio. Fill Squad toggle puts solos and duos into the Trio pool as fillers. | `Queue.Pools = {"Solo","Duo","Trio"}` |
| Raid players (max) | 12 (Solo pool 10, Duo 12 = 6 duos, Trio 12 = 4 trios) | `Raid.MaxPlayers = {Solo=10, Duo=12, Trio=12}` |
| Raid players (min to launch) | 4 after 45 s of waiting, otherwise wait for max | `Raid.MinPlayers = 4`, `Queue.MaxWait = 45` |
| Arrival place (start place, routing only) | Roblox max 50; players stay 2–10 s | `Places.Arrival.MaxPlayers = 50` |
| Raid server Roblox max | 12 | `Places.Mall.MaxPlayers = 12` |
| Tower server Roblox max | 50 | `Places.Tower.MaxPlayers = 50` |
| Residents per tower | 64 flats (32 Bunk, 24 Executive, 8 Penthouse) | `Tower.Flats = {Bunk=32, Executive=24, Penthouse=8}` |
| Tower soft cap for annex | Open an Annex server when the live instance has 46+ players | `Tower.AnnexAt = 46` |
| Mid-raid joins | Never | — |
| Reconnect window | 120 s back into the same raid. Your body stays in the world, standing still, for that long. | `Raid.ReconnectWindow = 120` |

## 2.2 Raid timing (full detail in 03 and 10)

| Event | Time from raid start | Config key |
|---|---|---|
| Raid length | 1200 (20:00) | `Raid.Length = 1200` |
| Spawn protection (no zombie aggro, no PvP damage) | first 20 | `Raid.SpawnProtect = 20` |
| The Janitor enters | 480 (8:00) | `Janitor.EnterAt = 480` |
| Security terminals unlock | 600 (10:00) | `Evac.TerminalsUnlockAt = 600` |
| Red Alert auto-start (failsafe) | 1020 (17:00) | `Evac.AutoStartAt = 1020` |
| Terminal activation hold | 5 | `Evac.ActivateHold = 5` |
| Evac countdown (exit revealed at start) | 120 | `Evac.Countdown = 120` |
| Evac zone open window | 45 | `Evac.OpenWindow = 45` |
| Early depart (all living non-mutant humans inside, any one holds) | hold 3 | `Evac.EarlyDepartHold = 3` |
| Lockdown | 90 | `Evac.Lockdown = 90` |
| Reopen window | 30 | `Evac.ReopenWindow = 30` |
| Mall sealed (everyone left inside dies) | when the Red Alert sequence ends (see Rule below) | — |
| Horde surge multiplier during Red Alert | speed ×2, aggro range unlimited to the exit zone | `Evac.HordeSpeedMult = 2` |

**Rule:** there's exactly one Red Alert per raid, and the raid ends when its sequence ends (the mall seals; anyone still inside who didn't extract dies). Red Alert always starts by 1020, and the longest sequence is 120 + 45 + 90 + 30 = 285 s, so no raid lasts past 1305. `Raid.Length` (1200) is the nominal length shown on the watch. `tools/check_numbers.py` checks this.

## 2.3 Movement (full detail in 04)

| State | Value | Config key |
|---|---|---|
| Walk | 12 | `Move.Walk = 12` |
| Sprint (hold Shift; mobile auto-sprint toggle) | 22 | `Move.Sprint = 22` |
| Crouch walk | 6 | `Move.Crouch = 6` |
| Aimed walk forward / side / back | 8 / 6 / 4.8 | `Move.Aim = {Fwd=8, Side=6, Back=4.8}` |
| Walk backwards (not aimed) | 7.2 | `Move.Back = 7.2` |
| Jump | Disabled. Space is dodge roll, or traversal at an edge. | `Move.JumpEnabled = false` |
| Input buffer (Roll, Slide, traversal, reload, melee pressed early) | 0.15 s | `Move.InputBuffer = 0.15` |
| Traversal grace (edge still valid after it leaves the detection box) | 0.12 s | `Move.EdgeGrace = 0.12` |
| Prone crawl | speed 3, height 2, zombie sight ×0.4, hold Crouch 0.5 s, down 0.6 s, up 0.7 s | `Move.Prone = {Speed=3, Height=2, Sight=0.4, Hold=0.5, Down=0.6, Up=0.7}` |
| Step-over (automatic) | obstacles 1.0–2.5 high | `AM.Step = {Min=1.0, Max=2.5}` |
| Ledge climb-up | top 4.5–7.5 above feet, 1.4 s, 15 stamina | `AM.Ledge = {Min=4.5, Max=7.5, Time=1.4, Stamina=15}` |
| Dodge roll | 0.6 s, distance 9, keeps exit speed, 1.0 s cooldown | `Roll.*` |
| Slide | entry speed ×1.2, duration 0.8 (walk) to 1.6 (sprint), end speed 5–10, cooldown 1.8 | `Slide.*` |
| Slide tackle | player hit by a slide is ragdolled 1.5 s; Walkers knocked down 2.0 s | `Slide.Tackle.*` |
| Fear boost | +15% move speed for 4 s | `Fear.BoostSpeed = 0.15`, `Fear.BoostTime = 4` |
| Leg fracture | sprint disabled, walk ×0.7, footstep noise ×1.5 | `Injury.Leg.*` |
| Overweight (> 100% carry) | no sprint, walk ×0.75 | `Carry.Over.*` |
| Heavy (70–100% carry) | sprint ×0.85, stamina drain ×1.5, noise ×1.3 | `Carry.Heavy.*` |
| Fall damage | none below 12 studs; 12–20: 20 dmg + 30% leg fracture; 20–30: 45 dmg + leg fracture; > 30: death | `Fall.*` |
| Landing roll (within 0.2 s of a 12–20 landing) | damage ×0.5, no fracture | `Fall.RollWindow = 0.2`, `Fall.RollCut = 0.5` |

## 2.4 Survivor attributes and stats (full detail in 05)

| Attribute | Range (pool 25, each 3–7, neutral 5) | Effect at 3 → 7 | Config key |
|---|---|---|---|
| Endurance | 3–7 | max stamina ×0.80 → ×1.25; regen ×0.85 → ×1.2 | `Attr.Endurance` |
| Strength | 3–7 | base carry 10 → 18 kg (12/14/16 between) | `Attr.Strength` |
| Composure | 3–7 | fear gain ×1.0 → ×0.7; incubation ×0.9 → ×1.1 | `Attr.Composure` |
| Marksmanship | 3–7 | aim sway ×1.25 → ×0.8 | `Attr.Marksmanship` |
| Stealth | 3–7 | own noise radius ×1.15 → ×0.85 | `Attr.Stealth` |

| Stat | Value | Config key |
|---|---|---|
| Max health | 100 (fixed for everyone) | `Health.Max = 100` |
| Stamina base | 100 | `Stamina.Base = 100` |
| Sprint drain | 12/s | `Stamina.SprintDrain = 12` |
| Roll / slide / vault / shove cost | 20 / 15 / 10 / 10 | `Stamina.Cost.*` |
| Hold breath drain | 20/s (max hold = stamina) | `Stamina.HoldBreathDrain = 20` |
| Regen | 15/s after 1.0 s without spending | `Stamina.Regen = 15`, `Stamina.RegenDelay = 1` |
| Fear range | 0–100 | `Fear.Max = 100` |
| Fear boost trigger / re-arm | rises past 60 / falls below 40 | `Fear.BoostAt = 60`, `Fear.RearmBelow = 40` |
| Fear boost after-effect | aim stability −30% during boost; stamina regen −50% for 6 s after | `Fear.*` |
| Fear decay | 4/s once no threat within 30 for 5 s | `Fear.Decay = 4` |
| Carry with pack (Strength 3–7) | Satchel +6, Field Pack +12, Tactical Bag +18 | `Carry.PackBonus.*` |

## 2.5 Noise radii (full detail in 06)

Radius at which Walkers and Crawlers hear the sound on the same floor. Other floors hear at radius ×0.5 unless "multi-floor". Mutants see a noise ping inside the full radius.

| Source | Radius | Multi-floor | Config key |
|---|---|---|---|
| Crouch walk, crawl, stand still | 0 | — | `Noise.Crouch = 0` |
| Walk | 12 | no | `Noise.Walk = 12` |
| Sprint | 30 | no | `Noise.Sprint = 30` |
| Roll | 20 | no | `Noise.Roll = 20` |
| Slide | 25 | no | `Noise.Slide = 25` |
| Vault / mantle landing | 18 | no | `Noise.Vault = 18` |
| Search container (per second) | 8 | no | `Noise.Search = 8` |
| Field crafting | 35 | no | `Noise.Craft = 35` |
| Melee hit | 15 | no | `Noise.Melee = 15` |
| Gunshot (unsuppressed) | 250 | yes | `Noise.Gun = 250` |
| Gunshot (suppressed) | 50 | no | `Noise.GunSuppressed = 50` |
| Glass break | 120 | yes | `Noise.Glass = 120` |
| Shards stepped on (walk / sprint; crouch 0) | 15 / 30 | no | `Noise.Shards = {Walk=15, Sprint=30}` |
| Shop shutter up/down | 40 | no | `Noise.Shutter = 40` |
| Door slam / barricade hit | 50 | no | `Noise.Door = 50` |
| Alarm (store alarm, ghost-triggered, sleeper-triggered) | 200 for 20 s | yes | `Noise.Alarm = 200`, `Noise.AlarmTime = 20` |
| Noise Decoy | 150 for 12 s after a 3 s delay | yes | `Noise.Decoy.*` |
| Generator start | 150 | yes | `Noise.Generator = 150` |
| Scanner use | 20 | no | `Noise.Scanner = 20` |
| Boombox playing a vinyl | 100 while playing | yes | `Noise.Boombox = 100` |
| Hanging sign / bottles trap | 60 | no | `Noise.Trap = 60` |

## 2.6 Vision and light (full detail in 06)

| Topic | Value | Config key |
|---|---|---|
| Zombie sight cone (half-angle) | 50 | `Sight.ZombieCone = 50` |
| Zombie sight range vs lit / dark target | 40 / 15 | `Sight.ZombieLit = 40`, `Sight.ZombieDark = 15` |
| Crouched target | sight range ×0.6 | `Sight.CrouchMult = 0.6` |
| Flashlight cone half-angle / range | 30 / 45 | `Flashlight.Cone = 30`, `Flashlight.Range = 45` |
| Flashlight battery | 300 s on-time per battery | `Flashlight.Battery = 300` |
| Flashlight beacon (mutants see the beam source through windows and across atriums) | 120 | `Flashlight.Beacon = 120` |
| Powered wing lighting | full visibility, zombies see 40 regardless of light | — |

## 2.7 Struggle (QTE) and infection (full detail in 09)

| Topic | Value | Config key |
|---|---|---|
| Struggle form | Timing bar: needle sweeps, press Struggle when the needle is in the green zone | `Struggle.Mode = "Bar"` |
| Struggle 1 / 2 / 3 | zone 30% / 20% / 12% of bar; needle sweep period 1.6 / 1.3 / 1.0 s; time limit 5 / 3 / 1.5 s | `Struggle.Steps` |
| Struggle 4+ | instant bite, no bar | `Struggle.InstantFrom = 4` |
| Success | shove: attacker knocked back 6 studs, 10 damage to it, 1.5 s escape window (attackers can't lunge at you) | `Struggle.Escape = 1.5` |
| Teammate intercept | any hit on the grappling zombie ends the struggle; counter is NOT increased | — |
| Incubation (hidden) | 180 s × Composure multiplier | `Infection.Incubation = 180` |
| Suppressant | pauses incubation 90 s (stacks by adding time) | `Infection.SuppressPause = 90` |
| Antidotes per raid | 1–3 (random), in Med Safes | `Infection.Antidotes = {1,3}` |
| Scanner scan time | 3 s at ≤ 4 studs, target must stay in range | `Scanner.Time = 3`, `Scanner.Range = 4` |

## 2.8 Combat (full detail in 07)

| Weapon | Damage (torso) | RPM | Mag | Ammo | Range falloff start / min dmg | Config key |
|---|---|---|---|---|---|---|
| Pistol "P9" | 25 | 300 | 12 | Light | 40 / 60% | `Guns.P9` |
| SMG "Wasp" | 16 | 750 | 30 | Light | 30 / 50% | `Guns.Wasp` |
| Pump shotgun "Brace" | 9 × 8 pellets | 70 | 6 | Shells | 12 / 20% | `Guns.Brace` |
| Assault rifle "Kestrel" | 22 | 600 | 30 | Medium | 70 / 70% | `Guns.Kestrel` |
| Hunting rifle "Longhorn" | 70 | 45 | 5 | Heavy | 150 / 85% | `Guns.Longhorn` |
| Exotic AR "Nightjar" (built-in suppression, noise 60) | 24 | 600 | 30 | Medium | 70 / 70% | `Guns.Nightjar` |
| Exotic revolver "Revenant" | 55 | 180 | 6 | Heavy | 50 / 70% | `Guns.Revenant` |

| Topic | Value | Config key |
|---|---|---|
| Head multiplier | ×2.0 (players), ×3.0 (Walkers, Crawlers) | `Damage.Head.*` |
| Limb multiplier | ×0.7; 15% fracture chance on limb hits of 20+ damage | `Damage.Limb.*` |
| Armour (torso) | Light vest −30%, Heavy vest −50%, Bastion Plate −60%; durability 200 / 400 / 500 | `Armour.*` |
| Helmet | head ×2.0 becomes ×1.4; durability 120 | `Helmet.*` |
| Melee: Pipe / Crowbar / Fire Axe | 25 / 30 / 50 damage; swing time 0.6 / 0.75 / 1.1 | `Melee.*` |
| Heavy melee (hold) | ×1.8 damage, ×1.6 swing time, 15 stamina | `Melee.Heavy.*` |
| Shove | 0 damage, 6-stud knockback, 10 stamina, 1.0 s cooldown | `Shove.*` |
| Stealth takedown | crouched, behind, ≤ 3 studs, target unaware; hold 1.2 s; silent kill (Walkers, Crawlers only) | `Takedown.*` |
| Mobile aim assist | magnetism 4° on AI, 2° on players; slowdown 40% inside 6° | `AimAssist.*` |

## 2.9 Enemies (full detail in 08)

| Enemy | HP | Speed (patrol / chase) | Attack | Config key |
|---|---|---|---|---|
| Walker | 60 | 4 / 13 | Lunge (struggle) from 6 studs, 0.5 s wind-up, 4 s cooldown | `Zombie.Walker` |
| Crawler | 40 | 3 / 9 | Ankle grab (struggle, counts toward counter) from 3 studs | `Zombie.Crawler` |
| Sprinter (dead Sleeper's body) | 90 | 10 / 24 | Swipe 15 dmg (25% bleed) + Lunge | `Zombie.Sprinter` |
| The Janitor | cannot die; UV flare stun 6 s; 120 gun damage in 5 s staggers it 1.5 s | 8 / 18 | Grab: 60 damage + leg fracture, thrown 8 studs; never bites | `Janitor.*` |
| Stalker Mutant (player) | 250 | 26 sprint, climbs walls | Claw 30, Pounce 45 (8 s cooldown) | `Mutant.Stalker` |
| Supermutant (player, Brute) | 1200 + 300 per living human above 2 | 28, wall and ceiling run | Slam 55, Charge 70 (breaks walls), Screech | `Mutant.Super` |
| Zombie budget | Max 40 AI active per raid server, 24 within 120 of any player | `AI.MaxActive = 40`, `AI.NearCap = 24` |

## 2.10 Inventory (full detail in 11)

| Topic | Value | Config key |
|---|---|---|
| Pockets | 4 × 1×1 | `Inv.Pockets = 4` |
| Safe Pocket | 1 × 1×1, any item that fits, kept on death | `Inv.SafePocket = 1` |
| Blueprint Slot | 1 × 1×1, blueprints only, kept on death | `Inv.BlueprintSlot = 1` |
| Quick slots | 4 (meds, throwables, scanner, flashlight battery) | `Inv.Quick = 4` |
| Backpacks (grid) | none / Satchel 4×4 / Field Pack 5×6 / Tactical Bag 6×8 | `Packs.*` |
| Stash grid | Bunk 10×15, Executive 15×20, Penthouse 20×30 (+ Ammo Locker 10×10) | `Stash.*` |
| Stash expansion pass | +5 rows each, 2 passes max | `Stash.ExpansionRows = 5` |
| Slot reveal time by tier | Common 0.3, Uncommon 0.5, Rare 0.8, Epic 1.2, Exotic 1.8, Relic 2.6 | `Reveal.Time.*` |
| Container open hold | 1.2 (locked stockroom: keycard + 2.0) | `Container.OpenHold = 1.2` |
| Corpse/backpack search | reveals one slot per 0.6 s | `Corpse.RevealPerSlot = 0.6` |

## 2.11 Tiers and colours

| Tier | Colour (RGB) | Spectacle level (03 file of research) | Config key |
|---|---|---|---|
| Common | 170,170,170 grey | small pop, soft click | `Tier.Common` |
| Uncommon | 92,190,92 green | small pop, chime | `Tier.Uncommon` |
| Rare | 70,140,230 blue | burst, rising note | `Tier.Rare` |
| Epic | 170,90,230 purple | flash, stinger + bass | `Tier.Epic` |
| Exotic | 235,180,60 gold | beam, unique stinger, camera push 0.3 s | `Tier.Exotic` |
| Relic | 235,60,60 red-gold rim | unique Relic theme, slow reveal, server ping to own squad only | `Tier.Relic` |

## 2.12 Economy anchors (full detail in 16 and 19)

| Topic | Value | Config key |
|---|---|---|
| Starting Mall Cash | 5,000 | `Econ.StartCash = 5000` |
| Typical raid haul value (target median, extracted) | 6,000 | `Econ.TargetHaul = 6000` |
| Death payout (always, even when you lose everything) | 300 MC + 50 XP | `Econ.DeathPayout = 300` |
| Flea tax (paid by seller) | 10% at Merchant Score 0, −1% per 20 Merchant Score, floor 5%; Merchant Tax Pass halves it | `Flea.Tax.Base = 0.10`, `Flea.Tax.Floor = 0.05` |
| Bunk rent | 1,500 / week, first 2 weeks free, prepay up to 4 weeks | `Rent.Bunk = 1500` |
| Executive Suite | 250,000 MC or 399 R$ (permanent) | `Flat.Executive.*` |
| Skyline Penthouse | 1,499 R$ (permanent) | `Flat.Penthouse.Robux = 1499` |
| Minimum flat light while a visitor is inside | 40% | `Flat.MinLightWithVisitors = 0.4` |
| Flea price warning (buying above / listing below the 7-day average) | above 150% / below 70% | `Flea.WarnHigh = 1.5`, `Flea.WarnLow = 0.7` |

## 2.13 Settings defaults

| Setting | Default | Config key |
|---|---|---|
| Camera shake | 100% (0–100%) | `Settings.Shake = 1` |
| Reduce motion | off (scales all camera effects to 25% and removes FOV kicks) | `Settings.ReduceMotion = false` |
| Shoulder | right | `Settings.Shoulder = "Right"` |
| Mobile auto-sprint | on | `Settings.AutoSprint = true` |
| Aim assist (mobile and gamepad only) | on | `Settings.AimAssist = true` |
| Toggle aim (vs hold) | hold on PC, toggle on mobile | `Settings.ToggleAim` |
| Master / music / SFX / voice volume | 100 / 70 / 100 / 100 | `Settings.Volume.*` |
| Colour-blind tier icons (shapes added to tier colours) | off | `Settings.TierShapes = false` |
| Subtitles for NPC lines and radio | on | `Settings.Subtitles = true` |
