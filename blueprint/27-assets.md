# 27 · Complete asset list

Owner of: every model, animation, sound, music track, voice line, UI image, VFX and texture in the game, with its id, what it is, the step that first needs it, and its placeholder size (models). **Generated** from `tools/assets_master.py` by `tools/build_assets.py`; edit the master, never this file. Code uses assets only through `AssetRegistry` (`25` §25.3). Each step's Asset requests in `26` are the rows under that step here.

## 27.1 Totals

| Kind | Count |
|---|---|
| Models (MDL) | 442 |
| Animations (ANIM) | 191 |
| Sound effects (SFX) | 341 |
| Music (MUS) | 75 |
| Voice (VO) | 232 |
| UI images (UI) | 493 |
| Visual effects (VFX) | 49 |
| Textures (TEX) | 128 |
| **All** | **1951** |

## 27.2 Delivery rules

- Models: R15-compatible where a character; pivot at the base centre; real-world scale (1 stud ≈ 0.28 m); under 10k triangles for props, 20k for characters; PBR SurfaceAppearance where possible; uploaded by the group.
- Animations: in place, R15, priorities per `04` §4.9, pass `ClipAnalyzer`.
- Audio: normalised per `24` §24.1; loops cut on zero crossings; mono for 3D sounds, stereo for music and UI.
- UI: PNG, power-of-two canvas, 2× resolution, transparent background; icons 128 px.
- Each delivered id is written into `AssetRegistry` and checked in game the same day.

## Step S1

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-CHR-037 | MDL | Survivor build 1 (slim, medium, heavy R15 body) | 2x5x1 |
| MDL-CHR-038 | MDL | Survivor build 2 (slim, medium, heavy R15 body) | 2x5x1 |
| MDL-CHR-039 | MDL | Survivor build 3 (slim, medium, heavy R15 body) | 2x5x1 |
| ANIM-ACT-001 | ANIM | Roll (lunge dodge, in place) | — |
| ANIM-ACT-002 | ANIM | Slide (hips dip, in place) | — |
| ANIM-ACT-003 | ANIM | Get up from ragdoll, face down | — |
| ANIM-ACT-004 | ANIM | Soft landing | — |
| ANIM-ACT-005 | ANIM | Hard landing (0.4 s recovery) | — |
| ANIM-ACT-006 | ANIM | Get up from ragdoll, face up | — |
| ANIM-MOV-001 | ANIM | Idle (relaxed ready stance, weapon low) | — |
| ANIM-MOV-002 | ANIM | Walk (in place) | — |
| ANIM-MOV-003 | ANIM | Run / sprint (in place) | — |
| ANIM-MOV-004 | ANIM | Crouch idle | — |
| ANIM-MOV-005 | ANIM | Crouch walk | — |
| ANIM-MOV-006 | ANIM | Strafe left | — |
| ANIM-MOV-007 | ANIM | Strafe right | — |
| ANIM-MOV-008 | ANIM | Walk back | — |
| ANIM-MOV-009 | ANIM | Aimed walk forward | — |
| ANIM-MOV-010 | ANIM | Aimed walk back | — |
| ANIM-MOV-011 | ANIM | Walk start | — |
| ANIM-MOV-012 | ANIM | Walk stop | — |
| ANIM-MOV-013 | ANIM | Run start | — |
| ANIM-MOV-014 | ANIM | Run stop | — |
| ANIM-MOV-015 | ANIM | Overweight walk (hunched) | — |
| ANIM-MOV-018 | ANIM | Idle bored 1 (check watch glance) | — |
| ANIM-MOV-019 | ANIM | Idle bored 2 (adjust straps) | — |
| ANIM-MOV-020 | ANIM | Idle bored 3 (look over shoulder) | — |
| ANIM-MOV-021 | ANIM | Turn in place 90° | — |
| ANIM-MOV-022 | ANIM | Turn in place 180° | — |
| SFX-PLR-010 | SFX | Heartbeat loop (fear) | — |
| SFX-PLR-011 | SFX | Breathing calm | — |
| SFX-PLR-012 | SFX | Breathing heavy | — |
| SFX-PLR-013 | SFX | Breathing laboured | — |
| SFX-PLR-014 | SFX | Gasp (hold breath ends) | — |
| SFX-PLR-021 | SFX | Crouch rustle | — |
| SFX-PLR-022 | SFX | Roll | — |
| SFX-PLR-023 | SFX | Slide scrape loop | — |
| SFX-PLR-025 | SFX | Landing light | — |
| SFX-PLR-026 | SFX | Landing heavy | — |
| SFX-PLR-050 | SFX | Footstep tile 1 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-051 | SFX | Footstep tile 2 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-052 | SFX | Footstep tile 3 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-053 | SFX | Footstep tile 4 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-054 | SFX | Footstep tile 5 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-055 | SFX | Footstep tile 6 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-056 | SFX | Footstep concrete 1 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-057 | SFX | Footstep concrete 2 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-058 | SFX | Footstep concrete 3 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-059 | SFX | Footstep concrete 4 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-060 | SFX | Footstep concrete 5 (walk 1–3, sprint 4–6) | — |
| SFX-PLR-061 | SFX | Footstep concrete 6 (walk 1–3, sprint 4–6) | — |
| SFX-UI-001 | SFX | Panel open | — |
| SFX-UI-002 | SFX | Panel close | — |
| SFX-UI-003 | SFX | Hover | — |
| SFX-UI-004 | SFX | Press | — |
| SFX-UI-005 | SFX | Error | — |
| UI-ADM-001 | UI | Admin menu panel | — |
| UI-FRM-001 | UI | Panel 9-slice | — |
| UI-FRM-002 | UI | Header bar | — |
| UI-FRM-003 | UI | Button | — |
| UI-FRM-004 | UI | Tab | — |
| UI-HUD-022 | UI | Stamina arc | — |
| UI-MOB-001 | UI | Mobile button icon 1 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-002 | UI | Mobile button icon 2 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-003 | UI | Mobile button icon 3 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-004 | UI | Mobile button icon 4 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-005 | UI | Mobile button icon 5 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-006 | UI | Mobile button icon 6 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-007 | UI | Mobile button icon 7 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-008 | UI | Mobile button icon 8 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-009 | UI | Mobile button icon 9 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-010 | UI | Mobile button icon 10 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-011 | UI | Mobile button icon 11 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-012 | UI | Mobile button icon 12 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-013 | UI | Mobile button icon 13 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-014 | UI | Mobile button icon 14 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-015 | UI | Mobile button icon 15 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-016 | UI | Mobile button icon 16 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-017 | UI | Mobile button icon 17 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-018 | UI | Mobile button icon 18 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-019 | UI | Mobile button icon 19 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-020 | UI | Mobile button icon 20 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-021 | UI | Mobile button icon 21 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-022 | UI | Mobile button icon 22 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-023 | UI | Mobile button icon 23 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |
| UI-MOB-024 | UI | Mobile button icon 24 (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech) | — |

## Step S2

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ENV-010 | MDL | Roll-down shop shutter (3 states, animated) | 20x12x1 |
| MDL-ENV-020 | MDL | Ceiling light panel (shootable) | 2x1x2 |
| MDL-ENV-021 | MDL | Shop spotlight (shootable) | 2x1x2 |
| MDL-ENV-022 | MDL | Galleria pendant light (shootable) | 2x1x2 |
| MDL-ENV-023 | MDL | Emergency light (dim red) | 2x1x2 |
| MDL-ENV-070 | MDL | Security terminal (CRT, keyboard, green screen) | 3x5x2 |
| MDL-ENV-080 | MDL | Field workbench | 6x4x3 |
| MDL-ENV-090 | MDL | Ceiling PA speaker | 1x1x1 |
| MDL-ENV-100 | MDL | Mall decor kit piece 1 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-101 | MDL | Mall decor kit piece 2 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-102 | MDL | Mall decor kit piece 3 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-103 | MDL | Mall decor kit piece 4 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-104 | MDL | Mall decor kit piece 5 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-105 | MDL | Mall decor kit piece 6 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-106 | MDL | Mall decor kit piece 7 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-107 | MDL | Mall decor kit piece 8 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-108 | MDL | Mall decor kit piece 9 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-109 | MDL | Mall decor kit piece 10 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-110 | MDL | Mall directory board 'You are here' (per floor) | 4x7x1 |
| MDL-ENV-111 | MDL | Mall decor kit piece 12 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-112 | MDL | Mall decor kit piece 13 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-113 | MDL | Mall decor kit piece 14 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-114 | MDL | Mall decor kit piece 15 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-115 | MDL | Mall decor kit piece 16 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-116 | MDL | Mall decor kit piece 17 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-117 | MDL | Mall decor kit piece 18 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-118 | MDL | Mall decor kit piece 19 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-119 | MDL | Mall decor kit piece 20 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-120 | MDL | Mall decor kit piece 21 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-121 | MDL | Mall decor kit piece 22 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-122 | MDL | Mall decor kit piece 23 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-123 | MDL | Mall decor kit piece 24 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-124 | MDL | Mall decor kit piece 25 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-125 | MDL | Mall decor kit piece 26 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-126 | MDL | Mall decor kit piece 27 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-127 | MDL | Mall decor kit piece 28 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-128 | MDL | Mall decor kit piece 29 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-129 | MDL | Mall decor kit piece 30 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-130 | MDL | Mall decor kit piece 31 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-131 | MDL | Mall decor kit piece 32 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-132 | MDL | Mall decor kit piece 33 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-133 | MDL | Mall decor kit piece 34 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-134 | MDL | Mall decor kit piece 35 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-135 | MDL | Mall decor kit piece 36 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-136 | MDL | Mall decor kit piece 37 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-137 | MDL | Mall decor kit piece 38 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-138 | MDL | Mall decor kit piece 39 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-139 | MDL | Mall decor kit piece 40 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-140 | MDL | Mall decor kit piece 41 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-141 | MDL | Mall decor kit piece 42 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-142 | MDL | Mall decor kit piece 43 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-143 | MDL | Mall decor kit piece 44 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-144 | MDL | Mall decor kit piece 45 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-145 | MDL | Mall decor kit piece 46 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-146 | MDL | Mall decor kit piece 47 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-147 | MDL | Mall decor kit piece 48 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-148 | MDL | Mall decor kit piece 49 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-149 | MDL | Mall decor kit piece 50 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-150 | MDL | Mall decor kit piece 51 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-151 | MDL | Mall decor kit piece 52 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-152 | MDL | Mall decor kit piece 53 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-153 | MDL | Mall decor kit piece 54 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-154 | MDL | Mall decor kit piece 55 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-155 | MDL | Mall decor kit piece 56 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-156 | MDL | Mall decor kit piece 57 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-157 | MDL | Mall decor kit piece 58 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-158 | MDL | Mall decor kit piece 59 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-159 | MDL | Mall decor kit piece 60 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-160 | MDL | Mall decor kit piece 61 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-161 | MDL | Mall decor kit piece 62 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-162 | MDL | Mall decor kit piece 63 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-163 | MDL | Mall decor kit piece 64 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-164 | MDL | Mall decor kit piece 65 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-165 | MDL | Mall decor kit piece 66 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-166 | MDL | Mall decor kit piece 67 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-167 | MDL | Mall decor kit piece 68 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-168 | MDL | Mall decor kit piece 69 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-169 | MDL | Mall decor kit piece 70 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-170 | MDL | Mall decor kit piece 71 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-171 | MDL | Mall decor kit piece 72 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-172 | MDL | Mall decor kit piece 73 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-173 | MDL | Mall decor kit piece 74 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-174 | MDL | Mall decor kit piece 75 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-175 | MDL | Mall decor kit piece 76 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-176 | MDL | Mall decor kit piece 77 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-177 | MDL | Mall decor kit piece 78 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-178 | MDL | Mall decor kit piece 79 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-179 | MDL | Mall decor kit piece 80 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-180 | MDL | Mall decor kit piece 81 (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings) | 4x4x4 |
| MDL-ENV-181 | MDL | Service door (shop back door) | 4x8x0.5 |
| MDL-ENV-182 | MDL | Security door (heavy) | 6x8x0.6 |
| MDL-ENV-183 | MDL | Interior door | 4x8x0.4 |
| MDL-ENV-185 | MDL | Escalator (animated steps) | 6x14x30 |
| MDL-ENV-187 | MDL | Storefront glass pane (Large) | 20x12x0.3 |
| MDL-ENV-188 | MDL | Window glass pane (Medium) | 6x6x0.2 |
| MDL-ENV-191 | MDL | Skylight panel (galleria roof) | 20x1x20 |
| MDL-ENV-192 | MDL | Dry fountain (galleria centre) | 28x4x28 |
| MDL-ENV-196 | MDL | Outdoor backdrop (car parks, fences, burnt cars, city lights) | 800x40x800 |
| MDL-RAID-001 | MDL | Freight lift interior (entry gates) | 16x12x16 |
| MDL-RAID-012 | MDL | Rooftop helipad cage with two lockable gates | 40x10x40 |
| MDL-RAID-013 | MDL | Garage bay blast shutters (two) | 20x12x1 |
| SFX-AMB-001 | SFX | Raid ambience 1 (24 §24.3) | — |
| SFX-AMB-002 | SFX | Raid ambience 2 (24 §24.3) | — |
| SFX-AMB-003 | SFX | Raid ambience 3 (24 §24.3) | — |
| SFX-AMB-004 | SFX | Raid ambience 4 (24 §24.3) | — |
| SFX-AMB-005 | SFX | Raid ambience 5 (24 §24.3) | — |
| SFX-AMB-006 | SFX | Raid ambience 6 (24 §24.3) | — |
| SFX-AMB-007 | SFX | Raid ambience 7 (24 §24.3) | — |
| SFX-AMB-008 | SFX | Raid ambience 8 (24 §24.3) | — |
| SFX-ENV-047 | SFX | Emergency light buzz | — |
| SFX-PLR-062 | SFX | Footstep carpet | — |
| SFX-PLR-063 | SFX | Footstep metal | — |
| SFX-PLR-064 | SFX | Footstep glass shards crunch 1 | — |
| SFX-PLR-065 | SFX | Footstep glass shards crunch 2 | — |
| SFX-PLR-066 | SFX | Footstep water | — |
| SFX-PLR-067 | SFX | Footstep grate | — |
| VFX-ENV-020 | VFX | Dust motes in light shafts | — |
| TEX-ENV-001 | TEX | Mall surface / grime / blood / signage texture 1 | — |
| TEX-ENV-002 | TEX | Mall surface / grime / blood / signage texture 2 | — |
| TEX-ENV-003 | TEX | Mall surface / grime / blood / signage texture 3 | — |
| TEX-ENV-004 | TEX | Mall surface / grime / blood / signage texture 4 | — |
| TEX-ENV-005 | TEX | Mall surface / grime / blood / signage texture 5 | — |
| TEX-ENV-006 | TEX | Mall surface / grime / blood / signage texture 6 | — |
| TEX-ENV-007 | TEX | Mall surface / grime / blood / signage texture 7 | — |
| TEX-ENV-008 | TEX | Mall surface / grime / blood / signage texture 8 | — |
| TEX-ENV-009 | TEX | Mall surface / grime / blood / signage texture 9 | — |
| TEX-ENV-010 | TEX | Mall surface / grime / blood / signage texture 10 | — |
| TEX-ENV-011 | TEX | Mall surface / grime / blood / signage texture 11 | — |
| TEX-ENV-012 | TEX | Mall surface / grime / blood / signage texture 12 | — |
| TEX-ENV-013 | TEX | Mall surface / grime / blood / signage texture 13 | — |
| TEX-ENV-014 | TEX | Mall surface / grime / blood / signage texture 14 | — |
| TEX-ENV-015 | TEX | Mall surface / grime / blood / signage texture 15 | — |
| TEX-ENV-016 | TEX | Mall surface / grime / blood / signage texture 16 | — |
| TEX-ENV-017 | TEX | Mall surface / grime / blood / signage texture 17 | — |
| TEX-ENV-018 | TEX | Mall surface / grime / blood / signage texture 18 | — |
| TEX-ENV-019 | TEX | Mall surface / grime / blood / signage texture 19 | — |
| TEX-ENV-020 | TEX | Mall surface / grime / blood / signage texture 20 | — |
| TEX-ENV-021 | TEX | Mall surface / grime / blood / signage texture 21 | — |
| TEX-ENV-022 | TEX | Mall surface / grime / blood / signage texture 22 | — |
| TEX-ENV-023 | TEX | Mall surface / grime / blood / signage texture 23 | — |
| TEX-ENV-024 | TEX | Mall surface / grime / blood / signage texture 24 | — |
| TEX-ENV-025 | TEX | Mall surface / grime / blood / signage texture 25 | — |
| TEX-ENV-026 | TEX | Mall surface / grime / blood / signage texture 26 | — |
| TEX-ENV-027 | TEX | Mall surface / grime / blood / signage texture 27 | — |
| TEX-ENV-028 | TEX | Mall surface / grime / blood / signage texture 28 | — |
| TEX-ENV-029 | TEX | Mall surface / grime / blood / signage texture 29 | — |
| TEX-ENV-030 | TEX | Mall surface / grime / blood / signage texture 30 | — |
| TEX-ENV-031 | TEX | Mall surface / grime / blood / signage texture 31 | — |
| TEX-ENV-032 | TEX | Mall surface / grime / blood / signage texture 32 | — |
| TEX-ENV-033 | TEX | Mall surface / grime / blood / signage texture 33 | — |
| TEX-ENV-034 | TEX | Mall surface / grime / blood / signage texture 34 | — |
| TEX-ENV-035 | TEX | Mall surface / grime / blood / signage texture 35 | — |
| TEX-ENV-036 | TEX | Mall surface / grime / blood / signage texture 36 | — |
| TEX-ENV-037 | TEX | Mall surface / grime / blood / signage texture 37 | — |
| TEX-ENV-038 | TEX | Mall surface / grime / blood / signage texture 38 | — |
| TEX-ENV-039 | TEX | Mall surface / grime / blood / signage texture 39 | — |
| TEX-ENV-040 | TEX | Mall surface / grime / blood / signage texture 40 | — |

## Step S3

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ARR-001 | MDL | Arrival freight-lift interior (dark, flickering light) | 16x12x16 |
| MDL-PLR-010 | MDL | Wristwatch with SurfaceGui face | 0.3x0.1x0.3 |
| MDL-TWR-001 | MDL | Tower freight-elevator loading scene (Arrival → Tower) | 16x12x16 |
| MDL-TWR-080 | MDL | Transit Gates freight elevator doors (4) and deploy hall | 40x14x20 |
| ANIM-ACT-020 | ANIM | Raise left wrist to read watch (upper body, hold loop) | — |
| SFX-RAID-001 | SFX | Freight lift descent | — |
| SFX-RAID-002 | SFX | Lift doors open | — |
| SFX-TWR-001 | SFX | Arrival loading scene | — |
| MUS-RAID-001 | MUS | Raid ambient drone | — |
| MUS-TWR-004 | MUS | Arrival connecting loop | — |
| MUS-UI-020 | MUS | Title sting (Arrival) | — |
| VO-PA-001 | VO | PA: facility under quarantine (Deploy) | — |
| UI-ARR-001 | UI | Arrival screen (Go home / Visit friend / notices) | — |
| UI-RES-020 | UI | Raid summary | — |

## Step S4

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-CON-001 | MDL | Trash bin | 3x4x2 |
| MDL-CON-002 | MDL | Rubble pile | 3x4x2 |
| MDL-CON-003 | MDL | Store shelf | 3x4x2 |
| MDL-CON-004 | MDL | Clothes rack | 3x4x2 |
| MDL-CON-005 | MDL | Till / register | 3x4x2 |
| MDL-CON-006 | MDL | Staff locker | 3x4x2 |
| MDL-CON-007 | MDL | Staff bag | 3x4x2 |
| MDL-CON-008 | MDL | Display case (glass) | 3x4x2 |
| MDL-CON-009 | MDL | Med cabinet | 3x4x2 |
| MDL-CON-010 | MDL | Med Safe (metal, keypad + card slot) | 3x4x2 |
| MDL-CON-011 | MDL | Weapon crate (army green) | 3x4x2 |
| MDL-CON-012 | MDL | Stockroom crate | 3x4x2 |
| MDL-CON-013 | MDL | Toolbox | 3x4x2 |
| MDL-FLT-011 | MDL | Stash chest (also tower test stash in S4) | 4x3x2 |
| MDL-ITM-001 | MDL | Light ammo box | 1x1x1 |
| MDL-ITM-002 | MDL | Medium ammo box | 1x1x1 |
| MDL-ITM-003 | MDL | Heavy ammo box | 1x1x1 |
| MDL-ITM-004 | MDL | Shells box | 1x1x1 |
| MDL-ITM-010 | MDL | Bandage | 1x1x1 |
| MDL-ITM-011 | MDL | Gauze Pack | 1x1x1 |
| MDL-ITM-012 | MDL | Painkillers | 1x1x1 |
| MDL-ITM-013 | MDL | Medkit | 1x1x1 |
| MDL-ITM-014 | MDL | Splint | 1x1x1 |
| MDL-ITM-015 | MDL | Surgical Kit | 1x1x1 |
| MDL-ITM-016 | MDL | Infection Suppressant | 1x1x1 |
| MDL-ITM-017 | MDL | Antidote Syringe (glowing green) | 1x1x1 |
| MDL-ITM-018 | MDL | Adrenaline Shot | 1x1x1 |
| MDL-ITM-019 | MDL | Improvised Suppressant | 1x1x1 |
| MDL-ITM-020 | MDL | Rag | 1x1x1 |
| MDL-ITM-021 | MDL | Alcohol | 1x1x1 |
| MDL-ITM-022 | MDL | Tape | 1x1x1 |
| MDL-ITM-023 | MDL | Wire | 1x1x1 |
| MDL-ITM-024 | MDL | Radio | 1x1x1 |
| MDL-ITM-025 | MDL | Chemical Flask | 1x1x1 |
| MDL-ITM-026 | MDL | Syringe | 1x1x1 |
| MDL-ITM-027 | MDL | Scrap | 1x1x1 |
| MDL-ITM-028 | MDL | Mechanical Parts | 1x1x1 |
| MDL-ITM-029 | MDL | Electronic Parts | 1x1x1 |
| MDL-ITM-030 | MDL | Precision Parts | 1x1x1 |
| MDL-ITM-031 | MDL | Exotic Alloy | 1x1x1 |
| MDL-ITM-032 | MDL | Cloth | 1x1x1 |
| MDL-ITM-040 | MDL | Smartphone | 1x1x1 |
| MDL-ITM-041 | MDL | Wristwatch | 1x1x1 |
| MDL-ITM-042 | MDL | Perfume Bottle | 1x1x1 |
| MDL-ITM-043 | MDL | Cash Bundle | 1x1x1 |
| MDL-ITM-044 | MDL | Gold Chain | 1x1x1 |
| MDL-ITM-045 | MDL | Jewellery Box | 1x1x1 |
| MDL-ITM-046 | MDL | Designer Handbag | 1x1x1 |
| MDL-ITM-047 | MDL | Game Console | 1x1x1 |
| MDL-ITM-048 | MDL | Vintage Camera | 1x1x1 |
| MDL-ITM-049 | MDL | Golden Mall Statue | 1x1x1 |
| MDL-ITM-050 | MDL | Classified Security Keycard | 1x1x1 |
| MDL-ITM-060 | MDL | Flashlight | 1x1x1 |
| MDL-ITM-061 | MDL | Battery | 1x1x1 |
| MDL-ITM-062 | MDL | Door Wedge | 1x1x1 |
| MDL-ITM-063 | MDL | Planks (stack) | 1x1x1 |
| MDL-ITM-064 | MDL | Fuel Can | 1x1x1 |
| MDL-ITM-094 | MDL | Dropped item bag (small items) | 1x1x1 |
| MDL-ITM-095 | MDL | Blueprint (rolled paper, tier-coloured tube) | 1x1x1 |
| MDL-PCK-001 | MDL | Satchel | 2x2x1 |
| MDL-PCK-002 | MDL | Field Pack | 2x2x1 |
| MDL-PCK-003 | MDL | Tactical Bag | 2x2x1 |
| ANIM-ACT-010 | ANIM | Pick up from floor (empty hands) | — |
| ANIM-ACT-011 | ANIM | Pick up from floor (rifle held) | — |
| ANIM-ACT-012 | ANIM | Search container, low | — |
| ANIM-ACT-013 | ANIM | Search container, mid | — |
| ANIM-ACT-014 | ANIM | Search container, high | — |
| ANIM-ACT-015 | ANIM | Rummage loop (crouched, container panel open) | — |
| SFX-ENV-040 | SFX | Open bin lid | — |
| SFX-ENV-041 | SFX | Open locker | — |
| SFX-ENV-042 | SFX | Open crate | — |
| SFX-ENV-043 | SFX | Open till drawer | — |
| SFX-ENV-044 | SFX | Open cabinet | — |
| SFX-ENV-045 | SFX | Item pick up | — |
| SFX-ENV-046 | SFX | Item drop | — |
| SFX-LOOT-001 | SFX | Reveal Common | — |
| SFX-LOOT-002 | SFX | Reveal Uncommon | — |
| SFX-LOOT-003 | SFX | Reveal Rare | — |
| SFX-LOOT-004 | SFX | Reveal Epic | — |
| SFX-LOOT-005 | SFX | Reveal Exotic | — |
| SFX-LOOT-006 | SFX | Reveal Relic | — |
| SFX-LOOT-010 | SFX | Rising tone Common | — |
| SFX-LOOT-011 | SFX | Rising tone Uncommon | — |
| SFX-LOOT-012 | SFX | Rising tone Rare | — |
| SFX-LOOT-013 | SFX | Rising tone Epic | — |
| SFX-LOOT-014 | SFX | Rising tone Exotic | — |
| SFX-LOOT-015 | SFX | Rising tone Relic | — |
| SFX-LOOT-020 | SFX | Face-down slot shuffle | — |
| SFX-PLR-036 | SFX | Inventory rummage loop | — |
| SFX-PLR-037 | SFX | Equip backpack / armour | — |
| SFX-UI-010 | SFX | Item pick (drag) | — |
| SFX-UI-011 | SFX | Item place | — |
| SFX-UI-012 | SFX | Item rotate | — |
| SFX-UI-020 | SFX | Value tick | — |
| SFX-UI-021 | SFX | Haul total slam | — |
| MUS-UI-001 | MUS | Haul tally loop | — |
| UI-HUD-002 | UI | Quick bar | — |
| UI-HUD-023 | UI | Weight bar | — |
| UI-HUD-030 | UI | Context prompt (icon, word, hold ring) | — |
| UI-ICO-002 | UI | Generic line icon 1 (status, actions, tiers, tabs) | — |
| UI-ICO-003 | UI | Generic line icon 2 (status, actions, tiers, tabs) | — |
| UI-ICO-004 | UI | Generic line icon 3 (status, actions, tiers, tabs) | — |
| UI-ICO-005 | UI | Generic line icon 4 (status, actions, tiers, tabs) | — |
| UI-ICO-006 | UI | Generic line icon 5 (status, actions, tiers, tabs) | — |
| UI-ICO-007 | UI | Generic line icon 6 (status, actions, tiers, tabs) | — |
| UI-ICO-008 | UI | Generic line icon 7 (status, actions, tiers, tabs) | — |
| UI-ICO-009 | UI | Generic line icon 8 (status, actions, tiers, tabs) | — |
| UI-ICO-010 | UI | Generic line icon 9 (status, actions, tiers, tabs) | — |
| UI-ICO-011 | UI | Generic line icon 10 (status, actions, tiers, tabs) | — |
| UI-ICO-012 | UI | Generic line icon 11 (status, actions, tiers, tabs) | — |
| UI-ICO-013 | UI | Generic line icon 12 (status, actions, tiers, tabs) | — |
| UI-ICO-014 | UI | Generic line icon 13 (status, actions, tiers, tabs) | — |
| UI-ICO-015 | UI | Generic line icon 14 (status, actions, tiers, tabs) | — |
| UI-ICO-016 | UI | Generic line icon 15 (status, actions, tiers, tabs) | — |
| UI-ICO-017 | UI | Generic line icon 16 (status, actions, tiers, tabs) | — |
| UI-ICO-018 | UI | Generic line icon 17 (status, actions, tiers, tabs) | — |
| UI-ICO-019 | UI | Generic line icon 18 (status, actions, tiers, tabs) | — |
| UI-ICO-020 | UI | Generic line icon 19 (status, actions, tiers, tabs) | — |
| UI-ICO-021 | UI | Generic line icon 20 (status, actions, tiers, tabs) | — |
| UI-ICO-022 | UI | Generic line icon 21 (status, actions, tiers, tabs) | — |
| UI-ICO-023 | UI | Generic line icon 22 (status, actions, tiers, tabs) | — |
| UI-ICO-024 | UI | Generic line icon 23 (status, actions, tiers, tabs) | — |
| UI-ICO-025 | UI | Generic line icon 24 (status, actions, tiers, tabs) | — |
| UI-ICO-026 | UI | Generic line icon 25 (status, actions, tiers, tabs) | — |
| UI-ICO-027 | UI | Generic line icon 26 (status, actions, tiers, tabs) | — |
| UI-ICO-028 | UI | Generic line icon 27 (status, actions, tiers, tabs) | — |
| UI-ICO-029 | UI | Generic line icon 28 (status, actions, tiers, tabs) | — |
| UI-ICO-030 | UI | Generic line icon 29 (status, actions, tiers, tabs) | — |
| UI-ICO-031 | UI | Generic line icon 30 (status, actions, tiers, tabs) | — |
| UI-INV-001 | UI | Inventory screen | — |
| UI-INV-010 | UI | Container panel | — |
| UI-ITM-001 | UI | Item icon: P9 | — |
| UI-ITM-002 | UI | Item icon: Wasp | — |
| UI-ITM-003 | UI | Item icon: Brace | — |
| UI-ITM-004 | UI | Item icon: Kestrel | — |
| UI-ITM-005 | UI | Item icon: Longhorn | — |
| UI-ITM-006 | UI | Item icon: Nightjar | — |
| UI-ITM-007 | UI | Item icon: Revenant | — |
| UI-ITM-008 | UI | Item icon: Pipe | — |
| UI-ITM-009 | UI | Item icon: Crowbar | — |
| UI-ITM-010 | UI | Item icon: Fire Axe | — |
| UI-ITM-011 | UI | Item icon: Light ammo | — |
| UI-ITM-012 | UI | Item icon: Medium ammo | — |
| UI-ITM-013 | UI | Item icon: Heavy ammo | — |
| UI-ITM-014 | UI | Item icon: Shells | — |
| UI-ITM-015 | UI | Item icon: Red Dot | — |
| UI-ITM-016 | UI | Item icon: 4x Scope | — |
| UI-ITM-017 | UI | Item icon: Suppressor | — |
| UI-ITM-018 | UI | Item icon: Extended Mag | — |
| UI-ITM-019 | UI | Item icon: Foregrip | — |
| UI-ITM-020 | UI | Item icon: Thermal Sight | — |
| UI-ITM-021 | UI | Item icon: Light Vest | — |
| UI-ITM-022 | UI | Item icon: Heavy Vest | — |
| UI-ITM-023 | UI | Item icon: Helmet | — |
| UI-ITM-024 | UI | Item icon: Bastion Plate | — |
| UI-ITM-025 | UI | Item icon: Satchel | — |
| UI-ITM-026 | UI | Item icon: Field Pack | — |
| UI-ITM-027 | UI | Item icon: Tactical Bag | — |
| UI-ITM-028 | UI | Item icon: Flashlight | — |
| UI-ITM-029 | UI | Item icon: Battery | — |
| UI-ITM-030 | UI | Item icon: Infrared Thermometer | — |
| UI-ITM-031 | UI | Item icon: Blood Scanner | — |
| UI-ITM-032 | UI | Item icon: Door Wedge | — |
| UI-ITM-033 | UI | Item icon: Planks | — |
| UI-ITM-034 | UI | Item icon: Fuel Can | — |
| UI-ITM-035 | UI | Item icon: Boombox | — |
| UI-ITM-036 | UI | Item icon: Name Tag | — |
| UI-ITM-037 | UI | Item icon: Keycard Food Court | — |
| UI-ITM-038 | UI | Item icon: Keycard Electronics | — |
| UI-ITM-039 | UI | Item icon: Keycard Department Store | — |
| UI-ITM-040 | UI | Item icon: Keycard Pharmacy | — |
| UI-ITM-041 | UI | Item icon: Keycard Security | — |
| UI-ITM-042 | UI | Item icon: Safe code note | — |
| UI-ITM-043 | UI | Item icon: Bandage | — |
| UI-ITM-044 | UI | Item icon: Gauze | — |
| UI-ITM-045 | UI | Item icon: Painkillers | — |
| UI-ITM-046 | UI | Item icon: Medkit | — |
| UI-ITM-047 | UI | Item icon: Splint | — |
| UI-ITM-048 | UI | Item icon: Surgical Kit | — |
| UI-ITM-049 | UI | Item icon: Suppressant | — |
| UI-ITM-050 | UI | Item icon: Antidote | — |
| UI-ITM-051 | UI | Item icon: Adrenaline | — |
| UI-ITM-052 | UI | Item icon: Improvised Suppressant | — |
| UI-ITM-053 | UI | Item icon: Bottle | — |
| UI-ITM-054 | UI | Item icon: Brick | — |
| UI-ITM-055 | UI | Item icon: Noise Decoy | — |
| UI-ITM-056 | UI | Item icon: Molotov | — |
| UI-ITM-057 | UI | Item icon: UV Stun Flare | — |
| UI-ITM-058 | UI | Item icon: Smoke Can | — |
| UI-ITM-059 | UI | Item icon: Rag | — |
| UI-ITM-060 | UI | Item icon: Alcohol | — |
| UI-ITM-061 | UI | Item icon: Tape | — |
| UI-ITM-062 | UI | Item icon: Wire | — |
| UI-ITM-063 | UI | Item icon: Radio | — |
| UI-ITM-064 | UI | Item icon: Chemical Flask | — |
| UI-ITM-065 | UI | Item icon: Syringe | — |
| UI-ITM-066 | UI | Item icon: Scrap | — |
| UI-ITM-067 | UI | Item icon: Mechanical Parts | — |
| UI-ITM-068 | UI | Item icon: Electronic Parts | — |
| UI-ITM-069 | UI | Item icon: Precision Parts | — |
| UI-ITM-070 | UI | Item icon: Exotic Alloy | — |
| UI-ITM-071 | UI | Item icon: Cloth | — |
| UI-ITM-072 | UI | Item icon: Smartphone | — |
| UI-ITM-073 | UI | Item icon: Wristwatch | — |
| UI-ITM-074 | UI | Item icon: Perfume | — |
| UI-ITM-075 | UI | Item icon: Cash Bundle | — |
| UI-ITM-076 | UI | Item icon: Gold Chain | — |
| UI-ITM-077 | UI | Item icon: Jewellery Box | — |
| UI-ITM-078 | UI | Item icon: Handbag | — |
| UI-ITM-079 | UI | Item icon: Game Console | — |
| UI-ITM-080 | UI | Item icon: Vintage Camera | — |
| UI-ITM-081 | UI | Item icon: Golden Mall Statue | — |
| UI-ITM-082 | UI | Item icon: Classified Keycard | — |
| UI-ITM-083 | UI | Item icon: Supermutant Trophy | — |
| UI-ITM-084 | UI | Item icon: Blueprint (Guns) | — |
| UI-ITM-085 | UI | Item icon: Blueprint (Armour) | — |
| UI-ITM-086 | UI | Item icon: Blueprint (Attachments) | — |
| UI-ITM-087 | UI | Item icon: Dogtag | — |
| UI-ITM-088 | UI | Item icon: Blank Vinyl | — |
| UI-ITM-089 | UI | Item icon: Vinyl | — |
| UI-ITM-090 | UI | Item icon: Arcade cabinet (decor) | — |
| UI-ITM-091 | UI | Item icon: Mall bench (decor) | — |
| UI-ITM-092 | UI | Item icon: Trolley (decor) | — |
| UI-ITM-093 | UI | Item icon: Golden escalator sign (decor) | — |
| UI-RES-001 | UI | Haul tally screen | — |
| VFX-ITM-001 | VFX | World item glint (tier colour for Rare+) | — |
| VFX-UI-001 | VFX | Reveal shimmer (Epic+) | — |

## Step S5

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ENV-186 | MDL | Ladder | 2x14x0.5 |
| MDL-ENV-197 | MDL | Stacked shipping crates (climbable stack, 2 high, each 3.5 tall) | 6x7x6 |
| MDL-ENV-198 | MDL | Collapsed ceiling slab (crawl space, 2.3 clearance) | 12x4x10 |
| ANIM-ACT-060 | ANIM | Ladder climb loop (up/down by playback) | — |
| ANIM-ACT-061 | ANIM | Ladder mount bottom / dismount top | — |
| ANIM-ACT-062 | ANIM | Hang idle on rail (AM hold pose) | — |
| ANIM-MOV-023 | ANIM | Prone down (crouch to belly, 0.6 s) | — |
| ANIM-MOV-024 | ANIM | Prone up (belly to crouch, 0.7 s) | — |
| ANIM-MOV-025 | ANIM | Prone idle (weapon slung on back) | — |
| ANIM-MOV-026 | ANIM | Prone crawl loop (elbows and knees, in place) | — |
| SFX-PLR-024 | SFX | Mantle / vault grunt + hands on rail | — |
| SFX-PLR-034 | SFX | Ladder climb loop | — |
| SFX-PLR-035 | SFX | Window climb scrape | — |
| SFX-PLR-040 | SFX | Prone drop / rise (cloth and gear thud) | — |
| SFX-PLR-041 | SFX | Prone crawl drag loop (elbows, gear rattle) | — |
| SFX-PLR-042 | SFX | Ledge climb-up (hands slap, boots scrabble, strain grunt) | — |

## Step S6

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ARM-001 | MDL | Light Vest | 2x2x1 |
| MDL-ARM-002 | MDL | Heavy Vest | 2x2x1 |
| MDL-ARM-003 | MDL | Helmet | 2x2x1 |
| MDL-GUN-001 | MDL | P9 pistol | 4x1x0.5 |
| MDL-GUN-002 | MDL | Wasp SMG | 4x1x0.5 |
| MDL-GUN-003 | MDL | Brace pump shotgun | 4x1x0.5 |
| MDL-GUN-004 | MDL | Kestrel assault rifle | 4x1x0.5 |
| MDL-GUN-005 | MDL | Longhorn hunting rifle | 4x1x0.5 |
| MDL-THR-001 | MDL | Bottle | 1x1x1 |
| MDL-THR-002 | MDL | Brick | 1x1x1 |
| MDL-THR-003 | MDL | Noise Decoy (radio taped to wire) | 1x1x1 |
| MDL-THR-004 | MDL | Molotov | 1x1x1 |
| MDL-THR-005 | MDL | UV Stun Flare | 1x1x1 |
| MDL-THR-006 | MDL | Smoke Can | 1x1x1 |
| MDL-WPN-010 | MDL | Pipe | 3x0.5x0.5 |
| MDL-WPN-011 | MDL | Crowbar | 3x0.5x0.5 |
| MDL-WPN-012 | MDL | Fire axe | 3x0.5x0.5 |
| MDL-WPN-020 | MDL | Red Dot Sight | 1x0.5x0.5 |
| MDL-WPN-021 | MDL | 4x Scope | 1x0.5x0.5 |
| MDL-WPN-022 | MDL | Suppressor | 1x0.5x0.5 |
| MDL-WPN-023 | MDL | Extended Mag | 1x0.5x0.5 |
| MDL-WPN-024 | MDL | Foregrip | 1x0.5x0.5 |
| MDL-WPN-030 | MDL | Muzzle flash mesh (pistol/rifle) | 1x1x1 |
| MDL-WPN-031 | MDL | Shell casing | 1x1x1 |
| MDL-WPN-032 | MDL | Tracer streak | 1x1x1 |
| ANIM-HIT-001 | ANIM | Hit reaction head | — |
| ANIM-HIT-002 | ANIM | Hit reaction torso | — |
| ANIM-HIT-003 | ANIM | Hit reaction left side | — |
| ANIM-HIT-004 | ANIM | Hit reaction right side | — |
| ANIM-MEL-001 | ANIM | Blunt light 1 | — |
| ANIM-MEL-002 | ANIM | Blunt light 2 | — |
| ANIM-MEL-003 | ANIM | Blunt light 3 | — |
| ANIM-MEL-004 | ANIM | Blunt heavy (overhead) | — |
| ANIM-MEL-005 | ANIM | Axe light 1 | — |
| ANIM-MEL-006 | ANIM | Axe light 2 | — |
| ANIM-MEL-007 | ANIM | Axe light 3 | — |
| ANIM-MEL-008 | ANIM | Axe heavy (overhead) | — |
| ANIM-MEL-009 | ANIM | Fist jab | — |
| ANIM-MEL-010 | ANIM | Fist hook | — |
| ANIM-MEL-011 | ANIM | Shove (two-hand push) | — |
| ANIM-THR-001 | ANIM | Throw wind-up hold (overarm) | — |
| ANIM-THR-002 | ANIM | Throw release | — |
| ANIM-WPN-001 | ANIM | Draw pistol | — |
| ANIM-WPN-002 | ANIM | Holster pistol | — |
| ANIM-WPN-003 | ANIM | Draw long gun (from back) | — |
| ANIM-WPN-004 | ANIM | Holster long gun | — |
| ANIM-WPN-005 | ANIM | Draw melee (from hip) | — |
| ANIM-WPN-006 | ANIM | Holster melee | — |
| ANIM-WPN-010 | ANIM | Reload P9 | — |
| ANIM-WPN-011 | ANIM | Reload Wasp | — |
| ANIM-WPN-012 | ANIM | Reload Brace (shell insert loop) | — |
| ANIM-WPN-013 | ANIM | Reload Kestrel | — |
| ANIM-WPN-014 | ANIM | Reload Longhorn (per round) | — |
| ANIM-WPN-015 | ANIM | Reload Nightjar | — |
| ANIM-WPN-016 | ANIM | Reload Revenant (speedloader) | — |
| ANIM-WPN-020 | ANIM | Pistol hold idle | — |
| ANIM-WPN-021 | ANIM | Pistol aim | — |
| ANIM-WPN-022 | ANIM | Rifle hold idle | — |
| ANIM-WPN-023 | ANIM | Rifle aim | — |
| ANIM-WPN-024 | ANIM | Shotgun hold idle | — |
| ANIM-WPN-025 | ANIM | Shotgun aim | — |
| ANIM-WPN-030 | ANIM | Fire kick additive (pistol) | — |
| ANIM-WPN-031 | ANIM | Fire kick additive (rifle) | — |
| ANIM-WPN-032 | ANIM | Fire kick additive (shotgun) | — |
| ANIM-WPN-033 | ANIM | Brace pump action | — |
| ANIM-WPN-034 | ANIM | Longhorn bolt cycle | — |
| ANIM-WPN-035 | ANIM | Attach / detach attachment (inspect pose) | — |
| SFX-ENV-048 | SFX | Fire crackle | — |
| SFX-MEL-001 | SFX | Swing light pipe | — |
| SFX-MEL-002 | SFX | Swing light crowbar | — |
| SFX-MEL-003 | SFX | Swing light axe | — |
| SFX-MEL-004 | SFX | Swing heavy pipe | — |
| SFX-MEL-005 | SFX | Swing heavy crowbar | — |
| SFX-MEL-006 | SFX | Swing heavy axe | — |
| SFX-MEL-007 | SFX | Hit flesh pipe | — |
| SFX-MEL-008 | SFX | Hit flesh crowbar | — |
| SFX-MEL-009 | SFX | Hit flesh axe | — |
| SFX-MEL-010 | SFX | Hit wall / prop | — |
| SFX-MEL-011 | SFX | Fist punch | — |
| SFX-MEL-012 | SFX | Shove | — |
| SFX-THR-001 | SFX | Throw whoosh | — |
| SFX-THR-002 | SFX | Bottle smash | — |
| SFX-THR-003 | SFX | Brick thud | — |
| SFX-THR-004 | SFX | Noise Decoy loop | — |
| SFX-THR-005 | SFX | Molotov smash | — |
| SFX-THR-006 | SFX | Fire loop | — |
| SFX-THR-007 | SFX | UV flare ignite | — |
| SFX-THR-008 | SFX | UV flare fizz loop | — |
| SFX-THR-009 | SFX | Smoke Can hiss loop | — |
| SFX-WPN-001 | SFX | P9 close | — |
| SFX-WPN-002 | SFX | P9 distant | — |
| SFX-WPN-003 | SFX | Wasp close | — |
| SFX-WPN-004 | SFX | Wasp distant | — |
| SFX-WPN-005 | SFX | Brace close | — |
| SFX-WPN-006 | SFX | Brace distant | — |
| SFX-WPN-007 | SFX | Brace pump | — |
| SFX-WPN-008 | SFX | Kestrel close | — |
| SFX-WPN-009 | SFX | Kestrel distant | — |
| SFX-WPN-010 | SFX | Longhorn close | — |
| SFX-WPN-011 | SFX | Longhorn distant | — |
| SFX-WPN-012 | SFX | Longhorn bolt | — |
| SFX-WPN-013 | SFX | Nightjar close | — |
| SFX-WPN-014 | SFX | Nightjar distant | — |
| SFX-WPN-015 | SFX | Revenant close | — |
| SFX-WPN-016 | SFX | Revenant distant | — |
| SFX-WPN-017 | SFX | Suppressed shot | — |
| SFX-WPN-018 | SFX | Gunshot tail galleria | — |
| SFX-WPN-019 | SFX | Gunshot tail corridor | — |
| SFX-WPN-020 | SFX | Gunshot tail outdoor | — |
| SFX-WPN-021 | SFX | Reload pistol | — |
| SFX-WPN-022 | SFX | Reload SMG | — |
| SFX-WPN-023 | SFX | Reload shotgun shell | — |
| SFX-WPN-024 | SFX | Reload AR | — |
| SFX-WPN-025 | SFX | Reload rifle | — |
| SFX-WPN-026 | SFX | Reload revolver | — |
| SFX-WPN-027 | SFX | Weapon swap / draw | — |
| SFX-WPN-028 | SFX | Holster | — |
| SFX-WPN-029 | SFX | Aim in | — |
| SFX-WPN-030 | SFX | Dry fire click | — |
| SFX-WPN-031 | SFX | Shell casings | — |
| SFX-WPN-032 | SFX | Attach / detach | — |
| SFX-WPN-040 | SFX | Flesh impact thud | — |
| SFX-WPN-041 | SFX | Headshot crack | — |
| SFX-WPN-042 | SFX | Armour impact ping | — |
| SFX-WPN-043 | SFX | Impact concrete | — |
| SFX-WPN-044 | SFX | Impact metal | — |
| SFX-WPN-045 | SFX | Impact glass | — |
| SFX-WPN-046 | SFX | Impact wood | — |
| SFX-WPN-047 | SFX | Impact tile | — |
| SFX-WPN-048 | SFX | Bullet whiz-by | — |
| UI-HUD-001 | UI | Weapon panel | — |
| VFX-ENV-021 | VFX | Fire (barrels, molotov pool) | — |
| VFX-HIT-001 | VFX | Blood hit spurt | — |
| VFX-WPN-001 | VFX | Muzzle flash | — |
| VFX-WPN-002 | VFX | Bullet impact concrete | — |
| VFX-WPN-003 | VFX | Bullet impact metal | — |
| VFX-WPN-004 | VFX | Bullet impact wood | — |
| VFX-WPN-005 | VFX | Bullet impact glass | — |
| VFX-WPN-006 | VFX | Smoke Can cloud | — |
| VFX-WPN-007 | VFX | UV flare light and sparks | — |

## Step S7

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| ANIM-MED-001 | ANIM | Bandage / gauze wrap | — |
| ANIM-MED-002 | ANIM | Take pills | — |
| ANIM-MED-003 | ANIM | Medkit use (kneel) | — |
| ANIM-MED-004 | ANIM | Apply splint | — |
| ANIM-MED-005 | ANIM | Surgical kit (kneel, long) | — |
| ANIM-MED-006 | ANIM | Self-inject syringe | — |
| ANIM-MED-007 | ANIM | Revive (both sides, kneel and compress) | — |
| ANIM-MOV-016 | ANIM | Injured limp (leg fracture) | — |
| ANIM-MOV-017 | ANIM | Downed crawl (one arm dragging) | — |
| SFX-MED-001 | SFX | Bandage wrap | — |
| SFX-MED-002 | SFX | Pill bottle | — |
| SFX-MED-003 | SFX | Medkit open | — |
| SFX-MED-004 | SFX | Splint strap | — |
| SFX-MED-005 | SFX | Surgical kit | — |
| SFX-MED-006 | SFX | Syringe inject | — |
| SFX-MED-007 | SFX | Revive effort | — |
| SFX-PLR-027 | SFX | Bone crack | — |
| SFX-PLR-028 | SFX | Pain grunt 1 | — |
| SFX-PLR-029 | SFX | Pain grunt 2 | — |
| SFX-PLR-030 | SFX | Pain grunt 3 | — |
| SFX-PLR-031 | SFX | Body fall thump | — |
| SFX-PLR-032 | SFX | Downed crawl drag loop | — |
| SFX-PLR-033 | SFX | Death exhale | — |
| SFX-PLR-038 | SFX | Low-health ringing | — |
| MUS-RAID-031 | MUS | Death sting | — |
| MUS-UI-002 | MUS | Death screen loop | — |
| UI-HUD-020 | UI | Vitals (health bar + body silhouette) | — |
| UI-HUD-021 | UI | Status icons set | — |
| UI-HUD-024 | UI | Downed bar | — |
| UI-HUD-025 | UI | Damage direction arc | — |
| UI-RES-010 | UI | Death screen | — |
| UI-VFX-001 | UI | Low-health / fear vignette image | — |
| VFX-PLR-003 | VFX | Blood trail decal | — |

## Step S8

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ZOM-001 | MDL | Walker body variant 1 | 2x5x1 |
| MDL-ZOM-002 | MDL | Walker body variant 2 | 2x5x1 |
| MDL-ZOM-003 | MDL | Walker body variant 3 | 2x5x1 |
| MDL-ZOM-004 | MDL | Crawler body (legless / broken) | 2x5x1 |
| ANIM-MEL-020 | ANIM | Stealth takedown, attacker (paired) | — |
| ANIM-MEL-021 | ANIM | Stealth takedown, Walker victim (paired) | — |
| ANIM-ZOM-001 | ANIM | Walker idle groan sway | — |
| ANIM-ZOM-002 | ANIM | Walker notice (stop, face, head tilt) | — |
| ANIM-ZOM-003 | ANIM | Walker chase run | — |
| ANIM-ZOM-004 | ANIM | Lunge wind-up (arms rise) | — |
| ANIM-ZOM-005 | ANIM | Lunge leap | — |
| ANIM-ZOM-007 | ANIM | Shoved off stagger | — |
| ANIM-ZOM-009 | ANIM | Hit reaction / stagger | — |
| ANIM-ZOM-010 | ANIM | Death start (into ragdoll) | — |
| ANIM-ZOM-020 | ANIM | Crawler crawl loop | — |
| ANIM-ZOM-021 | ANIM | Crawler ankle grab | — |
| SFX-MEL-013 | SFX | Stealth takedown crunch | — |
| SFX-ZOM-001 | SFX | Walker groan 1 | — |
| SFX-ZOM-002 | SFX | Walker groan 2 | — |
| SFX-ZOM-003 | SFX | Walker groan 3 | — |
| SFX-ZOM-004 | SFX | Walker groan 4 | — |
| SFX-ZOM-005 | SFX | Walker groan 5 | — |
| SFX-ZOM-006 | SFX | Walker groan 6 | — |
| SFX-ZOM-010 | SFX | Alert screech | — |
| SFX-ZOM-011 | SFX | Chase breathing loop | — |
| SFX-ZOM-012 | SFX | Shuffle footsteps loop | — |
| SFX-ZOM-020 | SFX | Lunge wind-up | — |
| SFX-ZOM-021 | SFX | Lunge leap | — |
| SFX-ZOM-023 | SFX | Shoved off | — |
| SFX-ZOM-025 | SFX | Pound on shutter loop | — |
| SFX-ZOM-030 | SFX | Zombie hit reaction | — |
| SFX-ZOM-031 | SFX | Zombie death | — |
| SFX-ZOM-040 | SFX | Crawler crawl | — |
| SFX-ZOM-041 | SFX | Crawler ankle grab | — |
| MUS-RAID-002 | MUS | Tension 1 pulse | — |
| MUS-RAID-003 | MUS | Tension 2 percussion | — |
| TEX-ZOM-001 | TEX | Zombie outfit tint texture 1 | — |
| TEX-ZOM-002 | TEX | Zombie outfit tint texture 2 | — |
| TEX-ZOM-003 | TEX | Zombie outfit tint texture 3 | — |
| TEX-ZOM-004 | TEX | Zombie outfit tint texture 4 | — |
| TEX-ZOM-005 | TEX | Zombie outfit tint texture 5 | — |
| TEX-ZOM-006 | TEX | Zombie outfit tint texture 6 | — |
| TEX-ZOM-007 | TEX | Zombie outfit tint texture 7 | — |
| TEX-ZOM-008 | TEX | Zombie outfit tint texture 8 | — |
| TEX-ZOM-009 | TEX | Zombie outfit tint texture 9 | — |
| TEX-ZOM-010 | TEX | Zombie outfit tint texture 10 | — |
| TEX-ZOM-011 | TEX | Zombie outfit tint texture 11 | — |
| TEX-ZOM-012 | TEX | Zombie outfit tint texture 12 | — |

## Step S9

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ENV-030 | MDL | Generator (diesel, panel with amber lamp) | 6x5x4 |
| MDL-ENV-040 | MDL | Floor glass shards decal + trigger | 6x0.2x6 |
| MDL-ENV-060 | MDL | Store alarm box (door frame, red light) | 1x1x0.5 |
| MDL-ENV-061 | MDL | Hanging sign trap | 4x2x0.2 |
| MDL-ENV-062 | MDL | Bottle string trap | 6x1x0.2 |
| MDL-ENV-184 | MDL | Service elevator car and doors | 8x10x8 |
| MDL-ENV-189 | MDL | Barricade planks (nailed) | 4x8x0.5 |
| MDL-ENV-190 | MDL | Door wedge (placed) | 1x0.3x1 |
| MDL-ENV-193 | MDL | Keypad (Med Safe / stockroom) | 1x1.5x0.3 |
| MDL-ENV-194 | MDL | Shutter control box | 1x1.5x0.4 |
| MDL-ENV-195 | MDL | Security Office shutter control panel | 4x3x1 |
| MDL-ITM-080 | MDL | Keycard Food Court | 1x1x0.1 |
| MDL-ITM-081 | MDL | Keycard Electronics | 1x1x0.1 |
| MDL-ITM-082 | MDL | Keycard Department Store | 1x1x0.1 |
| MDL-ITM-083 | MDL | Keycard Pharmacy | 1x1x0.1 |
| MDL-ITM-084 | MDL | Keycard Security | 1x1x0.1 |
| MDL-ITM-090 | MDL | Safe code sticky note (shows code) | 1x1x0.1 |
| ANIM-ACT-030 | ANIM | Fuel and start generator (pour, yank cord) loop | — |
| ANIM-ACT-070 | ANIM | Operate shutter control (hold) | — |
| ANIM-ACT-071 | ANIM | Open / close door (push) | — |
| ANIM-ACT-072 | ANIM | Nail barricade loop | — |
| ANIM-ACT-073 | ANIM | Kick wedge under door | — |
| ANIM-ACT-074 | ANIM | Crowbar pry loop | — |
| ANIM-ACT-075 | ANIM | Swipe keycard | — |
| ANIM-ACT-076 | ANIM | Enter keypad code | — |
| ANIM-ACT-077 | ANIM | Disarm alarm loop | — |
| ANIM-ACT-078 | ANIM | Door slam while running (upper body) | — |
| SFX-ENV-001 | SFX | Glass break small | — |
| SFX-ENV-002 | SFX | Glass break medium | — |
| SFX-ENV-003 | SFX | Glass break large | — |
| SFX-ENV-004 | SFX | Shards settling | — |
| SFX-ENV-010 | SFX | Shutter rattle | — |
| SFX-ENV-011 | SFX | Shutter slam | — |
| SFX-ENV-012 | SFX | Shutter bash loop | — |
| SFX-ENV-013 | SFX | Door open | — |
| SFX-ENV-014 | SFX | Door close | — |
| SFX-ENV-015 | SFX | Door slam | — |
| SFX-ENV-016 | SFX | Security door open | — |
| SFX-ENV-017 | SFX | Barricade nailing loop | — |
| SFX-ENV-018 | SFX | Wedge kick-in | — |
| SFX-ENV-019 | SFX | Crowbar pry loop | — |
| SFX-ENV-020 | SFX | Store alarm loop | — |
| SFX-ENV-021 | SFX | Trap sign clatter | — |
| SFX-ENV-022 | SFX | Trap bottle jangle | — |
| SFX-ENV-023 | SFX | Alarm disarm beep | — |
| SFX-ENV-024 | SFX | Keycard accept | — |
| SFX-ENV-025 | SFX | Keycard reject | — |
| SFX-ENV-026 | SFX | Keypad beep | — |
| SFX-ENV-027 | SFX | Keypad open | — |
| SFX-ENV-028 | SFX | Keypad wrong | — |
| SFX-ENV-029 | SFX | Med Safe unlock | — |
| SFX-ENV-030 | SFX | Crowbar pop | — |
| SFX-ENV-031 | SFX | Generator start | — |
| SFX-ENV-032 | SFX | Generator hum loop | — |
| SFX-ENV-033 | SFX | Power-on clunk and buzz | — |
| SFX-ENV-034 | SFX | Light shot out | — |
| SFX-ENV-035 | SFX | Escalator loop | — |
| SFX-ENV-036 | SFX | Elevator ding | — |
| SFX-ENV-037 | SFX | Elevator motor loop | — |
| SFX-ENV-038 | SFX | Elevator doors | — |
| SFX-ENV-039 | SFX | Fuel pour | — |
| SFX-MEL-014 | SFX | Barricade plank break | — |
| MUS-RAID-070 | MUS | Powered-wing ceiling muzak (tinny) | — |
| VFX-ENV-001 | VFX | Glass shatter shards burst | — |
| VFX-ENV-022 | VFX | Sparks (shot light, generator start) | — |

## Step S10

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ITM-070 | MDL | Infrared Thermometer | 1x1x0.5 |
| MDL-ITM-071 | MDL | Blood Scanner (light shows result) | 1x2x0.5 |
| MDL-MUT-001 | MDL | Stalker Mutant overlay (built on the survivor: veins, claws, jaw) | 2x5x1 |
| MDL-ZOM-005 | MDL | Sprinter overlay (built on dead Sleeper's survivor) | 2x5x1 |
| ANIM-INF-001 | ANIM | Sleeper twitch (small, upper body) | — |
| ANIM-INF-010 | ANIM | Scan someone (point device, hold) | — |
| ANIM-MUT-001 | ANIM | Stalker idle (crouched) | — |
| ANIM-MUT-002 | ANIM | Stalker run | — |
| ANIM-MUT-003 | ANIM | Stalker sprint (quadruped) | — |
| ANIM-MUT-004 | ANIM | Stalker claw | — |
| ANIM-MUT-005 | ANIM | Stalker pounce | — |
| ANIM-MUT-006 | ANIM | Stalker climb loop | — |
| ANIM-MUT-007 | ANIM | Stalker hit reaction | — |
| ANIM-MUT-008 | ANIM | Stalker roar | — |
| ANIM-STR-001 | ANIM | Struggle pinned standing (victim, paired with ANIM-ZOM-006) | — |
| ANIM-STR-002 | ANIM | Struggle on floor (victim, Crawler/Downed) | — |
| ANIM-STR-003 | ANIM | Bitten (victim, paired with ANIM-ZOM-008) | — |
| ANIM-STR-004 | ANIM | Struggle success shove-off | — |
| ANIM-ZOM-006 | ANIM | Grapple loop (paired with ANIM-STR-001) | — |
| ANIM-ZOM-008 | ANIM | Bite (paired with ANIM-STR-003) | — |
| ANIM-ZOM-030 | ANIM | Sprinter run (fast, erratic) | — |
| ANIM-ZOM-031 | ANIM | Sprinter swipe | — |
| SFX-INF-001 | SFX | Sleeper cough 1 | — |
| SFX-INF-002 | SFX | Sleeper cough 2 | — |
| SFX-INF-003 | SFX | Sleeper cough 3 | — |
| SFX-INF-004 | SFX | Sleeper cough 4 | — |
| SFX-INF-010 | SFX | Sleeper faint heartbeat | — |
| SFX-INF-011 | SFX | Bitten sting | — |
| SFX-INF-012 | SFX | Turning rising tone | — |
| SFX-INF-013 | SFX | Cure exhale | — |
| SFX-INF-014 | SFX | Scanner beep | — |
| SFX-INF-015 | SFX | Scanner infected | — |
| SFX-INF-016 | SFX | Thermometer beep | — |
| SFX-MUT-001 | SFX | Sleeper corpse mutating | — |
| SFX-MUT-002 | SFX | Stalker mutation scream | — |
| SFX-MUT-010 | SFX | Stalker roar 1 | — |
| SFX-MUT-011 | SFX | Stalker roar 2 | — |
| SFX-MUT-012 | SFX | Stalker roar 3 | — |
| SFX-MUT-013 | SFX | Stalker roar 4 | — |
| SFX-MUT-014 | SFX | Stalker claw | — |
| SFX-MUT-015 | SFX | Stalker pounce | — |
| SFX-MUT-016 | SFX | Stalker climb skitter | — |
| SFX-ZOM-022 | SFX | Grapple loop (snarl, struggle) | — |
| SFX-ZOM-024 | SFX | Bite | — |
| SFX-ZOM-050 | SFX | Sprinter run | — |
| SFX-ZOM-051 | SFX | Sprinter swipe | — |
| SFX-ZOM-052 | SFX | Sprinter shriek | — |
| MUS-RAID-005 | MUS | Sleeper motif (own client) | — |
| MUS-RAID-050 | MUS | Mutant hunt theme | — |
| MUS-RAID-051 | MUS | Ghost bed | — |
| UI-GHO-001 | UI | Ghost tools bar | — |
| UI-INF-001 | UI | Sleeper veins screen overlay (3 stages) | — |
| UI-INF-010 | UI | Scanner result readout | — |
| UI-MUT-002 | UI | Stalker kit HUD | — |
| UI-STR-001 | UI | Struggle bar | — |
| VFX-MUT-001 | VFX | Mutant noise ping ring | — |
| VFX-MUT-002 | VFX | Flashlight beacon glow (mutant view) | — |
| VFX-MUT-003 | VFX | Ghost thermal silhouettes | — |
| VFX-MUT-004 | VFX | Mutant night-vision tint | — |
| VFX-MUT-010 | VFX | Sleeper corpse mutation (Sprinter) | — |
| TEX-INF-001 | TEX | Sleeper visible veins (under flashlight, symptom) | — |
| TEX-ITM-030 | TEX | Tainted item dark veins overlay (under flashlight) | — |

## Step S11

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-JAN-001 | MDL | The Janitor (huge, hazmat-patched overalls, gas mask) with mop cart | 4x8x3 |
| ANIM-JAN-001 | ANIM | Janitor walk pushing mop cart | — |
| ANIM-JAN-002 | ANIM | Janitor hunt walk (cart abandoned) | — |
| ANIM-JAN-003 | ANIM | Janitor stop and listen | — |
| ANIM-JAN-004 | ANIM | Janitor grab wind-up (silent) | — |
| ANIM-JAN-005 | ANIM | Janitor UV stun (cover face) | — |
| ANIM-JAN-006 | ANIM | Janitor grab and slam (paired) | — |
| ANIM-JAN-007 | ANIM | Janitor bash shutter / barricade loop | — |
| ANIM-JAN-008 | ANIM | Janitor idle mopping | — |
| SFX-JAN-001 | SFX | PA crackle (Janitor enters) | — |
| SFX-JAN-010 | SFX | Mop cart squeal loop | — |
| SFX-JAN-011 | SFX | Heavy breathing loop | — |
| SFX-JAN-012 | SFX | Wet inhale (grab tell) | — |
| SFX-JAN-013 | SFX | Grab and slam | — |
| SFX-JAN-014 | SFX | Stunned howl | — |
| SFX-JAN-015 | SFX | Heavy boots loop | — |
| MUS-RAID-004 | MUS | Janitor motif | — |

## Step S12

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ENV-071 | MDL | Evac route wall sign (lights up with arrow) | 4x2x0.3 |
| MDL-RAID-010 | MDL | Evac helicopter | 40x14x12 |
| MDL-RAID-011 | MDL | Garage freight lift platform and doors | 16x12x12 |
| ANIM-ACT-031 | ANIM | Type at security terminal loop | — |
| SFX-RAID-004 | SFX | Terminals online chime | — |
| SFX-RAID-005 | SFX | Terminal activation beeps | — |
| SFX-RAID-006 | SFX | Terminal activated klaxon | — |
| SFX-RAID-010 | SFX | Red Alert siren loop | — |
| SFX-RAID-011 | SFX | Evac open horn | — |
| SFX-RAID-020 | SFX | Helicopter rotor | — |
| SFX-RAID-021 | SFX | Garage freight lift | — |
| SFX-RAID-033 | SFX | Early depart confirm | — |
| SFX-RAID-040 | SFX | Sealed boom | — |
| SFX-ZOM-060 | SFX | Horde surge roar (Red Alert) | — |
| MUS-RAID-010 | MUS | Red Alert theme | — |
| MUS-RAID-030 | MUS | Extraction sting | — |
| VO-PA-002 | VO | PA: terminals online | — |
| VO-PA-003 | VO | PA: automatic evac in 60 s | — |
| VO-PA-004 | VO | PA: automatic evac triggered | — |
| VO-PA-010 | VO | PA: evac to Rooftop Helipad | — |
| VO-PA-011 | VO | PA: evac to Basement Garage | — |
| VO-PA-012 | VO | PA: evac window open | — |
| VO-PA-013 | VO | PA: departing in 10 s | — |
| UI-HUD-040 | UI | Evac marker | — |
| UI-HUD-041 | UI | Evac countdown | — |
| UI-HUD-042 | UI | Terminal progress ring | — |
| UI-HUD-090 | UI | Subtitles | — |
| VFX-ENV-010 | VFX | Red Alert strobe and emergency-light pulse | — |
| VFX-ENV-011 | VFX | Evac zone floor glow (amber → green) | — |
| VFX-ENV-012 | VFX | Helicopter rotor wash dust | — |

## Step S13

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ENV-050 | MDL | Destructible wall chunk set (pre-fractured plasterboard) | 20x14x1 |
| MDL-ITM-051 | MDL | Supermutant Trophy (head) | 2x2x2 |
| MDL-MUT-010 | MDL | Supermutant Brute | 6x11x4 |
| ANIM-MUT-010 | ANIM | Supermutant idle | — |
| ANIM-MUT-011 | ANIM | Supermutant run | — |
| ANIM-MUT-012 | ANIM | Supermutant slam | — |
| ANIM-MUT-013 | ANIM | Supermutant charge start | — |
| ANIM-MUT-014 | ANIM | Supermutant charge loop | — |
| ANIM-MUT-015 | ANIM | Supermutant screech | — |
| ANIM-MUT-016 | ANIM | Supermutant wall run | — |
| ANIM-MUT-017 | ANIM | Supermutant ceiling drop | — |
| ANIM-MUT-018 | ANIM | Supermutant transformation (2.5 s) | — |
| ANIM-MUT-019 | ANIM | Supermutant revive kneel (frozen 10 s pose) | — |
| ANIM-MUT-020 | ANIM | Supermutant death | — |
| SFX-ENV-005 | SFX | Destructible wall break (plaster crash) | — |
| SFX-MUT-003 | SFX | Supermutant transformation roar | — |
| SFX-MUT-004 | SFX | Supermutant death | — |
| SFX-MUT-005 | SFX | Second Wind revive roar | — |
| SFX-MUT-020 | SFX | Supermutant slam 1 | — |
| SFX-MUT-021 | SFX | Supermutant slam 2 | — |
| SFX-MUT-022 | SFX | Charge start | — |
| SFX-MUT-023 | SFX | Charge loop | — |
| SFX-MUT-024 | SFX | Charge impact | — |
| SFX-MUT-025 | SFX | Screech | — |
| SFX-MUT-026 | SFX | Footsteps 1 | — |
| SFX-MUT-027 | SFX | Footsteps 2 | — |
| SFX-MUT-028 | SFX | Wall-run skitter | — |
| SFX-MUT-029 | SFX | Ceiling drop | — |
| SFX-MUT-030 | SFX | Hit reaction 1 | — |
| SFX-MUT-031 | SFX | Hit reaction 2 | — |
| SFX-MUT-032 | SFX | Breathing loop | — |
| SFX-RAID-030 | SFX | Departure abort buzz | — |
| SFX-RAID-031 | SFX | Lockdown slam | — |
| SFX-RAID-032 | SFX | Reopen unlock | — |
| MUS-RAID-020 | MUS | Lockdown theme | — |
| MUS-RAID-021 | MUS | Reopen sting + loop | — |
| VO-PA-020 | VO | PA: contamination detected | — |
| VO-PA-021 | VO | PA: evacuation resumed | — |
| UI-MUT-001 | UI | Supermutant kit HUD | — |
| UI-MUT-010 | UI | Second Wind prompt | — |
| VFX-ENV-005 | VFX | Plaster dust burst (destructible wall) | — |
| VFX-MUT-011 | VFX | Supermutant transformation burst | — |
| VFX-MUT-012 | VFX | Second Wind explosive roar shockwave | — |
| VFX-MUT-013 | VFX | Screech outline (Supermutant view) | — |

## Step S14

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-CHR-001 | MDL | Survivor face 1 | 1x1x1 |
| MDL-CHR-002 | MDL | Survivor face 2 | 1x1x1 |
| MDL-CHR-003 | MDL | Survivor face 3 | 1x1x1 |
| MDL-CHR-004 | MDL | Survivor face 4 | 1x1x1 |
| MDL-CHR-005 | MDL | Survivor face 5 | 1x1x1 |
| MDL-CHR-006 | MDL | Survivor face 6 | 1x1x1 |
| MDL-CHR-007 | MDL | Survivor face 7 | 1x1x1 |
| MDL-CHR-008 | MDL | Survivor face 8 | 1x1x1 |
| MDL-CHR-009 | MDL | Survivor face 9 | 1x1x1 |
| MDL-CHR-010 | MDL | Survivor face 10 | 1x1x1 |
| MDL-CHR-011 | MDL | Survivor face 11 | 1x1x1 |
| MDL-CHR-012 | MDL | Survivor face 12 | 1x1x1 |
| MDL-CHR-013 | MDL | Survivor hair style 1 | 1x1x1 |
| MDL-CHR-014 | MDL | Survivor hair style 2 | 1x1x1 |
| MDL-CHR-015 | MDL | Survivor hair style 3 | 1x1x1 |
| MDL-CHR-016 | MDL | Survivor hair style 4 | 1x1x1 |
| MDL-CHR-017 | MDL | Survivor hair style 5 | 1x1x1 |
| MDL-CHR-018 | MDL | Survivor hair style 6 | 1x1x1 |
| MDL-CHR-019 | MDL | Survivor hair style 7 | 1x1x1 |
| MDL-CHR-020 | MDL | Survivor hair style 8 | 1x1x1 |
| MDL-CHR-021 | MDL | Survivor hair style 9 | 1x1x1 |
| MDL-CHR-022 | MDL | Survivor hair style 10 | 1x1x1 |
| MDL-CHR-023 | MDL | Survivor hair style 11 | 1x1x1 |
| MDL-CHR-024 | MDL | Survivor hair style 12 | 1x1x1 |
| MDL-CHR-025 | MDL | Survivor hair style 13 | 1x1x1 |
| MDL-CHR-026 | MDL | Survivor hair style 14 | 1x1x1 |
| MDL-CHR-027 | MDL | Survivor hair style 15 | 1x1x1 |
| MDL-CHR-028 | MDL | Survivor hair style 16 | 1x1x1 |
| MDL-CHR-029 | MDL | Survivor skin tone 1 (texture set) | 1x1x1 |
| MDL-CHR-030 | MDL | Survivor skin tone 2 (texture set) | 1x1x1 |
| MDL-CHR-031 | MDL | Survivor skin tone 3 (texture set) | 1x1x1 |
| MDL-CHR-032 | MDL | Survivor skin tone 4 (texture set) | 1x1x1 |
| MDL-CHR-033 | MDL | Survivor skin tone 5 (texture set) | 1x1x1 |
| MDL-CHR-034 | MDL | Survivor skin tone 6 (texture set) | 1x1x1 |
| MDL-CHR-035 | MDL | Survivor skin tone 7 (texture set) | 1x1x1 |
| MDL-CHR-036 | MDL | Survivor skin tone 8 (texture set) | 1x1x1 |
| ANIM-ACT-040 | ANIM | Kneel and assemble (inventory crafting) loop | — |
| SFX-CRF-001 | SFX | Tape rip | — |
| SFX-CRF-002 | SFX | Metal clank | — |
| SFX-CRF-003 | SFX | Liquid pour | — |
| SFX-CRF-004 | SFX | Wire twist | — |
| SFX-CRF-005 | SFX | Wood saw | — |
| SFX-UI-030 | SFX | Blueprint learned | — |
| SFX-UI-040 | SFX | Level up | — |
| SFX-UI-080 | SFX | Draft card flip | — |
| MUS-RAID-060 | MUS | Orientation bed | — |
| MUS-UI-003 | MUS | Survivor Draft loop | — |
| VO-TUT-001 | VO | Orientation: move | — |
| VO-TUT-002 | VO | Orientation: search | — |
| VO-TUT-003 | VO | Orientation: crouch | — |
| VO-TUT-004 | VO | Orientation: throw | — |
| VO-TUT-005 | VO | Orientation: struggle | — |
| VO-TUT-006 | VO | Orientation: bitten | — |
| VO-TUT-007 | VO | Orientation: terminal | — |
| VO-TUT-008 | VO | Orientation: extract | — |
| UI-HUD-050 | UI | Toast (level up, contract, achievement) | — |
| UI-INV-020 | UI | Craft tab | — |
| UI-SUR-001 | UI | Survivor Draft (3 cards) | — |

## Step S15

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-CHR-090 | MDL | Test Raider bot body (orange) | 2x5x1 |
| MDL-PLR-011 | MDL | Armband (left arm, colour set client-side) | 0.6x0.4x0.6 |
| ANIM-EMO-001 | ANIM | Wave (upper body) | — |
| ANIM-EMO-002 | ANIM | Hands Up (holster, both hands raised) | — |
| ANIM-EMO-003 | ANIM | Point (upper body) | — |
| ANIM-EMO-004 | ANIM | Thumbs Up | — |
| SFX-COM-001 | SFX | Squad radio key up | — |
| SFX-COM-002 | SFX | Squad radio release | — |
| SFX-COM-005 | SFX | Ping | — |
| SFX-TWR-003 | SFX | Transit Gate doors closing (raid found) | — |
| SFX-UI-050 | SFX | Raid found | — |
| SFX-UI-051 | SFX | Ready check | — |
| MUS-TWR-002 | MUS | Transit Gates tension bed | — |
| VO-QL-001 | VO | Quick line 'Friendly!' voice A take 1 | — |
| VO-QL-002 | VO | Quick line 'Friendly!' voice A take 2 | — |
| VO-QL-003 | VO | Quick line 'Friendly!' voice A take 3 | — |
| VO-QL-004 | VO | Quick line 'Friendly!' voice B take 1 | — |
| VO-QL-005 | VO | Quick line 'Friendly!' voice B take 2 | — |
| VO-QL-006 | VO | Quick line 'Friendly!' voice B take 3 | — |
| VO-QL-007 | VO | Quick line 'Don't shoot!' voice A take 1 | — |
| VO-QL-008 | VO | Quick line 'Don't shoot!' voice A take 2 | — |
| VO-QL-009 | VO | Quick line 'Don't shoot!' voice A take 3 | — |
| VO-QL-010 | VO | Quick line 'Don't shoot!' voice B take 1 | — |
| VO-QL-011 | VO | Quick line 'Don't shoot!' voice B take 2 | — |
| VO-QL-012 | VO | Quick line 'Don't shoot!' voice B take 3 | — |
| VO-QL-013 | VO | Quick line 'Follow me' voice A take 1 | — |
| VO-QL-014 | VO | Quick line 'Follow me' voice A take 2 | — |
| VO-QL-015 | VO | Quick line 'Follow me' voice A take 3 | — |
| VO-QL-016 | VO | Quick line 'Follow me' voice B take 1 | — |
| VO-QL-017 | VO | Quick line 'Follow me' voice B take 2 | — |
| VO-QL-018 | VO | Quick line 'Follow me' voice B take 3 | — |
| VO-QL-019 | VO | Quick line 'Help!' voice A take 1 | — |
| VO-QL-020 | VO | Quick line 'Help!' voice A take 2 | — |
| VO-QL-021 | VO | Quick line 'Help!' voice A take 3 | — |
| VO-QL-022 | VO | Quick line 'Help!' voice B take 1 | — |
| VO-QL-023 | VO | Quick line 'Help!' voice B take 2 | — |
| VO-QL-024 | VO | Quick line 'Help!' voice B take 3 | — |
| VO-QL-025 | VO | Quick line 'Danger!' voice A take 1 | — |
| VO-QL-026 | VO | Quick line 'Danger!' voice A take 2 | — |
| VO-QL-027 | VO | Quick line 'Danger!' voice A take 3 | — |
| VO-QL-028 | VO | Quick line 'Danger!' voice B take 1 | — |
| VO-QL-029 | VO | Quick line 'Danger!' voice B take 2 | — |
| VO-QL-030 | VO | Quick line 'Danger!' voice B take 3 | — |
| VO-QL-031 | VO | Quick line 'Thanks' voice A take 1 | — |
| VO-QL-032 | VO | Quick line 'Thanks' voice A take 2 | — |
| VO-QL-033 | VO | Quick line 'Thanks' voice A take 3 | — |
| VO-QL-034 | VO | Quick line 'Thanks' voice B take 1 | — |
| VO-QL-035 | VO | Quick line 'Thanks' voice B take 2 | — |
| VO-QL-036 | VO | Quick line 'Thanks' voice B take 3 | — |
| VO-QL-037 | VO | Quick line 'Over here' voice A take 1 | — |
| VO-QL-038 | VO | Quick line 'Over here' voice A take 2 | — |
| VO-QL-039 | VO | Quick line 'Over here' voice A take 3 | — |
| VO-QL-040 | VO | Quick line 'Over here' voice B take 1 | — |
| VO-QL-041 | VO | Quick line 'Over here' voice B take 2 | — |
| VO-QL-042 | VO | Quick line 'Over here' voice B take 3 | — |
| VO-QL-043 | VO | Quick line 'Wait' voice A take 1 | — |
| VO-QL-044 | VO | Quick line 'Wait' voice A take 2 | — |
| VO-QL-045 | VO | Quick line 'Wait' voice A take 3 | — |
| VO-QL-046 | VO | Quick line 'Wait' voice B take 1 | — |
| VO-QL-047 | VO | Quick line 'Wait' voice B take 2 | — |
| VO-QL-048 | VO | Quick line 'Wait' voice B take 3 | — |
| UI-COM-001 | UI | Quick-line wheel | — |
| UI-COM-002 | UI | Speech bubble | — |
| UI-COM-010 | UI | Emote wheel | — |
| UI-DEP-001 | UI | Deploy panel | — |
| UI-DEP-002 | UI | Raid found | — |
| UI-DEP-003 | UI | Searching | — |
| UI-HUD-010 | UI | Squad list | — |
| UI-HUD-080 | UI | Ping: location | — |
| UI-HUD-081 | UI | Ping: item | — |
| UI-HUD-082 | UI | Ping: enemy | — |
| UI-HUD-083 | UI | Ping: player | — |
| UI-HUD-084 | UI | Squad tag | — |
| UI-HUD-085 | UI | Downed tag + edge arrow | — |
| UI-TWR-020 | UI | Party panel | — |

## Step S16

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-FLT-001 | MDL | Bunk Studio interior template | 40x14x30 |
| MDL-FLT-010 | MDL | Workbench (flat) | 4x4x3 |
| MDL-FLT-012 | MDL | Survivor terminal | 4x4x3 |
| MDL-FLT-013 | MDL | Flat terminal (laptop on desk) | 4x4x3 |
| MDL-FLT-014 | MDL | Memorial wall | 4x4x3 |
| MDL-FLT-015 | MDL | Trophy shelf | 4x4x3 |
| MDL-FLT-016 | MDL | Bed (bunk) | 4x4x3 |
| MDL-FLT-017 | MDL | Overflow crate | 4x4x3 |
| MDL-NPC-002 | MDL | Quartermaster Okafor | 2x5x1 |
| MDL-NPC-003 | MDL | Pawnbroker Lenny | 2x5x1 |
| MDL-TWR-010 | MDL | Tower ground floor shell (atrium, fountain, columns) | 120x40x120 |
| MDL-TWR-011 | MDL | Quartermaster counter with cage | 10x6x4 |
| MDL-TWR-012 | MDL | Pawnbroker counter | 8x6x4 |
| MDL-TWR-020 | MDL | Flat door with number plate and banner slot | 4x8x0.5 |
| SFX-FLT-001 | SFX | Flat door | — |
| SFX-FLT-006 | SFX | Stash chest open | — |
| SFX-FLT-007 | SFX | Workbench loop | — |
| SFX-FLT-008 | SFX | Craft done ding | — |
| SFX-UI-060 | SFX | Purchase complete | — |
| MUS-TWR-001 | MUS | Tower ground floor bed | — |
| VO-NPC-011 | VO | NPC Okafor line 1 | — |
| VO-NPC-012 | VO | NPC Okafor line 2 | — |
| VO-NPC-013 | VO | NPC Okafor line 3 | — |
| VO-NPC-014 | VO | NPC Okafor line 4 | — |
| VO-NPC-015 | VO | NPC Okafor line 5 | — |
| VO-NPC-016 | VO | NPC Okafor line 6 | — |
| VO-NPC-017 | VO | NPC Okafor line 7 | — |
| VO-NPC-018 | VO | NPC Okafor line 8 | — |
| VO-NPC-019 | VO | NPC Okafor line 9 | — |
| VO-NPC-020 | VO | NPC Okafor line 10 | — |
| VO-NPC-021 | VO | NPC Lenny line 1 | — |
| VO-NPC-022 | VO | NPC Lenny line 2 | — |
| VO-NPC-023 | VO | NPC Lenny line 3 | — |
| VO-NPC-024 | VO | NPC Lenny line 4 | — |
| VO-NPC-025 | VO | NPC Lenny line 5 | — |
| VO-NPC-026 | VO | NPC Lenny line 6 | — |
| VO-NPC-027 | VO | NPC Lenny line 7 | — |
| VO-NPC-028 | VO | NPC Lenny line 8 | — |
| VO-NPC-029 | VO | NPC Lenny line 9 | — |
| VO-NPC-030 | VO | NPC Lenny line 10 | — |
| UI-FLT-001 | UI | Stash panel | — |
| UI-FLT-010 | UI | Workbench panel | — |
| UI-FLT-020 | UI | Flat terminal | — |
| UI-HUD-100 | UI | Tower: MC and level badge | — |
| UI-HUD-101 | UI | Tower: Shop button | — |
| UI-HUD-102 | UI | Tower: Pass button | — |
| UI-HUD-103 | UI | Tower: Invite button | — |
| UI-HUD-104 | UI | Tower: Party button | — |
| UI-HUD-105 | UI | Tower: Settings button | — |
| UI-HUD-110 | UI | First-time hint panel | — |
| UI-ICO-001 | UI | Mall Cash icon | — |
| UI-SET-001 | UI | Settings: General | — |
| UI-SET-010 | UI | Settings: Controls (rebinding) | — |
| UI-SET-020 | UI | Settings: Layout (mobile buttons) | — |
| UI-VEN-001 | UI | Vendor buy/sell | — |

## Step F1

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-NPC-001 | MDL | Concierge Marla | 2x5x1 |
| MDL-NPC-020 | MDL | Tower guard (armoured) | 2x5x1 |
| MDL-NPC-030 | MDL | Ambient resident 1 | 2x5x1 |
| MDL-NPC-031 | MDL | Ambient resident 2 | 2x5x1 |
| MDL-NPC-032 | MDL | Ambient resident 3 | 2x5x1 |
| MDL-NPC-033 | MDL | Ambient resident 4 | 2x5x1 |
| MDL-NPC-034 | MDL | Ambient resident 5 | 2x5x1 |
| MDL-NPC-035 | MDL | Ambient resident 6 | 2x5x1 |
| MDL-NPC-036 | MDL | Ambient resident 7 | 2x5x1 |
| MDL-NPC-037 | MDL | Ambient resident 8 | 2x5x1 |
| MDL-NPC-038 | MDL | Ambient resident 9 | 2x5x1 |
| MDL-NPC-039 | MDL | Ambient resident 10 | 2x5x1 |
| MDL-NPC-040 | MDL | Ambient resident 11 | 2x5x1 |
| MDL-NPC-041 | MDL | Ambient resident 12 | 2x5x1 |
| MDL-TWR-013 | MDL | Security checkpoint (turrets, arch) | 20x10x6 |
| MDL-TWR-014 | MDL | Concierge desk | 10x4x4 |
| MDL-TWR-018 | MDL | Residential corridor kit: Low Block (graffiti, laundry, buzzing lights) | 60x12x8 |
| MDL-TWR-019 | MDL | Residential corridor kit: Mid Block | 60x12x8 |
| MDL-TWR-021 | MDL | Residential corridor kit: Penthouse level | 60x12x8 |
| MDL-TWR-022 | MDL | Lift lobby (every level) and lift doors | 20x12x12 |
| MDL-TWR-024 | MDL | Stairwell decor (with mugging scene space) | 12x24x12 |
| MDL-TWR-030 | MDL | Tower Standing board | 8x6x1 |
| MDL-TWR-090 | MDL | Skyline backdrop (mall in the distance, fires, searchlights) | 1000x200x10 |
| ANIM-NPC-001 | ANIM | Tower ambient NPC loop 1 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-002 | ANIM | Tower ambient NPC loop 2 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-003 | ANIM | Tower ambient NPC loop 3 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-004 | ANIM | Tower ambient NPC loop 4 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-005 | ANIM | Tower ambient NPC loop 5 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-006 | ANIM | Tower ambient NPC loop 6 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-007 | ANIM | Tower ambient NPC loop 7 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-008 | ANIM | Tower ambient NPC loop 8 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-009 | ANIM | Tower ambient NPC loop 9 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-010 | ANIM | Tower ambient NPC loop 10 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-011 | ANIM | Tower ambient NPC loop 11 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-012 | ANIM | Tower ambient NPC loop 12 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-013 | ANIM | Tower ambient NPC loop 13 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-014 | ANIM | Tower ambient NPC loop 14 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-015 | ANIM | Tower ambient NPC loop 15 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-016 | ANIM | Tower ambient NPC loop 16 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-017 | ANIM | Tower ambient NPC loop 17 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-018 | ANIM | Tower ambient NPC loop 18 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-019 | ANIM | Tower ambient NPC loop 19 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| ANIM-NPC-020 | ANIM | Tower ambient NPC loop 20 (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors) | — |
| SFX-TWR-002 | SFX | Internal lift ride | — |
| SFX-TWR-020 | SFX | Tower ambience 1 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-021 | SFX | Tower ambience 2 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-022 | SFX | Tower ambience 3 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-023 | SFX | Tower ambience 4 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-024 | SFX | Tower ambience 5 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-025 | SFX | Tower ambience 6 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-026 | SFX | Tower ambience 7 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-027 | SFX | Tower ambience 8 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-028 | SFX | Tower ambience 9 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-029 | SFX | Tower ambience 10 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-030 | SFX | Tower ambience 11 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-031 | SFX | Tower ambience 12 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-032 | SFX | Tower ambience 13 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-033 | SFX | Tower ambience 14 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-034 | SFX | Tower ambience 15 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-035 | SFX | Tower ambience 16 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-036 | SFX | Tower ambience 17 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-037 | SFX | Tower ambience 18 (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel) | — |
| SFX-TWR-040 | SFX | Power flicker | — |
| SFX-TWR-041 | SFX | Turret servo | — |
| MUS-TWR-003 | MUS | Roof Black Market bed | — |
| VO-NPC-001 | VO | NPC Marla line 1 | — |
| VO-NPC-002 | VO | NPC Marla line 2 | — |
| VO-NPC-003 | VO | NPC Marla line 3 | — |
| VO-NPC-004 | VO | NPC Marla line 4 | — |
| VO-NPC-005 | VO | NPC Marla line 5 | — |
| VO-NPC-006 | VO | NPC Marla line 6 | — |
| VO-NPC-007 | VO | NPC Marla line 7 | — |
| VO-NPC-008 | VO | NPC Marla line 8 | — |
| VO-NPC-009 | VO | NPC Marla line 9 | — |
| VO-NPC-010 | VO | NPC Marla line 10 | — |
| VO-PA-030 | VO | Tower Management announcement 1 | — |
| VO-PA-031 | VO | Tower Management announcement 2 | — |
| VO-PA-032 | VO | Tower Management announcement 3 | — |
| VO-PA-033 | VO | Tower Management announcement 4 | — |
| VO-PA-034 | VO | Tower Management announcement 5 | — |
| VO-PA-035 | VO | Tower Management announcement 6 | — |
| VO-PA-036 | VO | Tower Management announcement 7 | — |
| VO-PA-037 | VO | Tower Management announcement 8 | — |
| VO-PA-038 | VO | Tower Management announcement 9 | — |
| VO-PA-039 | VO | Tower Management announcement 10 | — |
| VO-PA-040 | VO | Tower Management announcement 11 | — |
| VO-PA-041 | VO | Tower Management announcement 12 | — |
| VO-PA-042 | VO | Tower Management announcement 13 | — |
| VO-PA-043 | VO | Tower Management announcement 14 | — |
| VO-PA-044 | VO | Tower Management announcement 15 | — |
| VO-PA-045 | VO | Tower Management announcement 16 | — |
| UI-TWR-001 | UI | Lift floor picker | — |
| UI-TWR-010 | UI | Concierge panel (vacancies, Move-in, waitlist, upgrades, visits) | — |
| UI-TWR-030 | UI | Nameplate (display name, title badge, frame) | — |

## Step F2

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-FLT-002 | MDL | Executive Suite interior template | 40x14x26 |
| MDL-FLT-003 | MDL | Skyline Penthouse interior template (with terrace) | 70x14x40 |
| MDL-FLT-020 | MDL | Weapon wall mount | 3x4x1 |
| MDL-FLT-021 | MDL | Trophy pedestal with spotlight | 3x4x1 |
| MDL-FLT-022 | MDL | Glass display case (6 slots) | 3x4x1 |
| MDL-FLT-023 | MDL | Mutant trophy wall mount | 3x4x1 |
| MDL-FUR-001 | MDL | Army cot | 4x4x4 |
| MDL-FUR-002 | MDL | Old sofa | 4x4x4 |
| MDL-FUR-003 | MDL | Leather sofa | 4x4x4 |
| MDL-FUR-004 | MDL | Armchair | 4x4x4 |
| MDL-FUR-005 | MDL | Coffee table | 4x4x4 |
| MDL-FUR-006 | MDL | Dining table + 4 chairs | 4x4x4 |
| MDL-FUR-007 | MDL | Crate table | 4x4x4 |
| MDL-FUR-008 | MDL | Bookshelf | 4x4x4 |
| MDL-FUR-009 | MDL | Floor lamp | 4x4x4 |
| MDL-FUR-010 | MDL | Workbench lamp | 4x4x4 |
| MDL-FUR-011 | MDL | String lights | 4x4x4 |
| MDL-FUR-012 | MDL | Neon sign OPEN | 4x4x4 |
| MDL-FUR-013 | MDL | Neon sign skull | 4x4x4 |
| MDL-FUR-014 | MDL | Neon arcade cabinet | 4x4x4 |
| MDL-FUR-015 | MDL | CRT TV | 4x4x4 |
| MDL-FUR-016 | MDL | Flat-screen TV | 4x4x4 |
| MDL-FUR-017 | MDL | Potted plants (3 kinds) | 4x4x4 |
| MDL-FUR-018 | MDL | Dead plant | 4x4x4 |
| MDL-FUR-019 | MDL | Rug (5 patterns) | 4x4x4 |
| MDL-FUR-020 | MDL | Posters (10 designs) | 4x4x4 |
| MDL-FUR-021 | MDL | Graffiti decals (8) | 4x4x4 |
| MDL-FUR-022 | MDL | Gun safe (decor) | 4x4x4 |
| MDL-FUR-023 | MDL | Punching bag | 4x4x4 |
| MDL-FUR-024 | MDL | Fish tank | 4x4x4 |
| MDL-FUR-025 | MDL | Mannequin | 4x4x4 |
| MDL-FUR-026 | MDL | Mall bench | 4x4x4 |
| MDL-FUR-027 | MDL | Shopping trolley | 4x4x4 |
| MDL-FUR-028 | MDL | Golden escalator sign | 4x4x4 |
| MDL-FUR-029 | MDL | Coffee Bar | 4x4x4 |
| MDL-FUR-030 | MDL | Upgraded Armory Bench | 4x4x4 |
| MDL-FUR-031 | MDL | Vintage Jukebox | 4x4x4 |
| MDL-FUR-032 | MDL | Security Terminal Desk | 4x4x4 |
| MDL-FUR-033 | MDL | Radio Set | 4x4x4 |
| MDL-FUR-034 | MDL | Penthouse bar | 4x4x4 |
| MDL-FUR-035 | MDL | Grand piano | 4x4x4 |
| MDL-FUR-036 | MDL | Hot tub | 4x4x4 |
| MDL-NPC-007 | MDL | Second-Hand Sal | 2x5x1 |
| MDL-TWR-017 | MDL | Sal's furniture stall | 10x8x6 |
| ANIM-TWR-020 | ANIM | Sit (chairs, sofas, bar stools) | — |
| ANIM-TWR-021 | ANIM | Rest on bed (lie down) | — |
| SFX-FLT-002 | SFX | Knock | — |
| SFX-FLT-003 | SFX | Build place | — |
| SFX-FLT-004 | SFX | Build pick | — |
| SFX-FLT-005 | SFX | Build invalid | — |
| MUS-FLT-001 | MUS | Flat ambient track 1 | — |
| MUS-FLT-002 | MUS | Flat ambient track 2 | — |
| MUS-FLT-003 | MUS | Flat ambient track 3 | — |
| MUS-FLT-004 | MUS | Flat ambient track 4 | — |
| MUS-FLT-005 | MUS | Flat ambient track 5 | — |
| MUS-FLT-010 | MUS | Tower radio channel 1 | — |
| MUS-FLT-011 | MUS | Tower radio channel 2 | — |
| MUS-FLT-012 | MUS | Tower radio channel 3 | — |
| VO-NPC-073 | VO | NPC Sal line 1 | — |
| VO-NPC-074 | VO | NPC Sal line 2 | — |
| VO-NPC-075 | VO | NPC Sal line 3 | — |
| VO-NPC-076 | VO | NPC Sal line 4 | — |
| VO-NPC-077 | VO | NPC Sal line 5 | — |
| VO-NPC-078 | VO | NPC Sal line 6 | — |
| UI-FLT-030 | UI | Build catalogue | — |
| UI-FUR-001 | UI | Furniture / wallpaper / flooring catalogue icon 1 | — |
| UI-FUR-002 | UI | Furniture / wallpaper / flooring catalogue icon 2 | — |
| UI-FUR-003 | UI | Furniture / wallpaper / flooring catalogue icon 3 | — |
| UI-FUR-004 | UI | Furniture / wallpaper / flooring catalogue icon 4 | — |
| UI-FUR-005 | UI | Furniture / wallpaper / flooring catalogue icon 5 | — |
| UI-FUR-006 | UI | Furniture / wallpaper / flooring catalogue icon 6 | — |
| UI-FUR-007 | UI | Furniture / wallpaper / flooring catalogue icon 7 | — |
| UI-FUR-008 | UI | Furniture / wallpaper / flooring catalogue icon 8 | — |
| UI-FUR-009 | UI | Furniture / wallpaper / flooring catalogue icon 9 | — |
| UI-FUR-010 | UI | Furniture / wallpaper / flooring catalogue icon 10 | — |
| UI-FUR-011 | UI | Furniture / wallpaper / flooring catalogue icon 11 | — |
| UI-FUR-012 | UI | Furniture / wallpaper / flooring catalogue icon 12 | — |
| UI-FUR-013 | UI | Furniture / wallpaper / flooring catalogue icon 13 | — |
| UI-FUR-014 | UI | Furniture / wallpaper / flooring catalogue icon 14 | — |
| UI-FUR-015 | UI | Furniture / wallpaper / flooring catalogue icon 15 | — |
| UI-FUR-016 | UI | Furniture / wallpaper / flooring catalogue icon 16 | — |
| UI-FUR-017 | UI | Furniture / wallpaper / flooring catalogue icon 17 | — |
| UI-FUR-018 | UI | Furniture / wallpaper / flooring catalogue icon 18 | — |
| UI-FUR-019 | UI | Furniture / wallpaper / flooring catalogue icon 19 | — |
| UI-FUR-020 | UI | Furniture / wallpaper / flooring catalogue icon 20 | — |
| UI-FUR-021 | UI | Furniture / wallpaper / flooring catalogue icon 21 | — |
| UI-FUR-022 | UI | Furniture / wallpaper / flooring catalogue icon 22 | — |
| UI-FUR-023 | UI | Furniture / wallpaper / flooring catalogue icon 23 | — |
| UI-FUR-024 | UI | Furniture / wallpaper / flooring catalogue icon 24 | — |
| UI-FUR-025 | UI | Furniture / wallpaper / flooring catalogue icon 25 | — |
| UI-FUR-026 | UI | Furniture / wallpaper / flooring catalogue icon 26 | — |
| UI-FUR-027 | UI | Furniture / wallpaper / flooring catalogue icon 27 | — |
| UI-FUR-028 | UI | Furniture / wallpaper / flooring catalogue icon 28 | — |
| UI-FUR-029 | UI | Furniture / wallpaper / flooring catalogue icon 29 | — |
| UI-FUR-030 | UI | Furniture / wallpaper / flooring catalogue icon 30 | — |
| UI-FUR-031 | UI | Furniture / wallpaper / flooring catalogue icon 31 | — |
| UI-FUR-032 | UI | Furniture / wallpaper / flooring catalogue icon 32 | — |
| UI-FUR-033 | UI | Furniture / wallpaper / flooring catalogue icon 33 | — |
| UI-FUR-034 | UI | Furniture / wallpaper / flooring catalogue icon 34 | — |
| UI-FUR-035 | UI | Furniture / wallpaper / flooring catalogue icon 35 | — |
| UI-FUR-036 | UI | Furniture / wallpaper / flooring catalogue icon 36 | — |
| UI-FUR-037 | UI | Furniture / wallpaper / flooring catalogue icon 37 | — |
| UI-FUR-038 | UI | Furniture / wallpaper / flooring catalogue icon 38 | — |
| UI-FUR-039 | UI | Furniture / wallpaper / flooring catalogue icon 39 | — |
| UI-FUR-040 | UI | Furniture / wallpaper / flooring catalogue icon 40 | — |
| UI-FUR-041 | UI | Furniture / wallpaper / flooring catalogue icon 41 | — |
| UI-FUR-042 | UI | Furniture / wallpaper / flooring catalogue icon 42 | — |
| UI-FUR-043 | UI | Furniture / wallpaper / flooring catalogue icon 43 | — |
| UI-FUR-044 | UI | Furniture / wallpaper / flooring catalogue icon 44 | — |
| UI-FUR-045 | UI | Furniture / wallpaper / flooring catalogue icon 45 | — |
| UI-FUR-046 | UI | Furniture / wallpaper / flooring catalogue icon 46 | — |
| UI-FUR-047 | UI | Furniture / wallpaper / flooring catalogue icon 47 | — |
| UI-FUR-048 | UI | Furniture / wallpaper / flooring catalogue icon 48 | — |
| UI-FUR-049 | UI | Furniture / wallpaper / flooring catalogue icon 49 | — |
| UI-FUR-050 | UI | Furniture / wallpaper / flooring catalogue icon 50 | — |
| UI-FUR-051 | UI | Furniture / wallpaper / flooring catalogue icon 51 | — |
| UI-FUR-052 | UI | Furniture / wallpaper / flooring catalogue icon 52 | — |
| UI-FUR-053 | UI | Furniture / wallpaper / flooring catalogue icon 53 | — |
| UI-FUR-054 | UI | Furniture / wallpaper / flooring catalogue icon 54 | — |
| UI-FUR-055 | UI | Furniture / wallpaper / flooring catalogue icon 55 | — |
| UI-FUR-056 | UI | Furniture / wallpaper / flooring catalogue icon 56 | — |
| TEX-FLR-001 | TEX | Flooring 1 | — |
| TEX-FLR-002 | TEX | Flooring 2 | — |
| TEX-FLR-003 | TEX | Flooring 3 | — |
| TEX-FLR-004 | TEX | Flooring 4 | — |
| TEX-FLR-005 | TEX | Flooring 5 | — |
| TEX-FLR-006 | TEX | Flooring 6 | — |
| TEX-FLR-007 | TEX | Flooring 7 | — |
| TEX-FLR-008 | TEX | Flooring 8 | — |
| TEX-WAL-001 | TEX | Wallpaper 1 | — |
| TEX-WAL-002 | TEX | Wallpaper 2 | — |
| TEX-WAL-003 | TEX | Wallpaper 3 | — |
| TEX-WAL-004 | TEX | Wallpaper 4 | — |
| TEX-WAL-005 | TEX | Wallpaper 5 | — |
| TEX-WAL-006 | TEX | Wallpaper 6 | — |
| TEX-WAL-007 | TEX | Wallpaper 7 | — |
| TEX-WAL-008 | TEX | Wallpaper 8 | — |
| TEX-WAL-009 | TEX | Wallpaper 9 | — |
| TEX-WAL-010 | TEX | Wallpaper 10 | — |
| TEX-WAL-011 | TEX | Wallpaper 11 | — |
| TEX-WAL-012 | TEX | Wallpaper 12 | — |

## Step F3

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| SFX-FLT-009 | SFX | Moving boxes | — |
| VFX-TWR-001 | VFX | Moving boxes scene (Move-in) | — |

## Step F4

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-NPC-006 | MDL | Mail Clerk Pip | 2x5x1 |
| MDL-TWR-015 | MDL | Mail Room counter and pigeonholes | 10x8x4 |
| MDL-TWR-050 | MDL | Flea listing terminal | 2x5x2 |
| MDL-TWR-051 | MDL | Appraisal terminal | 2x5x2 |
| MDL-TWR-052 | MDL | Flea decor stall | 8x8x6 |
| SFX-UI-070 | SFX | Mail arrived | — |
| VO-NPC-047 | VO | NPC Pip line 1 | — |
| VO-NPC-048 | VO | NPC Pip line 2 | — |
| VO-NPC-049 | VO | NPC Pip line 3 | — |
| VO-NPC-050 | VO | NPC Pip line 4 | — |
| UI-FLEA-001 | UI | Flea browse | — |
| UI-FLEA-002 | UI | Flea barter | — |
| UI-FLEA-003 | UI | Appraisal | — |
| UI-MAIL-001 | UI | Mail | — |

## Step F5

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| UI-DEP-010 | UI | Insurance panel | — |
| UI-MAIL-010 | UI | Repossession | — |

## Step F6

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ITM-091 | MDL | Dogtag | 1x1x0.1 |
| MDL-NPC-005 | MDL | Contract Officer Reyes | 2x5x1 |
| MDL-TWR-060 | MDL | Most Wanted LED wall (3 storeys) | 40x36x2 |
| MDL-TWR-061 | MDL | Contract terminal | 2x5x2 |
| ANIM-ACT-050 | ANIM | Crouch and snap dogtag from corpse | — |
| SFX-BNT-001 | SFX | Wall hum loop | — |
| SFX-BNT-002 | SFX | New #1 sting | — |
| SFX-BNT-010 | SFX | Dogtag snap | — |
| SFX-BNT-011 | SFX | Claim register | — |
| SFX-BNT-020 | SFX | Hunter proximity ticking | — |
| SFX-BNT-030 | SFX | Vigilante sting | — |
| SFX-COM-010 | SFX | VIP radio crackle | — |
| SFX-RAD-001 | SFX | Radio static intro | — |
| VO-NPC-037 | VO | NPC Reyes line 1 | — |
| VO-NPC-038 | VO | NPC Reyes line 2 | — |
| VO-NPC-039 | VO | NPC Reyes line 3 | — |
| VO-NPC-040 | VO | NPC Reyes line 4 | — |
| VO-NPC-041 | VO | NPC Reyes line 5 | — |
| VO-NPC-042 | VO | NPC Reyes line 6 | — |
| VO-NPC-043 | VO | NPC Reyes line 7 | — |
| VO-NPC-044 | VO | NPC Reyes line 8 | — |
| VO-NPC-045 | VO | NPC Reyes line 9 | — |
| VO-NPC-046 | VO | NPC Reyes line 10 | — |
| VO-RAD-010 | VO | Bounty sighting Food Court | — |
| VO-RAD-011 | VO | Bounty sighting Pharmacy | — |
| VO-RAD-012 | VO | Bounty sighting Department Store | — |
| VO-RAD-013 | VO | Bounty sighting Electronics | — |
| VO-RAD-014 | VO | Bounty sighting Cinema | — |
| VO-RAD-015 | VO | Bounty sighting Security Office | — |
| VO-RAD-016 | VO | Bounty sighting Maintenance / Garage | — |
| VO-RAD-020 | VO | Radio sign-off | — |
| UI-BNT-001 | UI | Most Wanted wall SurfaceGui | — |
| UI-BNT-002 | UI | Target viewport card | — |
| UI-BNT-010 | UI | Claim panel | — |
| UI-BNT-020 | UI | Dossier | — |
| UI-BNT-030 | UI | Escort contracts | — |
| UI-BNT-040 | UI | Hire Board | — |
| UI-HUD-060 | UI | Wanted tag (own screen) | — |
| UI-HUD-061 | UI | Bodyguard VIP radio (client health + marker) | — |

## Step F7

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ITM-065 | MDL | Boombox (world and held) | 2x1x1 |
| MDL-ITM-066 | MDL | Name Tag (engraving plate) | 1x1x0.1 |
| MDL-ITM-092 | MDL | Blank Vinyl | 2x2x0.1 |
| MDL-ITM-093 | MDL | Vinyl record with sleeve (sleeve art from UI-VIN) | 2x2x0.1 |
| MDL-NPC-004 | MDL | Bartender June | 2x5x1 |
| MDL-TWR-016 | MDL | The Drain bar interior | 30x14x20 |
| MDL-TWR-070 | MDL | Record press (Pressing Booth) | 6x6x4 |
| MDL-TWR-071 | MDL | Public jukebox (The Drain) | 3x6x2 |
| ANIM-ACT-055 | ANIM | Place boombox on ground | — |
| ANIM-FLT-010 | ANIM | Engrave at workbench | — |
| ANIM-TWR-010 | ANIM | Record press operation (June) | — |
| SFX-REL-001 | SFX | Relic found ping | — |
| SFX-REL-010 | SFX | Engraving | — |
| SFX-REL-020 | SFX | Record press | — |
| SFX-REL-021 | SFX | Needle drop | — |
| SFX-REL-022 | SFX | Boombox click | — |
| MUS-TWR-005 | MUS | The Drain ambient track | — |
| MUS-UI-010 | MUS | Relic theme | — |
| MUS-VIN-001 | MUS | Vinyl track 1 (Mall Muzak) | — |
| MUS-VIN-002 | MUS | Vinyl track 2 (Mall Muzak) | — |
| MUS-VIN-003 | MUS | Vinyl track 3 (Mall Muzak) | — |
| MUS-VIN-004 | MUS | Vinyl track 4 (Mall Muzak) | — |
| MUS-VIN-005 | MUS | Vinyl track 5 (Mall Muzak) | — |
| MUS-VIN-006 | MUS | Vinyl track 6 (Mall Muzak) | — |
| MUS-VIN-007 | MUS | Vinyl track 7 (Mall Muzak) | — |
| MUS-VIN-008 | MUS | Vinyl track 8 (Mall Muzak) | — |
| MUS-VIN-009 | MUS | Vinyl track 9 (Synth Night) | — |
| MUS-VIN-010 | MUS | Vinyl track 10 (Synth Night) | — |
| MUS-VIN-011 | MUS | Vinyl track 11 (Synth Night) | — |
| MUS-VIN-012 | MUS | Vinyl track 12 (Synth Night) | — |
| MUS-VIN-013 | MUS | Vinyl track 13 (Synth Night) | — |
| MUS-VIN-014 | MUS | Vinyl track 14 (Synth Night) | — |
| MUS-VIN-015 | MUS | Vinyl track 15 (Synth Night) | — |
| MUS-VIN-016 | MUS | Vinyl track 16 (Synth Night) | — |
| MUS-VIN-017 | MUS | Vinyl track 17 (Grunge Garage) | — |
| MUS-VIN-018 | MUS | Vinyl track 18 (Grunge Garage) | — |
| MUS-VIN-019 | MUS | Vinyl track 19 (Grunge Garage) | — |
| MUS-VIN-020 | MUS | Vinyl track 20 (Grunge Garage) | — |
| MUS-VIN-021 | MUS | Vinyl track 21 (Grunge Garage) | — |
| MUS-VIN-022 | MUS | Vinyl track 22 (Grunge Garage) | — |
| MUS-VIN-023 | MUS | Vinyl track 23 (Grunge Garage) | — |
| MUS-VIN-024 | MUS | Vinyl track 24 (Grunge Garage) | — |
| MUS-VIN-025 | MUS | Vinyl track 25 (Lo-fi Rooftop) | — |
| MUS-VIN-026 | MUS | Vinyl track 26 (Lo-fi Rooftop) | — |
| MUS-VIN-027 | MUS | Vinyl track 27 (Lo-fi Rooftop) | — |
| MUS-VIN-028 | MUS | Vinyl track 28 (Lo-fi Rooftop) | — |
| MUS-VIN-029 | MUS | Vinyl track 29 (Lo-fi Rooftop) | — |
| MUS-VIN-030 | MUS | Vinyl track 30 (Lo-fi Rooftop) | — |
| MUS-VIN-031 | MUS | Vinyl track 31 (Lo-fi Rooftop) | — |
| MUS-VIN-032 | MUS | Vinyl track 32 (Lo-fi Rooftop) | — |
| MUS-VIN-033 | MUS | Vinyl track 33 (Doom Choir) | — |
| MUS-VIN-034 | MUS | Vinyl track 34 (Doom Choir) | — |
| MUS-VIN-035 | MUS | Vinyl track 35 (Doom Choir) | — |
| MUS-VIN-036 | MUS | Vinyl track 36 (Doom Choir) | — |
| MUS-VIN-037 | MUS | Vinyl track 37 (Doom Choir) | — |
| MUS-VIN-038 | MUS | Vinyl track 38 (Doom Choir) | — |
| MUS-VIN-039 | MUS | Vinyl track 39 (Doom Choir) | — |
| MUS-VIN-040 | MUS | Vinyl track 40 (Doom Choir) | — |
| VO-NPC-031 | VO | NPC June line 1 | — |
| VO-NPC-032 | VO | NPC June line 2 | — |
| VO-NPC-033 | VO | NPC June line 3 | — |
| VO-NPC-034 | VO | NPC June line 4 | — |
| VO-NPC-035 | VO | NPC June line 5 | — |
| VO-NPC-036 | VO | NPC June line 6 | — |
| UI-REL-001 | UI | Engrave panel | — |
| UI-REL-010 | UI | Pressing Booth panel | — |
| UI-REL-020 | UI | Relic history card | — |
| UI-VIN-001 | UI | Vinyl sleeve design 1 | — |
| UI-VIN-002 | UI | Vinyl sleeve design 2 | — |
| UI-VIN-003 | UI | Vinyl sleeve design 3 | — |
| UI-VIN-004 | UI | Vinyl sleeve design 4 | — |
| UI-VIN-005 | UI | Vinyl sleeve design 5 | — |
| UI-VIN-006 | UI | Vinyl sleeve design 6 | — |
| UI-VIN-007 | UI | Vinyl sleeve design 7 | — |
| UI-VIN-008 | UI | Vinyl sleeve design 8 | — |
| UI-VIN-009 | UI | Vinyl sleeve design 9 | — |
| UI-VIN-010 | UI | Vinyl sleeve design 10 | — |
| UI-VIN-011 | UI | Vinyl sleeve design 11 | — |
| UI-VIN-012 | UI | Vinyl sleeve design 12 | — |

## Step F8

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-ARM-004 | MDL | Bastion Plate (Exotic) | 2x2x1 |
| MDL-GUN-006 | MDL | Nightjar (Exotic suppressed AR) | 4x1x0.5 |
| MDL-GUN-007 | MDL | Revenant (Exotic magnum revolver) | 4x1x0.5 |
| MDL-NPC-010 | MDL | Vex (Black Market broker) | 2x5x1 |
| MDL-TWR-023 | MDL | Roof Black Market (lounge, helipad decor, barrel) | 120x10x120 |
| MDL-TWR-040 | MDL | Blueprint wheel (big physical wheel) | 8x10x2 |
| MDL-WPN-025 | MDL | Thermal Sight | 1x0.5x0.5 |
| ANIM-TWR-001 | ANIM | Blueprint wheel spin (Vex pulls lever) | — |
| SFX-TWR-010 | SFX | Wheel ratchet | — |
| SFX-UI-061 | SFX | Wheel success | — |
| SFX-UI-062 | SFX | Wheel consolation | — |
| SFX-UI-063 | SFX | Wheel destroyed | — |
| MUS-UI-011 | MUS | Wheel spin loop | — |
| VO-NPC-051 | VO | NPC Vex line 1 | — |
| VO-NPC-052 | VO | NPC Vex line 2 | — |
| VO-NPC-053 | VO | NPC Vex line 3 | — |
| VO-NPC-054 | VO | NPC Vex line 4 | — |
| VO-NPC-055 | VO | NPC Vex line 5 | — |
| VO-NPC-056 | VO | NPC Vex line 6 | — |
| VO-NPC-057 | VO | NPC Vex line 7 | — |
| VO-NPC-058 | VO | NPC Vex line 8 | — |
| VO-NPC-059 | VO | NPC Vex line 9 | — |
| VO-NPC-060 | VO | NPC Vex line 10 | — |
| UI-SHOP-020 | UI | Odds table panel | — |
| UI-WHL-001 | UI | Blueprint Wheel and Fixed Trade-up panel | — |

## Step F9

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-CON-020 | MDL | High-Roller supply crate with parachute | 4x4x4 |
| MDL-MUT-011 | MDL | Supermutant Banshee | 6x11x4 |
| MDL-MUT-012 | MDL | Supermutant Creeper | 6x11x4 |
| MDL-MUT-013 | MDL | Supermutant Juggernaut | 6x11x4 |
| MDL-NPC-011 | MDL | Sully (catalyst dealer) | 2x5x1 |
| MDL-NPC-012 | MDL | Dr. Halloran (The Lab) | 2x5x1 |
| MDL-TWR-041 | MDL | Catalyst stall (Sully) | 8x8x6 |
| MDL-TWR-042 | MDL | The Lab (Dr. Halloran, tanks with mutant variants) | 20x12x16 |
| SFX-MUT-033 | SFX | Banshee screech | — |
| SFX-MUT-034 | SFX | Creeper skitter | — |
| SFX-MUT-035 | SFX | Juggernaut steps | — |
| MUS-RAID-040 | MUS | Blood Moon bed | — |
| VO-NPC-061 | VO | NPC Sully line 1 | — |
| VO-NPC-062 | VO | NPC Sully line 2 | — |
| VO-NPC-063 | VO | NPC Sully line 3 | — |
| VO-NPC-064 | VO | NPC Sully line 4 | — |
| VO-NPC-065 | VO | NPC Sully line 5 | — |
| VO-NPC-066 | VO | NPC Sully line 6 | — |
| VO-NPC-067 | VO | NPC Dr. Halloran line 1 | — |
| VO-NPC-068 | VO | NPC Dr. Halloran line 2 | — |
| VO-NPC-069 | VO | NPC Dr. Halloran line 3 | — |
| VO-NPC-070 | VO | NPC Dr. Halloran line 4 | — |
| VO-NPC-071 | VO | NPC Dr. Halloran line 5 | — |
| VO-NPC-072 | VO | NPC Dr. Halloran line 6 | — |
| UI-CAT-001 | UI | Catalyst dealer panel | — |
| UI-HUD-070 | UI | Catalyst icon (live odds) | — |
| UI-LAB-001 | UI | Supermutant variants panel | — |
| VFX-CAT-001 | VFX | Red smoke (supply drop marker) | — |
| VFX-CAT-002 | VFX | Blood Moon sky tint through skylights | — |

## Step F10

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-FLT-090 | MDL | Door banner: weekly Tower Standing top 10 | 3x5x0.1 |
| MDL-MUT-020 | MDL | Stalker skin Rotten | 6x11x4 |
| MDL-MUT-021 | MDL | Supermutant roar set (visual mouth variant) | 6x11x4 |
| MDL-MUT-022 | MDL | Stalker skin Ashen | 6x11x4 |
| MDL-MUT-023 | MDL | Supermutant skin Chitin | 6x11x4 |
| MDL-MUT-024 | MDL | Mutation VFX holder Black Bloom | 6x11x4 |
| MDL-MUT-025 | MDL | Supermutant skin Leviathan | 6x11x4 |
| MDL-TRO-001 | MDL | Achievement trophy 1 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-002 | MDL | Achievement trophy 2 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-003 | MDL | Achievement trophy 3 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-004 | MDL | Achievement trophy 4 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-005 | MDL | Achievement trophy 5 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-006 | MDL | Achievement trophy 6 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-007 | MDL | Achievement trophy 7 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-008 | MDL | Achievement trophy 8 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-009 | MDL | Achievement trophy 9 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-010 | MDL | Achievement trophy 10 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-011 | MDL | Achievement trophy 11 (see 13 §13.9 table) | 1x2x1 |
| MDL-TRO-012 | MDL | Achievement trophy 12 (see 13 §13.9 table) | 1x2x1 |
| MDL-TWR-062 | MDL | Contract Board (daily contracts) | 8x6x1 |
| SFX-MUT-040 | SFX | Mutant Track roar Grave Howl | — |
| SFX-UI-031 | SFX | Collection Book entry | — |
| SFX-UI-041 | SFX | Contract complete | — |
| SFX-UI-042 | SFX | Achievement | — |
| UI-ACH-001 | UI | Achievement icon ACH-001 | — |
| UI-ACH-002 | UI | Achievement icon ACH-002 | — |
| UI-ACH-003 | UI | Achievement icon ACH-003 | — |
| UI-ACH-004 | UI | Achievement icon ACH-004 | — |
| UI-ACH-005 | UI | Achievement icon ACH-005 | — |
| UI-ACH-006 | UI | Achievement icon ACH-006 | — |
| UI-ACH-007 | UI | Achievement icon ACH-007 | — |
| UI-ACH-008 | UI | Achievement icon ACH-008 | — |
| UI-ACH-009 | UI | Achievement icon ACH-009 | — |
| UI-ACH-010 | UI | Achievement icon ACH-010 | — |
| UI-ACH-011 | UI | Achievement icon ACH-011 | — |
| UI-ACH-012 | UI | Achievement icon ACH-012 | — |
| UI-ACH-013 | UI | Achievement icon ACH-013 | — |
| UI-ACH-014 | UI | Achievement icon ACH-014 | — |
| UI-ACH-015 | UI | Achievement icon ACH-015 | — |
| UI-ACH-016 | UI | Achievement icon ACH-016 | — |
| UI-ACH-017 | UI | Achievement icon ACH-017 | — |
| UI-ACH-018 | UI | Achievement icon ACH-018 | — |
| UI-ACH-019 | UI | Achievement icon ACH-019 | — |
| UI-ACH-020 | UI | Achievement icon ACH-020 | — |
| UI-ACH-021 | UI | Achievement icon ACH-021 | — |
| UI-ACH-022 | UI | Achievement icon ACH-022 | — |
| UI-ACH-023 | UI | Achievement icon ACH-023 | — |
| UI-ACH-024 | UI | Achievement icon ACH-024 | — |
| UI-ACH-025 | UI | Achievement icon ACH-025 | — |
| UI-ACH-026 | UI | Achievement icon ACH-026 | — |
| UI-ACH-027 | UI | Achievement icon ACH-027 | — |
| UI-ACH-028 | UI | Achievement icon ACH-028 | — |
| UI-ACH-029 | UI | Achievement icon ACH-029 | — |
| UI-ACH-030 | UI | Achievement icon ACH-030 | — |
| UI-ACH-031 | UI | Achievement icon ACH-031 | — |
| UI-ACH-032 | UI | Achievement icon ACH-032 | — |
| UI-ACH-033 | UI | Achievement icon ACH-033 | — |
| UI-ACH-034 | UI | Achievement icon ACH-034 | — |
| UI-ACH-035 | UI | Achievement icon ACH-035 | — |
| UI-ACH-036 | UI | Achievement icon ACH-036 | — |
| UI-ACH-037 | UI | Achievement icon ACH-037 | — |
| UI-ACH-038 | UI | Achievement icon ACH-038 | — |
| UI-ACH-039 | UI | Achievement icon ACH-039 | — |
| UI-ACH-040 | UI | Achievement icon ACH-040 | — |
| UI-COL-001 | UI | Collection Book | — |
| UI-NPF-001 | UI | Nameplate frame 1 | — |
| UI-NPF-002 | UI | Nameplate frame 2 | — |
| UI-NPF-003 | UI | Nameplate frame 3 | — |
| UI-NPF-004 | UI | Nameplate frame 4 | — |
| UI-NPF-005 | UI | Nameplate frame 5 | — |
| UI-NPF-006 | UI | Nameplate frame 6 | — |
| VFX-MUT-020 | VFX | Mutation VFX Black Bloom (Mutant Track) | — |

## Step F11

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MDL-CHM-001 | MDL | Gun charm 1 | 0.5x0.5x0.5 |
| MDL-CHM-002 | MDL | Gun charm 2 | 0.5x0.5x0.5 |
| MDL-CHM-003 | MDL | Gun charm 3 | 0.5x0.5x0.5 |
| MDL-CHM-004 | MDL | Gun charm 4 | 0.5x0.5x0.5 |
| MDL-CHM-005 | MDL | Gun charm 5 | 0.5x0.5x0.5 |
| MDL-CHM-006 | MDL | Gun charm 6 | 0.5x0.5x0.5 |
| MDL-CHM-007 | MDL | Gun charm 7 | 0.5x0.5x0.5 |
| MDL-CHM-008 | MDL | Gun charm 8 | 0.5x0.5x0.5 |
| MDL-CHM-009 | MDL | Gun charm 9 | 0.5x0.5x0.5 |
| MDL-CHM-010 | MDL | Gun charm 10 | 0.5x0.5x0.5 |
| MDL-CHM-011 | MDL | Gun charm 11 | 0.5x0.5x0.5 |
| MDL-CHM-012 | MDL | Gun charm 12 | 0.5x0.5x0.5 |
| MDL-FLT-091 | MDL | Door banner (shop) 1 | 3x5x0.1 |
| MDL-FLT-092 | MDL | Door banner (shop) 2 | 3x5x0.1 |
| MDL-FLT-093 | MDL | Door banner (shop) 3 | 3x5x0.1 |
| MDL-FLT-094 | MDL | Door banner (shop) 4 | 3x5x0.1 |
| MDL-FLT-095 | MDL | Door banner (shop) 5 | 3x5x0.1 |
| MDL-FLT-096 | MDL | Door banner (shop) 6 | 3x5x0.1 |
| MDL-FLT-097 | MDL | Door banner (shop) 7 | 3x5x0.1 |
| MDL-FLT-098 | MDL | Door banner (shop) 8 | 3x5x0.1 |
| MDL-FLT-099 | MDL | Door banner (shop) 9 | 3x5x0.1 |
| MDL-OUT-001 | MDL | Survivor outfit set 1 (19 §19.5) | 2x5x1 |
| MDL-OUT-002 | MDL | Survivor outfit set 2 (19 §19.5) | 2x5x1 |
| MDL-OUT-003 | MDL | Survivor outfit set 3 (19 §19.5) | 2x5x1 |
| MDL-OUT-004 | MDL | Survivor outfit set 4 (19 §19.5) | 2x5x1 |
| MDL-OUT-005 | MDL | Survivor outfit set 5 (19 §19.5) | 2x5x1 |
| MDL-OUT-006 | MDL | Survivor outfit set 6 (19 §19.5) | 2x5x1 |
| MDL-OUT-007 | MDL | Survivor outfit set 7 (19 §19.5) | 2x5x1 |
| MDL-OUT-008 | MDL | Survivor outfit set 8 (19 §19.5) | 2x5x1 |
| MDL-OUT-009 | MDL | Survivor outfit set 9 (19 §19.5) | 2x5x1 |
| MDL-OUT-010 | MDL | Survivor outfit set 10 (19 §19.5) | 2x5x1 |
| MDL-OUT-011 | MDL | Survivor outfit set 11 (19 §19.5) | 2x5x1 |
| MDL-OUT-012 | MDL | Survivor outfit set 12 (19 §19.5) | 2x5x1 |
| MDL-OUT-013 | MDL | Survivor outfit set 13 (19 §19.5) | 2x5x1 |
| MDL-OUT-014 | MDL | Survivor outfit set 14 (19 §19.5) | 2x5x1 |
| MDL-OUT-015 | MDL | Survivor outfit set 15 (19 §19.5) | 2x5x1 |
| MDL-OUT-016 | MDL | Survivor outfit set 16 (19 §19.5) | 2x5x1 |
| MDL-OUT-017 | MDL | Survivor outfit set 17 (19 §19.5) | 2x5x1 |
| MDL-OUT-018 | MDL | Survivor outfit set 18 (19 §19.5) | 2x5x1 |
| MDL-OUT-019 | MDL | Survivor outfit set 19 (19 §19.5) | 2x5x1 |
| MDL-OUT-020 | MDL | Survivor outfit set 20 (19 §19.5) | 2x5x1 |
| ANIM-EMO-005 | ANIM | Paid emote 1 (shop, 19 §19.5) | — |
| ANIM-EMO-006 | ANIM | Paid emote 2 (shop, 19 §19.5) | — |
| ANIM-EMO-007 | ANIM | Paid emote 3 (shop, 19 §19.5) | — |
| ANIM-EMO-008 | ANIM | Paid emote 4 (shop, 19 §19.5) | — |
| ANIM-EMO-009 | ANIM | Paid emote 5 (shop, 19 §19.5) | — |
| ANIM-EMO-010 | ANIM | Paid emote 6 (shop, 19 §19.5) | — |
| ANIM-EMO-011 | ANIM | Paid emote 7 (shop, 19 §19.5) | — |
| ANIM-EMO-012 | ANIM | Paid emote 8 (shop, 19 §19.5) | — |
| VO-VOX-001 | VO | Voice pack line 1 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-002 | VO | Voice pack line 2 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-003 | VO | Voice pack line 3 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-004 | VO | Voice pack line 4 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-005 | VO | Voice pack line 5 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-006 | VO | Voice pack line 6 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-007 | VO | Voice pack line 7 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-008 | VO | Voice pack line 8 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-009 | VO | Voice pack line 9 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-010 | VO | Voice pack line 10 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-011 | VO | Voice pack line 11 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-012 | VO | Voice pack line 12 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-013 | VO | Voice pack line 13 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-014 | VO | Voice pack line 14 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-015 | VO | Voice pack line 15 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-016 | VO | Voice pack line 16 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-017 | VO | Voice pack line 17 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-018 | VO | Voice pack line 18 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-019 | VO | Voice pack line 19 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-020 | VO | Voice pack line 20 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-021 | VO | Voice pack line 21 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-022 | VO | Voice pack line 22 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-023 | VO | Voice pack line 23 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-024 | VO | Voice pack line 24 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-025 | VO | Voice pack line 25 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-026 | VO | Voice pack line 26 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-027 | VO | Voice pack line 27 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-028 | VO | Voice pack line 28 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-029 | VO | Voice pack line 29 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-030 | VO | Voice pack line 30 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-031 | VO | Voice pack line 31 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-032 | VO | Voice pack line 32 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-033 | VO | Voice pack line 33 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-034 | VO | Voice pack line 34 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-035 | VO | Voice pack line 35 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-036 | VO | Voice pack line 36 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-037 | VO | Voice pack line 37 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-038 | VO | Voice pack line 38 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-039 | VO | Voice pack line 39 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-040 | VO | Voice pack line 40 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-041 | VO | Voice pack line 41 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-042 | VO | Voice pack line 42 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-043 | VO | Voice pack line 43 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-044 | VO | Voice pack line 44 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-045 | VO | Voice pack line 45 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-046 | VO | Voice pack line 46 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-047 | VO | Voice pack line 47 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-048 | VO | Voice pack line 48 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-049 | VO | Voice pack line 49 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-050 | VO | Voice pack line 50 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-051 | VO | Voice pack line 51 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-052 | VO | Voice pack line 52 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-053 | VO | Voice pack line 53 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-054 | VO | Voice pack line 54 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-055 | VO | Voice pack line 55 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-056 | VO | Voice pack line 56 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-057 | VO | Voice pack line 57 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-058 | VO | Voice pack line 58 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-059 | VO | Voice pack line 59 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-060 | VO | Voice pack line 60 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-061 | VO | Voice pack line 61 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-062 | VO | Voice pack line 62 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-063 | VO | Voice pack line 63 (4 packs x 8 lines x 2 takes) | — |
| VO-VOX-064 | VO | Voice pack line 64 (4 packs x 8 lines x 2 takes) | — |
| UI-COS-001 | UI | Cosmetic icon 1 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-002 | UI | Cosmetic icon 2 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-003 | UI | Cosmetic icon 3 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-004 | UI | Cosmetic icon 4 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-005 | UI | Cosmetic icon 5 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-006 | UI | Cosmetic icon 6 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-007 | UI | Cosmetic icon 7 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-008 | UI | Cosmetic icon 8 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-009 | UI | Cosmetic icon 9 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-010 | UI | Cosmetic icon 10 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-011 | UI | Cosmetic icon 11 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-012 | UI | Cosmetic icon 12 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-013 | UI | Cosmetic icon 13 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-014 | UI | Cosmetic icon 14 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-015 | UI | Cosmetic icon 15 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-016 | UI | Cosmetic icon 16 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-017 | UI | Cosmetic icon 17 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-018 | UI | Cosmetic icon 18 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-019 | UI | Cosmetic icon 19 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-020 | UI | Cosmetic icon 20 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-021 | UI | Cosmetic icon 21 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-022 | UI | Cosmetic icon 22 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-023 | UI | Cosmetic icon 23 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-024 | UI | Cosmetic icon 24 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-025 | UI | Cosmetic icon 25 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-026 | UI | Cosmetic icon 26 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-027 | UI | Cosmetic icon 27 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-028 | UI | Cosmetic icon 28 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-029 | UI | Cosmetic icon 29 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-030 | UI | Cosmetic icon 30 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-031 | UI | Cosmetic icon 31 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-032 | UI | Cosmetic icon 32 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-033 | UI | Cosmetic icon 33 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-034 | UI | Cosmetic icon 34 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-035 | UI | Cosmetic icon 35 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-036 | UI | Cosmetic icon 36 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-037 | UI | Cosmetic icon 37 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-038 | UI | Cosmetic icon 38 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-039 | UI | Cosmetic icon 39 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-040 | UI | Cosmetic icon 40 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-041 | UI | Cosmetic icon 41 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-042 | UI | Cosmetic icon 42 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-043 | UI | Cosmetic icon 43 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-044 | UI | Cosmetic icon 44 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-045 | UI | Cosmetic icon 45 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-046 | UI | Cosmetic icon 46 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-047 | UI | Cosmetic icon 47 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-048 | UI | Cosmetic icon 48 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-049 | UI | Cosmetic icon 49 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-050 | UI | Cosmetic icon 50 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-051 | UI | Cosmetic icon 51 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-052 | UI | Cosmetic icon 52 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-053 | UI | Cosmetic icon 53 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-054 | UI | Cosmetic icon 54 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-055 | UI | Cosmetic icon 55 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-056 | UI | Cosmetic icon 56 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-057 | UI | Cosmetic icon 57 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-058 | UI | Cosmetic icon 58 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-059 | UI | Cosmetic icon 59 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-060 | UI | Cosmetic icon 60 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-061 | UI | Cosmetic icon 61 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-062 | UI | Cosmetic icon 62 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-063 | UI | Cosmetic icon 63 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-064 | UI | Cosmetic icon 64 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-065 | UI | Cosmetic icon 65 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-066 | UI | Cosmetic icon 66 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-067 | UI | Cosmetic icon 67 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-068 | UI | Cosmetic icon 68 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-069 | UI | Cosmetic icon 69 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-070 | UI | Cosmetic icon 70 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-071 | UI | Cosmetic icon 71 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-072 | UI | Cosmetic icon 72 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-073 | UI | Cosmetic icon 73 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-074 | UI | Cosmetic icon 74 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-075 | UI | Cosmetic icon 75 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-076 | UI | Cosmetic icon 76 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-077 | UI | Cosmetic icon 77 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-078 | UI | Cosmetic icon 78 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-079 | UI | Cosmetic icon 79 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-080 | UI | Cosmetic icon 80 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-081 | UI | Cosmetic icon 81 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-082 | UI | Cosmetic icon 82 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-083 | UI | Cosmetic icon 83 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-084 | UI | Cosmetic icon 84 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-085 | UI | Cosmetic icon 85 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-086 | UI | Cosmetic icon 86 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-087 | UI | Cosmetic icon 87 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-088 | UI | Cosmetic icon 88 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-089 | UI | Cosmetic icon 89 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-090 | UI | Cosmetic icon 90 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-091 | UI | Cosmetic icon 91 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-092 | UI | Cosmetic icon 92 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-093 | UI | Cosmetic icon 93 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-094 | UI | Cosmetic icon 94 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-095 | UI | Cosmetic icon 95 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-096 | UI | Cosmetic icon 96 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-097 | UI | Cosmetic icon 97 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-098 | UI | Cosmetic icon 98 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-099 | UI | Cosmetic icon 99 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-100 | UI | Cosmetic icon 100 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-101 | UI | Cosmetic icon 101 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-102 | UI | Cosmetic icon 102 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-103 | UI | Cosmetic icon 103 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-104 | UI | Cosmetic icon 104 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-105 | UI | Cosmetic icon 105 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-106 | UI | Cosmetic icon 106 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-107 | UI | Cosmetic icon 107 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-108 | UI | Cosmetic icon 108 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-109 | UI | Cosmetic icon 109 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-110 | UI | Cosmetic icon 110 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-111 | UI | Cosmetic icon 111 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-112 | UI | Cosmetic icon 112 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-113 | UI | Cosmetic icon 113 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-114 | UI | Cosmetic icon 114 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-115 | UI | Cosmetic icon 115 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-116 | UI | Cosmetic icon 116 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-117 | UI | Cosmetic icon 117 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-118 | UI | Cosmetic icon 118 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-119 | UI | Cosmetic icon 119 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-120 | UI | Cosmetic icon 120 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-121 | UI | Cosmetic icon 121 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-122 | UI | Cosmetic icon 122 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-123 | UI | Cosmetic icon 123 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-124 | UI | Cosmetic icon 124 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-125 | UI | Cosmetic icon 125 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-126 | UI | Cosmetic icon 126 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-127 | UI | Cosmetic icon 127 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-128 | UI | Cosmetic icon 128 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-129 | UI | Cosmetic icon 129 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-COS-130 | UI | Cosmetic icon 130 (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners) | — |
| UI-FLT-040 | UI | Gunsmith (finishes, stickers, charms) | — |
| UI-PASS-001 | UI | Evac Pass page | — |
| UI-PASS-010 | UI | Restricted crate choice | — |
| UI-SHOP-001 | UI | Shop | — |
| UI-SHOP-010 | UI | Cosmetic 3D preview | — |
| VFX-DTH-001 | VFX | Death effect 1 (19 §19.5) | — |
| VFX-DTH-002 | VFX | Death effect 2 (19 §19.5) | — |
| VFX-DTH-003 | VFX | Death effect 3 (19 §19.5) | — |
| VFX-DTH-004 | VFX | Death effect 4 (19 §19.5) | — |
| VFX-DTH-005 | VFX | Death effect 5 (19 §19.5) | — |
| VFX-DTH-006 | VFX | Death effect 6 (19 §19.5) | — |
| VFX-FLR-001 | VFX | Extraction flare 1 (19 §19.5) | — |
| VFX-FLR-002 | VFX | Extraction flare 2 (19 §19.5) | — |
| VFX-FLR-003 | VFX | Extraction flare 3 (19 §19.5) | — |
| VFX-FLR-004 | VFX | Extraction flare 4 (19 §19.5) | — |
| VFX-FLR-005 | VFX | Extraction flare 5 (19 §19.5) | — |
| VFX-FLR-006 | VFX | Extraction flare 6 (19 §19.5) | — |
| VFX-MFX-001 | VFX | Mutation effect 1 (19 §19.5) | — |
| VFX-MFX-002 | VFX | Mutation effect 2 (19 §19.5) | — |
| VFX-MFX-003 | VFX | Mutation effect 3 (19 §19.5) | — |
| VFX-MFX-004 | VFX | Mutation effect 4 (19 §19.5) | — |
| VFX-MFX-005 | VFX | Mutation effect 5 (19 §19.5) | — |
| VFX-MFX-006 | VFX | Mutation effect 6 (19 §19.5) | — |
| TEX-FIN-001 | TEX | Weapon finish 1 (19 §19.5) | — |
| TEX-FIN-002 | TEX | Weapon finish 2 (19 §19.5) | — |
| TEX-FIN-003 | TEX | Weapon finish 3 (19 §19.5) | — |
| TEX-FIN-004 | TEX | Weapon finish 4 (19 §19.5) | — |
| TEX-FIN-005 | TEX | Weapon finish 5 (19 §19.5) | — |
| TEX-FIN-006 | TEX | Weapon finish 6 (19 §19.5) | — |
| TEX-FIN-007 | TEX | Weapon finish 7 (19 §19.5) | — |
| TEX-FIN-008 | TEX | Weapon finish 8 (19 §19.5) | — |
| TEX-FIN-009 | TEX | Weapon finish 9 (19 §19.5) | — |
| TEX-FIN-010 | TEX | Weapon finish 10 (19 §19.5) | — |
| TEX-FIN-011 | TEX | Weapon finish 11 (19 §19.5) | — |
| TEX-FIN-012 | TEX | Weapon finish 12 (19 §19.5) | — |
| TEX-FIN-013 | TEX | Weapon finish 13 (19 §19.5) | — |
| TEX-FIN-014 | TEX | Weapon finish 14 (19 §19.5) | — |
| TEX-FIN-015 | TEX | Weapon finish 15 (19 §19.5) | — |
| TEX-FIN-016 | TEX | Weapon finish 16 (19 §19.5) | — |
| TEX-FIN-017 | TEX | Weapon finish 17 (19 §19.5) | — |
| TEX-FIN-018 | TEX | Weapon finish 18 (19 §19.5) | — |
| TEX-FIN-019 | TEX | Weapon finish 19 (19 §19.5) | — |
| TEX-FIN-020 | TEX | Weapon finish 20 (19 §19.5) | — |
| TEX-FIN-021 | TEX | Weapon finish 21 (19 §19.5) | — |
| TEX-FIN-022 | TEX | Weapon finish 22 (19 §19.5) | — |
| TEX-FIN-023 | TEX | Weapon finish 23 (19 §19.5) | — |
| TEX-FIN-024 | TEX | Weapon finish 24 (19 §19.5) | — |
| TEX-STK-001 | TEX | Weapon sticker 1 (19 §19.5) | — |
| TEX-STK-002 | TEX | Weapon sticker 2 (19 §19.5) | — |
| TEX-STK-003 | TEX | Weapon sticker 3 (19 §19.5) | — |
| TEX-STK-004 | TEX | Weapon sticker 4 (19 §19.5) | — |
| TEX-STK-005 | TEX | Weapon sticker 5 (19 §19.5) | — |
| TEX-STK-006 | TEX | Weapon sticker 6 (19 §19.5) | — |
| TEX-STK-007 | TEX | Weapon sticker 7 (19 §19.5) | — |
| TEX-STK-008 | TEX | Weapon sticker 8 (19 §19.5) | — |
| TEX-STK-009 | TEX | Weapon sticker 9 (19 §19.5) | — |
| TEX-STK-010 | TEX | Weapon sticker 10 (19 §19.5) | — |
| TEX-STK-011 | TEX | Weapon sticker 11 (19 §19.5) | — |
| TEX-STK-012 | TEX | Weapon sticker 12 (19 §19.5) | — |
| TEX-STK-013 | TEX | Weapon sticker 13 (19 §19.5) | — |
| TEX-STK-014 | TEX | Weapon sticker 14 (19 §19.5) | — |
| TEX-STK-015 | TEX | Weapon sticker 15 (19 §19.5) | — |
| TEX-STK-016 | TEX | Weapon sticker 16 (19 §19.5) | — |
| TEX-STK-017 | TEX | Weapon sticker 17 (19 §19.5) | — |
| TEX-STK-018 | TEX | Weapon sticker 18 (19 §19.5) | — |
| TEX-STK-019 | TEX | Weapon sticker 19 (19 §19.5) | — |
| TEX-STK-020 | TEX | Weapon sticker 20 (19 §19.5) | — |
| TEX-STK-021 | TEX | Weapon sticker 21 (19 §19.5) | — |
| TEX-STK-022 | TEX | Weapon sticker 22 (19 §19.5) | — |
| TEX-STK-023 | TEX | Weapon sticker 23 (19 §19.5) | — |
| TEX-STK-024 | TEX | Weapon sticker 24 (19 §19.5) | — |
| TEX-STK-025 | TEX | Weapon sticker 25 (19 §19.5) | — |
| TEX-STK-026 | TEX | Weapon sticker 26 (19 §19.5) | — |
| TEX-STK-027 | TEX | Weapon sticker 27 (19 §19.5) | — |
| TEX-STK-028 | TEX | Weapon sticker 28 (19 §19.5) | — |
| TEX-STK-029 | TEX | Weapon sticker 29 (19 §19.5) | — |
| TEX-STK-030 | TEX | Weapon sticker 30 (19 §19.5) | — |

## Step P1

| Id | Kind | What | Placeholder size |
|---|---|---|---|
| MUS-SEA-001 | MUS | Season 1 theme (pass page, trailer) | — |
| UI-STO-001 | UI | Store icon 512x512 (infected survivor face, flashlight, mall sign) | — |
| UI-STO-010 | UI | Thumbnail: the Lockdown | — |
| UI-STO-011 | UI | Thumbnail: the Sleeper reveal | — |
| UI-STO-012 | UI | Thumbnail: the struggle | — |
| UI-STO-013 | UI | Thumbnail: Red Alert sprint | — |
| UI-STO-014 | UI | Thumbnail: the tower at night | — |
