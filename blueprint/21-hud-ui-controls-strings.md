# 21 · HUD, UI, controls and strings

Owner of: control bindings on PC, gamepad and mobile for every context; the raid HUD, the tower HUD, all screens and panels; tutorial prompts; accessibility; the visual style of UI; and every on-screen string (`STR.*`). If on-screen text differs anywhere, §21.10 wins.

---

## 21.1 Principles

1. **Diegetic first.** Time is on the wristwatch, fear is in the camera and the heartbeat, stamina is in the breathing. The HUD shows only what the body can't.
2. **No crosshair on PC.** Mobile and gamepad get a dim 2 px dot only while aiming (`07` §7.2).
3. **One objective marker:** the evac exit during Red Alert (`10` §10.2). Squad tags and pings are squad-only (`20`).
4. **Icon first, short text.** Every prompt has an icon and at most 5 words. Strings live in `src/shared/Strings.luau`.
5. **Mobile first.** All touch targets ≥ 44 px at 1× scale. The HUD reflows for 16:9 phones, 4:3 tablets and ultrawide.
6. **Never hide a stranger's intent.** No hostility markers, no Sleeper icons, no names on strangers in raids.

## 21.2 Controls

### Raid (human)

| Action | PC | Gamepad | Mobile |
|---|---|---|---|
| Move | WASD | Left stick | Left thumb stick (dynamic) |
| Look | Mouse | Right stick | Drag right half of screen |
| Sprint | hold Shift | L3 click (toggle) | Auto when stick pushed past 90% (setting) or Sprint button |
| Crouch | C (toggle) | B | Crouch button |
| Prone / crawl | hold C 0.5 s (again to rise) | hold B 0.5 s | long-press Crouch button |
| Slide | V while sprinting | B while sprinting | Crouch while sprinting |
| Roll / traversal (mantle, vault, window, edge drop) | Space | A | Action button |
| Context (search, open, pick up, shutters, doors, revive, takedown, shove, ladder, terminal) | E (tap or hold as prompted) | X (when a prompt shows; otherwise X is Reload) | Context button (shows the prompt icon) |
| Aim | hold RMB (setting: toggle) | LT | Aim button (toggle) |
| Fire / attack | LMB | RT | Fire button (shown only while aiming) |
| Heavy melee | hold LMB 0.6 s | hold RT 0.6 s | hold Fire/Attack 0.6 s |
| Shove | E tap at a target, not aiming | RB tap | Shove button (replaces Fire when not aiming) |
| Reload | R | X | Reload button |
| Swap weapon | X (cycle), 1 / 2 / 3 direct | Y | Weapon wheel (tap a weapon icon) |
| Holster | B | hold Y | Holster in the weapon wheel |
| Throw | hold G, release to throw | hold RB, release | Throw button in the quick bar (drag to aim) |
| Flashlight | F | D-pad up | Light button |
| Watch | hold T | hold D-pad down | Watch button |
| Hold breath | hold Ctrl | hold LB | Breath button |
| Shoulder swap | Q | R3 click | Swap button |
| Quick slots 1–4 | 4 / 5 / 6 / 7 | Quick wheel: hold LB + RB | Quick bar (4 buttons) |
| Inventory | Tab | View | Backpack button |
| Comms wheel (quick lines; emotes page 2) | hold Z (quick lines), tap H (emotes) | D-pad left tap | Comms button tap |
| Gesture hold (Sleeper scent, `09` §9.6) | hold H 1 s | hold D-pad left 1 s | long-press Comms 1 s |
| Ping | Middle mouse | D-pad right tap | Ping button |
| Squad radio | hold Caps Lock | hold D-pad right | hold Radio button |
| Struggle | Space or LMB | A | Tap the bar |
| Free cursor | Alt (toggle) | — | — |
| Menu | Esc | Menu | Roblox menu button |

Gamepad quick slots use the **quick wheel**: hold LB and RB together, choose with the right stick, release. Hold breath stays on LB alone (the wheel needs both).

### Raid (Stalker Mutant)

| Action | PC | Gamepad | Mobile |
|---|---|---|---|
| Claw | LMB | RT | Claw button |
| Pounce | RMB (toward the looked-at target within 12) | LT | Pounce button |
| Climb | hold Space at a wall | hold A | Climb button |
| Roar (replaces quick lines) | Z | D-pad left | Comms button |

### Raid (Supermutant)

| Action | PC | Gamepad | Mobile |
|---|---|---|---|
| Slam | LMB | RT | Slam button |
| Charge | Shift + move | LB | Charge button |
| Echolocation Screech | E | Y | Screech button |
| Surface run | automatic | automatic | automatic |

### Ghost (dead Sleeper)

| Action | PC | Gamepad | Mobile |
|---|---|---|---|
| Orbit camera | Mouse | Right stick | Drag |
| Tools 1–4 (`09` §9.10), targeting what the camera centre is on | 1 / 2 / 3 / 4 | X / Y / B / A | 4 tool buttons |

### Spectating

| Action | PC | Gamepad | Mobile |
|---|---|---|---|
| Next / previous target | LMB / RMB | RB / LB | Arrows |
| Leave to tower | Esc menu > Leave | Menu > Leave | Leave button |

### Tower and flat

| Action | PC | Gamepad | Mobile |
|---|---|---|---|
| Move, look, sprint, crouch | as raid | as raid | as raid |
| Interact (NPCs, terminals, doors, lifts, seats) | E | X | Context button |
| Party panel | P | hold View | Party button |
| Shop | K | Menu > Shop | Shop button |
| Build mode (own flat) | B | Y | Build button |
| Build: rotate / snap toggle / confirm / store / cancel | R / Shift / LMB / Del / Esc | bumpers / L3 / A / X / B | Rotate / Snap / Place / Store / Cancel buttons |
| Emotes | tap H | D-pad left (page 2) | Comms > Emotes |

The tower has no aim and no weapons.

### Rebinding

- PC keys and gamepad buttons can be rebound in Settings > Controls (`UI-SET-010`), except Esc/Menu. Mobile buttons can be moved and scaled in Settings > Layout (`UI-SET-020`, drag to place, 3 sizes, saved per device).

## 21.3 Raid HUD layout

```
┌───────────────────────────────────────────────────────────────┐
│ [Squad list]                [Evac timer]          [Catalyst]  │
│  UI-HUD-010                  UI-HUD-041            UI-HUD-070 │
│                                                               │
│                 (evac marker UI-HUD-040 on screen edge)       │
│                                                               │
│                    [Prompt UI-HUD-030]                        │
│                                                               │
│ [Vitals UI-HUD-020]                       [Weapon UI-HUD-001] │
│ [Status icons UI-HUD-021]          [Quick bar UI-HUD-002]     │
└───────────────────────────────────────────────────────────────┘
```

| Element | Id | Shows | When visible |
|---|---|---|---|
| Squad list | `UI-HUD-010` | mates' survivor names, health bars, state icons (alive, Downed, dead). Never Sleeper status. | squads of 2+ |
| Vitals | `UI-HUD-020` | a thin health bar (no number), a body silhouette with zone colours (white ok, orange fractured, red bleeding) | 5 s after any health change, while injured, and when the inventory is open |
| Status icons | `UI-HUD-021` | Light bleed, Heavy bleed, Leg fracture, Arm fracture, Painkillers (with ring timer), Suppressant pause (Sleeper only, own screen), Overweight, Well Rested, Adrenaline | while active |
| Stamina arc | `UI-HUD-022` | thin arc beside the weapon panel | only while stamina is below 100 and draining (setting can hide it) |
| Weight bar | `UI-HUD-023` | carried kg / limit with encumbrance colour | in the inventory; on the HUD only while overweight |
| Weapon panel | `UI-HUD-001` | weapon icon, rounds in mag as pips (no reserve count; reserve shown as "Low" / "OK" / "Empty"), fire mode | while a gun is drawn |
| Quick bar | `UI-HUD-002` | 4 quick slots with item icons and counts | always (mobile); PC/gamepad: 3 s after use, and while the inventory is open |
| Prompt | `UI-HUD-030` | icon, action word, hold ring | when a Context action is available |
| Evac marker | `UI-HUD-040` | arrow on screen edge or a diamond at the exit with distance | Red Alert to raid end |
| Evac timer | `UI-HUD-041` | MM:SS countdown, colour by state (amber countdown, green open, red Lockdown, green Reopen) | Red Alert to raid end |
| Terminal ring | `UI-HUD-042` | activation progress | while activating |
| Catalyst icon | `UI-HUD-070` | catalyst icon; tap/hover opens live odds | catalyst raids |
| Wanted tag | `UI-HUD-060` | "WANTED · {pot} MC" | own screen, if you have a bounty |
| VIP radio | `UI-HUD-061` | Client health bar and gold marker | Bodyguards |
| Pings | `UI-HUD-080…083` | squad pings | 10 s each |
| Squad tags | `UI-HUD-084`, `UI-HUD-085` | `20` §20.4 | |
| Struggle bar | `UI-STR-001` | `09` §9.2 | struggles |
| Sleeper veins | `UI-INF-001` | `09` §9.4 | own screen |
| Scanner result | `UI-INF-010` | `09` §9.9 | after a scan |
| Ghost tools | `UI-GHO-001` | 4 tools with cooldown rings, range ring | Ghosts |
| Supermutant kit | `UI-MUT-001` | HP bar, 3 ability icons with cooldowns | Supermutant |
| Stalker kit | `UI-MUT-002` | HP bar, pounce cooldown | Stalker Mutant |
| Revive prompt | `UI-MUT-010` | 10 s Second Wind prompt | `09` §9.14 |
| Downed bar | `UI-HUD-024` | bleed-out bar (own screen) | Downed |
| Damage direction | `UI-HUD-025` | red arc at the screen edge toward the damage source, 0.6 s | on damage |
| Toasts | `UI-HUD-050` | level-up, contract done, achievement | queue, 3 s each, top-right |
| Subtitles | `UI-HUD-090` | radio, PA and NPC lines | setting on |

- **Wristwatch** (`ANIM-ACT-020`): the time and evac phase render on a SurfaceGui on the watch face model (`MDL-PLR-010`), not on the HUD.
- **Low health** and **fear** effects are post-processing (`05` §5.4, §5.6): `ColorCorrection`, `Blur`, vignette image `UI-VFX-001`.
- **Hit feedback** has no hitmarker (`07` §7.8).

## 21.4 Inventory and container screens

- Inventory (`UI-INV-001`): left = equip slots on a survivor paper-doll; centre = pockets, Safe Pocket, Blueprint Slot, quick slots; right = backpack grid; bottom = weight bar, Craft tab (`UI-INV-020`). Container panel (`UI-INV-010`) opens to the right of the backpack, pushing it left.
- Item tile: icon (`UI-ITM-001…093`, one per item, listed in `27`), tier colour edge, tier shape if Colour-blind setting is on (circle Common, triangle Uncommon, square Rare, diamond Epic, star Exotic, crown Relic), stack count, durability bar for armour and melee.
- Tooltip (hover / gamepad focus / mobile tap): name, tier, value, size, weight, description, actions.
- Drag and drop: mouse drag; gamepad A pick up, stick to move, A place, X rotate; mobile drag with finger, rotate button while dragging.
- Corpse loot (`11` §11.9) uses the container panel.

## 21.5 Screens and panels (catalogue)

| Id | Screen | File |
|---|---|---|
| `UI-ARR-001` | Arrival: Go home / Visit friend / relocation notice | `14` |
| `UI-SUR-001` | Survivor Draft (3 cards) | `13` |
| `UI-DEP-001…003` | Deploy panel, Raid found, Searching | `20` |
| `UI-DEP-010` | Insurance | `16` |
| `UI-RES-001` | Haul tally (extracted) | `03` |
| `UI-RES-010` | Death screen (cause, killer portrait if human, what you lost, death payout, "Put a price on their head") | `03`, `17` |
| `UI-RES-020` | Raid summary (time, kills, XP bar, contracts progress) | `03` |
| `UI-TWR-001` | Lift floor picker | `14` |
| `UI-TWR-010` | Concierge: vacancies, Move-in, waitlist, upgrades, visits | `14` |
| `UI-TWR-020` | Party panel | `20` |
| `UI-TWR-030` | Nameplate (display name, title badge, frame) | `14`, `17` |
| `UI-FLT-001` | Stash | `15` |
| `UI-FLT-010` | Workbench (learn, craft, repair, queue) | `12` |
| `UI-FLT-020` | Flat terminal (rent, upgrades, door settings, contracts, stats, mail, achievements, catalogue, VIP) | `15` |
| `UI-FLT-030` | Build catalogue | `15` |
| `UI-FLT-040` | Gunsmith: finishes, stickers, charms | `19` |
| `UI-COL-001` | Collection Book | `13` |
| `UI-VEN-001` | Vendor buy/sell | `16` |
| `UI-FLEA-001…003` | Flea browse, barter, appraisal | `16` |
| `UI-MAIL-001`, `UI-MAIL-010` | Mail, Repossession | `16` |
| `UI-BNT-001`, `UI-BNT-002`, `UI-BNT-010`, `UI-BNT-020`, `UI-BNT-030`, `UI-BNT-040` | Wall, viewport card, claim, dossier, escort, hire board | `17` |
| `UI-REL-001`, `UI-REL-010`, `UI-REL-020` | Engrave, pressing booth, history card | `18` |
| `UI-SHOP-001`, `UI-SHOP-010`, `UI-SHOP-020` | Shop, preview, odds tables | `19` |
| `UI-PASS-001`, `UI-PASS-010` | Evac Pass, restricted crate choice | `19` |
| `UI-CAT-001` | Catalyst dealer | `19` |
| `UI-LAB-001` | Supermutant variants | `19` |
| `UI-WHL-001` | Blueprint Wheel and Fixed Trade-up | `12` |
| `UI-COM-001`, `UI-COM-002`, `UI-COM-010` | Quick-line wheel, speech bubble, emote wheel | `20` |
| `UI-SET-001`, `UI-SET-010`, `UI-SET-020` | Settings: General, Controls, Layout, Audio, Graphics, Accessibility | §21.7 |
| `UI-ADM-001` | Admin menu | `22` |

All panels share one frame style (`UI-FRM-001` 9-slice panel, `UI-FRM-002` header bar, `UI-FRM-003` button, `UI-FRM-004` tab). Panels open with a 0.15 s scale-in (none with Reduce Motion) and `SFX-UI-001`; close with `SFX-UI-002`. Buttons: hover `SFX-UI-003`, press `SFX-UI-004`, error `SFX-UI-005`.

## 21.6 Tower HUD

- Top-left: Mall Cash balance (`UI-ICO-001` + number) and level badge with XP ring (`UI-HUD-100`).
- Top-right: Shop, Pass, Invite, Party, Settings buttons (`UI-HUD-101…105`). Mail dot on the flat terminal only.
- Bottom-centre: interaction prompt. Bottom-right (mobile): Context, Sprint, Crouch, Comms.
- Toasts top-right. No raid HUD elements in the tower.

## 21.7 Settings (`UI-SET-001`, `UI-SET-010`, `UI-SET-020`)

- **General:** shoulder, toggle aim, auto-sprint, aim assist, Allow catalyst raids (`19` §19.7), Skip Orientation (returning players only).
- **Controls / Layout:** §21.2 rebinding.
- **Audio:** master, music, SFX, voice volumes (`02` §2.13); mono audio toggle.
- **Graphics:** quality auto/low/med/high (shadows, particle density, draw distance, AI ragdoll count); FPS cap 30/60/uncapped.
- **Accessibility:** camera shake %, Reduce Motion, Colour-blind tier shapes, subtitles, subtitle size (S/M/L), struggle bar high-contrast mode (thicker zone, bright needle), hold-to-toggle for all hold actions (except Struggle).
- Settings save to the profile (`settings` table) and apply instantly.

## 21.8 Prompts and tutorial hints

- Context prompts show the action word from `STR.ACT.*` with the item or object icon and a hold ring.
- **First-time hints** (once per account, small panel at left, 4 s, `UI-HUD-110`): first container (`STR.HINT.CONTAINER`), first crawl space (`STR.HINT.CRAWL`, also the prompt at every crawl-space entrance), first locked door (`STR.HINT.LOCKED`), first shutter (`STR.HINT.SHUTTER`), first generator (`STR.HINT.GENERATOR`), first glass (`STR.HINT.GLASS`), first Red Alert (`STR.HINT.REDALERT`), first time overweight (`STR.HINT.OVERWEIGHT`), first Fuel Can (`STR.HINT.FUEL`), first keycard (`STR.HINT.KEYCARD`), first bite outside the tutorial (`STR.HINT.CURE`), first time in the tower (`STR.HINT.TOWER`), first Flea visit at level 5 (`STR.HINT.FLEA`).
- Orientation Run prompts: `03` §3.9.

## 21.9 Visual style of UI

- Look: scuffed safety-yellow and charcoal, stencil headings, mono numbers. Font: **Gotham SSm** for body, **Michroma**-style display via Roblox built-in `Enum.Font.Michroma` for headings; numbers `Enum.Font.RobotoMono`.
- Colours: panel #1E1F22 at 92%, text #EDEDED, accent #F2C230 (safety yellow), danger #D9412B, success #3FAF5A. Tier colours `02` §2.11.
- Icons: 2-colour line icons, 64 px source (`UI-ICO-*`).

## 21.10 Strings (`src/shared/Strings.luau`)

All on-screen text. English at launch; keys are stable for translation (Roblox automatic translation is on for everything except proper names). `{x}` marks a variable.

### Actions (`STR.ACT.*`)
| Key | Text |
|---|---|
| STR.ACT.SEARCH | Search |
| STR.ACT.OPEN | Open |
| STR.ACT.CLOSE | Close |
| STR.ACT.PICKUP | Pick up |
| STR.ACT.SHUTTER_UP | Raise shutter |
| STR.ACT.SHUTTER_HALF | Half shutter |
| STR.ACT.SHUTTER_DOWN | Lower shutter |
| STR.ACT.BARRICADE | Barricade |
| STR.ACT.WEDGE | Wedge door |
| STR.ACT.PRY | Pry open |
| STR.ACT.SWIPE | Use keycard |
| STR.ACT.CODE | Enter code |
| STR.ACT.FUEL | Start generator |
| STR.ACT.TERMINAL | Trigger evac |
| STR.ACT.REVIVE | Revive |
| STR.ACT.HEAL | Treat |
| STR.ACT.TAKEDOWN | Takedown |
| STR.ACT.SHOVE | Shove |
| STR.ACT.LADDER | Climb |
| STR.ACT.LIFT | Call lift |
| STR.ACT.LOOT | Loot |
| STR.ACT.HARVEST | Harvest Dogtag |
| STR.ACT.TURN_OFF | Turn off |
| STR.ACT.KNOCK | Knock |
| STR.ACT.ENTER | Enter |
| STR.ACT.TALK | Talk |
| STR.ACT.SIT | Sit |
| STR.ACT.CRAFT | Craft |
| STR.ACT.TRIP | Check |

(`STR.ACT.TRIP` is the Sleeper's alarm prompt, deliberately the same word humans see on alarm boxes: "Check".)

### Raid (`STR.RAID.*`, `STR.EVAC.*`, `STR.INF.*`, `STR.MUT.*`, `STR.RAD.*`)
| Key | Text |
|---|---|
| STR.RAID.DEPLOY | Gate {gate}. Doors opening. |
| STR.RAID.TERMINALS_LIVE | Security terminals are online. |
| STR.RAID.FAILSAFE_SOON | Automatic evac in 60 seconds. |
| STR.RAID.FAILSAFE | Automatic evac triggered. |
| STR.RAID.LEAVE_CONFIRM | Leave the raid? You'll lose everything you're carrying. |
| STR.RAID.SEALED | The mall has been sealed. |
| STR.RAID.RECONNECT | Reconnecting to your raid… |
| STR.EVAC.REDALERT | RED ALERT. Evac at the {exit}. |
| STR.EVAC.HELIPAD | Rooftop Helipad |
| STR.EVAC.GARAGE | Basement Garage |
| STR.EVAC.OPEN | Evac open. Get in. |
| STR.EVAC.DEPART | Departing… |
| STR.EVAC.EXTRACTED | Extracted. |
| STR.EVAC.LOCKDOWN | LOCKDOWN. Something came in with you. |
| STR.EVAC.REOPEN | Doors open. Last chance. |
| STR.EVAC.EARLY | Hold to depart now |
| STR.INF.BITTEN | You've been bitten. Find an Antidote, or don't. |
| STR.INF.TURNING | You're turning. |
| STR.INF.CURED | The fever breaks. You're clean. |
| STR.INF.SUPPRESSED | The burning fades… for now. |
| STR.INF.SCAN_CLEAN | No infection detected. |
| STR.INF.SCAN_INFECTED | INFECTED. |
| STR.INF.THERMO | Temperature: {temp}°C |
| STR.MUT.STALKER | You've turned. Hunt. |
| STR.MUT.SUPER | You are the Supermutant. |
| STR.MUT.GHOST | You're dead. Your body isn't. |
| STR.MUT.REVIVE | Rise again? Second Wind ({price}) |
| STR.MUT.TOKEN_USED | Revive Token used. |
| STR.RAD.BOUNTY | Bounty sighting. {wing}. |
| STR.RAD.JANITOR | Maintenance staff on duty. Stay clear of the service corridors. |

### Inventory, loot and crafting (`STR.INV.*`, `STR.LOOT.*`, `STR.CRF.*`)
| Key | Text |
|---|---|
| STR.INV.FULL | No room. |
| STR.INV.OVERWEIGHT | Overweight. |
| STR.INV.SAFE | Safe Pocket: kept if you die. |
| STR.INV.BLUEPRINT | Blueprint Slot: kept if you die. |
| STR.INV.HANDOVER | {player} wants to hand you {item}. |
| STR.INV.HANDOVER_ACCEPT | Accept |
| STR.INV.HANDOVER_DECLINE | Decline |
| STR.LOOT.RELIC | RELIC FOUND |
| STR.LOOT.EMPTY | Empty. |
| STR.CRF.LEARNED | Blueprint learned: {item}. |
| STR.CRF.KNOWN | Known |
| STR.CRF.QUEUED | Crafting: {item} · {time} |
| STR.CRF.DONE | Ready at your workbench: {item}. |
| STR.CRF.MISSING | Missing materials. |

### Results (`STR.RES.*`)
| Key | Text |
|---|---|
| STR.RES.EXTRACTED | EXTRACTED |
| STR.RES.DIED | YOU DIED |
| STR.RES.CAUSE | {cause} |
| STR.RES.KILLED_BY_RAIDER | Killed by a raider |
| STR.RES.HAUL | Haul value: {value} MC |
| STR.RES.LOST | Lost: {value} MC |
| STR.RES.PAYOUT | Death payout: {value} MC · {xp} XP |
| STR.RES.BLUEPRINT_NEW | New blueprint! |
| STR.RES.HELPED | Helped by a stranger ×{n} |
| STR.RES.RETIRED | {survivor} is gone. Pick your next survivor. |

### Tower, residency and flats (`STR.TWR.*`, `STR.FLT.*`)
| Key | Text |
|---|---|
| STR.TWR.WELCOME | High-Rise Tower {n} |
| STR.TWR.READONLY | Tower records are busy. You can play, but flat changes are paused. |
| STR.TWR.RELOCATED | While you were away, your flat moved to High-Rise Tower {n}. Everything is safe. |
| STR.TWR.TICKET_GRANTED | The slot was taken, so you got a Move Ticket. Use it any time. |
| STR.TWR.SWITCH_INSTANCE | Your friend is in another part of the tower. Join them? |
| STR.TWR.FULL | No vacancies at your tier. Join the waitlist? |
| STR.TWR.WAITLIST | You're #{n} on the waitlist. |
| STR.TWR.CLAIM | A flat is free! You have 48 hours to claim it. |
| STR.TWR.MOVED | Welcome home. |
| STR.TWR.CONDEMNED | Condemned |
| STR.TWR.KNOCK | {player} is knocking. |
| STR.FLT.RENT_DUE | Rent due: {value} MC. Perks paused until paid. |
| STR.FLT.RENT_PAID | Rent paid until {date}. |
| STR.FLT.OVERFLOW | Overflow Crate has items. They'll be sold in {days} days. |
| STR.FLT.BUILD_INVALID | Can't place here. |
| STR.FLT.CAP | Furniture limit reached. |

### Economy (`STR.FLEA.*`, `STR.VEN.*`, `STR.MAIL.*`, `STR.INS.*`)
| Key | Text |
|---|---|
| STR.FLEA.LOCKED | The Flea opens at level 5. |
| STR.FLEA.CONFIRM | Buy {item} for {price} MC? Balance after: {balance} MC |
| STR.FLEA.PAID_RESTRICTED | This item can't be traded in your region. |
| STR.FLEA.LISTED | Listed for 48 hours. |
| STR.FLEA.SOLD | Sold: {item} for {price} MC (tax {tax} MC). |
| STR.FLEA.EXPIRED | Listing expired. {item} is in your mail. |
| STR.FLEA.PRICE_RANGE | Price must be between {min} and {max} MC. |
| STR.FLEA.WARN_HIGH | This is {pct}% of the usual price ({avg} MC). Hold to buy anyway. |
| STR.FLEA.WARN_LOW | This is only {pct}% of the usual price ({avg} MC). Hold to list anyway. |
| STR.FLEA.BARTER_VALUE | You give about {give} MC. You get about {get} MC. |
| STR.FLEA.HISTORY | Your Flea history |
| STR.VEN.CONFIRM_SELL | Sell {item} for {price} MC? |
| STR.MAIL.NEW | You have mail. |
| STR.MAIL.CLAIM | Claim |
| STR.INS.RETURNED | Insured gear returned: {items}. |
| STR.INS.TAKEN | {item} was taken by a raider. |
| STR.INS.REPO | Lost gear is in Repossession for 24 hours. |

### Bounties and roles (`STR.BNT.*`)
| Key | Text |
|---|---|
| STR.BNT.CONTRIBUTE | Put a price on their head |
| STR.BNT.CLAIMED | Bounty collected: {value} MC |
| STR.BNT.JUSTICE | Justice: +{value} MC |
| STR.BNT.WANTED | WANTED · {value} MC |
| STR.BNT.TOP10 | You're on the Most Wanted Wall. |
| STR.BNT.ENDED | Your bounty has ended. |
| STR.BNT.TICKET | Claim Ticket: +25% on this target |
| STR.BNT.ESCORT_DONE | Client extracted. +{value} MC |
| STR.BNT.ESCORT_FAIL | Client lost. |

### Relics (`STR.REL.*`)
| Key | Text |
|---|---|
| STR.REL.FOUND_YOURS | Someone found your {relic}. |
| STR.REL.FOUND_LOST | Your lost {item} turned up. Someone extracted it from {wing}. |
| STR.REL.RETURNED | It found its way back to you. |
| STR.REL.PRESSED | Pressed! One copy is yours. The other is out there now. |
| STR.REL.ENGRAVED | Engraved: {title} |
| STR.REL.NOW_PLAYING | Now playing: {title} |

### Survivors, progression and contracts (`STR.SUR.*`, `STR.PRG.*`, `STR.CON.*`, `STR.ACH.*`)
| Key | Text |
|---|---|
| STR.SUR.DRAFT | Choose your survivor |
| STR.SUR.ODDS | Odds |
| STR.SUR.REROLL_LOCKED | Rerolls are only possible before a survivor's first raid. |
| STR.PRG.LEVELUP | Level {n}! |
| STR.PRG.UNLOCK | Unlocked: {thing} |
| STR.CON.DONE | Contract complete: {name} |
| STR.CON.ALL | All daily contracts done! +{value} MC |
| STR.ACH.UNLOCKED | Achievement: {name} |

### Wheel, shop and passes (`STR.WHEEL.*`, `STR.SHOP.*`, `STR.PASS.*`)
| Key | Text |
|---|---|
| STR.WHEEL.PITY | Robux spins since last success: {n}/10 |
| STR.WHEEL.RESTRICTED | Spins aren't available in your region. Use the Fixed Trade-up. |
| STR.WHEEL.SUCCESS | Success! |
| STR.WHEEL.DOWNGRADE | Swapped for another blueprint. |
| STR.WHEEL.DESTROYED | Destroyed. |
| STR.SHOP.ODDS | Odds |
| STR.SHOP.OWNED | Owned |
| STR.SHOP.GIFT | Gift |
| STR.SHOP.TOKEN | Your purchase was saved as a {token}. |
| STR.PASS.TIER | Tier {n} |
| STR.PASS.CATCHUP | Double Pass XP this week! |

### Quick lines (`STR.QL.*`)
| Key | Text |
|---|---|
| STR.QL.FRIENDLY | Friendly! |
| STR.QL.DONTSHOOT | Don't shoot! |
| STR.QL.FOLLOW | Follow me |
| STR.QL.HELP | Help! |
| STR.QL.DANGER | Danger! |
| STR.QL.THANKS | Thanks |
| STR.QL.OVERHERE | Over here |
| STR.QL.WAIT | Wait |

### Tutorial and hints (`STR.TUT.*`, `STR.HINT.*`)
| Key | Text |
|---|---|
| STR.TUT.MOVE | Move and look around. |
| STR.TUT.CROUCH | Crouch to stay quiet. |
| STR.TUT.THROW | Throw something to lure it away. |
| STR.TUT.STRUGGLE_OK | Nice. Every grab gets harder. |
| STR.TUT.BITTEN | You're infected. Find the Antidote in the pharmacy kiosk. |
| STR.TUT.SKIP | Skip Orientation |
| STR.HINT.CONTAINER | Hold to search. Rare items take longer to reveal. |
| STR.HINT.CRAWL | Hold Crouch to crawl through. |
| STR.HINT.LOCKED | Locked. Find a keycard, or pry it with a crowbar. |
| STR.HINT.SHUTTER | Lower a shutter to hide. Half lets you peek. |
| STR.HINT.GENERATOR | Fuel a generator to power this wing. Light shows you, too. |
| STR.HINT.GLASS | Broken glass crunches. Watch your step. |
| STR.HINT.REDALERT | Get to the exit before the doors close. |
| STR.HINT.OVERWEIGHT | Too heavy: slower and louder. |
| STR.HINT.FUEL | Fuel Can: starts a generator. |
| STR.HINT.KEYCARD | Keycards open stockrooms and safes. |
| STR.HINT.CURE | Bitten. Antidotes are in Med Safes. Suppressants buy time. |
| STR.HINT.TOWER | This is your tower. Your flat is upstairs. Raids leave from the Transit Gates. |
| STR.HINT.FLEA | The Flea is open. Buy and sell with other players. |

### NPCs (`STR.NPC.*`)
- Each NPC voice line `VO-NPC-xxx` has a subtitle `STR.NPC.<NAME>.<n>`; the script for every line is written with the voice cast in P1 (`26`) and pasted into `Strings`. Placeholder text until then: `STR.NPC.<NAME>.<n> = "[{NAME} line {n}]"`.

### Settings, generic (`STR.UI.*`)
| Key | Text |
|---|---|
| STR.UI.CONFIRM | Confirm |
| STR.UI.CANCEL | Cancel |
| STR.UI.BACK | Back |
| STR.UI.CLOSE | Close |
| STR.UI.LOADING | Loading… |
| STR.UI.ERROR | Something went wrong. Try again. |
| STR.UI.SAVING | Saving… |
| STR.UI.PLACEHOLDER | [placeholder] |
