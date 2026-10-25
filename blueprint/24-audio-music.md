# 24 · Audio and music

Owner of: the mix and SoundService setup, the adaptive music system, ambience and sound zones, the PA and radio, 3D settings and occlusion, voice-limit rules, and the **complete cue list** (every SFX, MUS and VO id with what it is and when it plays). Asset stages and placeholder rules are in `27`. A sound that isn't listed here isn't in the game.

---

## 24.1 Mix and setup

- `SoundService`: `RespectFilteringEnabled = true`, `RolloffScale = 1`, `DistanceFactor = 3.33` (studs to metres).
- **SoundGroups** (volumes from Settings, `02` §2.13): `Master` → `Music`, `SFX` (children: `Weapons`, `Footsteps`, `World`, `Zombies`, `UI`), `Voice` (VO, quick lines, Roblox voice), `Ambience`.
- **Ducking:** while a struggle bar is up, the Red Alert siren starts, or a Lockdown slams, `Music` and `Ambience` duck −8 dB for 1.5 s (`SoundGroup` volume tween).
- **Loudness:** every asset normalised to −16 LUFS integrated (−1 dBTP peak) before upload. Gunshots and glass break are allowed to −12 LUFS.
- **Voice limit:** max 48 simultaneous 3D sounds per client; zombie idles are culled first (beyond 30 studs, then oldest), then footsteps beyond 25 studs. Gunshots, glass, sirens, The Janitor and UI are never culled.

## 24.2 Adaptive music (raid)

Mostly silence. Music exists to signal threat and the big moments.

| Layer | Id | Plays when | Fade |
|---|---|---|---|
| Ambient drone (raid bed) | `MUS-RAID-001` | from Deploy, very low (−24 dB), only if no other layer is active | 4 s |
| Tension 1 (pulse) | `MUS-RAID-002` | your fear ≥ 30 or any AI in `Alert` toward you | 2 s in, 6 s out |
| Tension 2 (percussion) | `MUS-RAID-003` | fear ≥ 60 or 3+ AI chasing you | 1 s in, 6 s out |
| Janitor motif | `MUS-RAID-004` | The Janitor within 40 and has line of sight to you, or is chasing you | 0.5 s in, 4 s out |
| Sleeper motif (own client only) | `MUS-RAID-005` | while you're a Sleeper, under everything, −18 dB, rising in the last 20 s | 3 s |
| Red Alert theme | `MUS-RAID-010` | RedAlert.Countdown and Open (replaces all tension layers) | cut in on siren |
| Lockdown theme | `MUS-RAID-020` | Lockdown (replaces everything) | slam cut |
| Reopen sting + loop | `MUS-RAID-021` | Reopen | cut |
| Extraction sting | `MUS-RAID-030` | on your departure | cut |
| Death sting | `MUS-RAID-031` | on your death (before the death screen) | cut |
| Blood Moon bed | `MUS-RAID-040` | Blood Moon catalyst raids, replaces `MUS-RAID-001` | 4 s |
| Mutant hunt theme (mutant players only) | `MUS-RAID-050` | while you're a Stalker Mutant | 2 s |
| Ghost bed (Ghost only) | `MUS-RAID-051` | while you're a Ghost | 2 s |
| Orientation bed | `MUS-RAID-060` | Orientation Run | 4 s |

- Layers 002/003/004 run on the client from local state (fear, AI states replicated as attributes). Only one of the tension layers plays at a time (highest wins).

## 24.3 Ambience and sound zones

| Zone (map volume tag) | Reverb (`SoundService.AmbientReverb` via zone switcher) | Ambience loop |
|---|---|---|
| Galleria | `Hangar` | `SFX-AMB-001` wind through broken skylights, distant groans, pigeon flutters |
| Shops | `Room` | `SFX-AMB-002` muffled hum, dripping |
| Service corridors | `Hallway` | `SFX-AMB-003` pipes knocking, steam hiss |
| Cinema | `PaddedCell` | `SFX-AMB-004` near silence, projector tick (one booth) |
| Basement Garage | `ParkingLot` | `SFX-AMB-005` car alarm far off (stops after 30 s), water drip |
| Maintenance | `SewerPipe` | `SFX-AMB-006` boiler rumble |
| Roof | `Plain` | `SFX-AMB-007` wind, distant helicopters, city sirens |
| Powered wing (additive) | — | `SFX-AMB-008` fluorescent buzz, muzak from ceiling speakers (`MUS-RAID-070`, tinny, −20 dB) |
| Tower ground | `Hangar` | `SFX-TWR-020…023` crowd murmur, footsteps, Flea haggling walla |
| Tower corridors | `Hallway` | `SFX-TWR-024…035` TVs, arguments, babies, dogs behind doors |
| Tower roof | `Plain` | `SFX-TWR-036` wind, `SFX-TWR-037` burning barrel |
| Flats | `LivingRoom` | flat ambient track (`MUS-FLT-*`) or silence |

Zone switching: the client checks its camera's zone every 0.5 s and crossfades ambience over 1.5 s; reverb switches instantly.

## 24.4 PA and radio

- **Mall PA** (in-world speakers in every wing, `MDL-ENV-090`): plays as 3D sounds from the nearest 3 speakers to each listener (client-side), with a distortion effect. Lines: `VO-PA-001…004`, `VO-PA-010…013`, `VO-PA-020/021` (§24.7). Subtitled.
- **Mall radio** (bounty calls, `17` §17.7): same speakers, a different voice and radio static intro `SFX-RAD-001`.
- **Tower PA** ("Tower Management"): `VO-PA-030…045` every 4–6 minutes on the ground floor and corridors (`14` §14.14).

## 24.5 3D sound rules

- All world sounds are 3D with `RollOffMode = InverseTapered`, `RollOffMinDistance` 6, `RollOffMaxDistance` = the sound's audible range (equal to its noise radius from `02` §2.5 where one exists, else listed below).
- **Occlusion:** each 3D sound within 60 studs gets a client-side raycast every 0.25 s from listener to source; if blocked by a `Structural` or closed shutter/door part, apply an `EqualizerSoundEffect` (−18 dB high) and −4 dB volume. Different floor: −8 dB and low-pass.
- **Floors:** a sound on another floor is heard only if its noise is multi-floor (`06` §6.1) or within 30.
- Footsteps from other players use the same rules (they're the main stealth information).

## 24.6 Sound effects (complete list)

### Player and movement (`SFX-PLR`)
| Id | Sound | Range |
|---|---|---|
| SFX-PLR-050…055 | Footsteps on tile: walk ×3, sprint ×3 | noise radius |
| SFX-PLR-056…061 | Footsteps on concrete: walk ×3, sprint ×3 | noise radius |
| SFX-PLR-010 | Heartbeat loop (fear ≥ 40, pitch/rate by fear) — 2D, own client | — |
| SFX-PLR-011…013 | Breathing: calm / heavy / laboured — 2D, own client; others hear heavy and laboured within 8 | 8 |
| SFX-PLR-014 | Gasp (hold breath ends at 0 stamina) | 25 |
| SFX-PLR-062…067 | Footsteps on carpet, metal, glass shards (crunch ×2), water, grate | noise radius |
| SFX-PLR-021 | Crouch cloth rustle | 4 |
| SFX-PLR-022 | Roll (cloth + thud) | 18 |
| SFX-PLR-023 | Slide (scrape loop) | 25 |
| SFX-PLR-024 | Mantle / vault grunt + hands on rail | 18 |
| SFX-PLR-025 | Landing (light / heavy pair: 025, 026) | 18 / 30 |
| SFX-PLR-027 | Bone crack (fracture) | 12 |
| SFX-PLR-028…030 | Pain grunts (by build) | 15 |
| SFX-PLR-031 | Body fall / ragdoll thump | 20 |
| SFX-PLR-032 | Downed crawl drag loop | 10 |
| SFX-PLR-033 | Death exhale | 10 |
| SFX-PLR-034 | Ladder climb steps (metal) loop | 12 |
| SFX-PLR-035 | Window climb-through scrape | 18 |
| SFX-PLR-036 | Inventory rummage loop (container open) | 8 |
| SFX-PLR-037 | Equip backpack / armour (velcro, straps) | 6 |
| SFX-PLR-038 | Low-health ringing (own client, below 25) | — |

Footstep surfaces come from the floor part's `Material` mapped in `Config.Audio.Surface`. Crouched footsteps use the walk set at −12 dB.

### Weapons (`SFX-WPN`)
| Id | Sound |
|---|---|
| SFX-WPN-001/002 | P9 shot close / distant |
| SFX-WPN-003/004 | Wasp (SMG) shot close / distant |
| SFX-WPN-005/006 | Brace (shotgun) shot close / distant + pump `SFX-WPN-007` |
| SFX-WPN-008/009 | Kestrel (AR) shot close / distant |
| SFX-WPN-010/011 | Longhorn (rifle) shot close / distant + bolt `SFX-WPN-012` |
| SFX-WPN-013/014 | Nightjar (suppressed AR) shot close / distant |
| SFX-WPN-015/016 | Revenant (revolver) shot close / distant |
| SFX-WPN-017 | Suppressed pistol/SMG shot (any gun with Suppressor) |
| SFX-WPN-018 | Gunshot tail per zone (galleria / corridor / outdoor: 018, 019, 020) |
| SFX-WPN-021…026 | Reloads: pistol, SMG, shotgun shell insert, AR, rifle, revolver |
| SFX-WPN-027 | Weapon swap / draw (cloth + metal) |
| SFX-WPN-028 | Holster |
| SFX-WPN-029 | Aim in (cloth) |
| SFX-WPN-030 | Dry fire click |
| SFX-WPN-031 | Shell casings on tile (random pitch) |
| SFX-WPN-032 | Attach / detach attachment |
| SFX-WPN-040 | Flesh impact thud (attacker feedback) |
| SFX-WPN-041 | Headshot crack |
| SFX-WPN-042 | Armour impact (plate ping) |
| SFX-WPN-043 | Bullet impacts: concrete, metal, glass, wood, tile (043…047) |
| SFX-WPN-048 | Bullet whiz-by (near miss within 2 studs) |

Distant shot versions play beyond 80 studs (crossfade 60–80).

### Melee, shove, takedown, throwables (`SFX-MEL`, `SFX-THR`)
| Id | Sound |
|---|---|
| SFX-MEL-001…003 | Swing whoosh light (pipe, crowbar, axe) |
| SFX-MEL-004…006 | Swing whoosh heavy |
| SFX-MEL-007…009 | Melee hit flesh (pipe, crowbar, axe) |
| SFX-MEL-010 | Melee hit wall / prop |
| SFX-MEL-011 | Fist punch |
| SFX-MEL-012 | Shove (grunt + body push) |
| SFX-MEL-013 | Stealth takedown (muffled crunch) |
| SFX-MEL-014 | Barricade plank break |
| SFX-THR-001 | Throw whoosh |
| SFX-THR-002 | Bottle smash |
| SFX-THR-003 | Brick thud / skid |
| SFX-THR-004 | Noise Decoy loop (radio static and beeps, 10 s) |
| SFX-THR-005 | Molotov smash + fire whoomp, fire loop `SFX-THR-006` |
| SFX-THR-007 | UV Stun Flare ignite + fizz loop `SFX-THR-008` |
| SFX-THR-009 | Smoke Can hiss loop |

### Environment (`SFX-ENV`)
| Id | Sound |
|---|---|
| SFX-ENV-001…003 | Glass break small / medium / large |
| SFX-ENV-004 | Shards settling tinkle |
| SFX-ENV-005 | Destructible wall break (plaster crash + dust) |
| SFX-ENV-010 | Shutter rattle (move) |
| SFX-ENV-011 | Shutter slam (reaches Down) |
| SFX-ENV-012 | Shutter bash (Janitor) loop |
| SFX-ENV-013 | Interior door open / close (013, 014) |
| SFX-ENV-015 | Door slam |
| SFX-ENV-016 | Security door heavy open |
| SFX-ENV-017 | Barricade nailing (hammer loop) |
| SFX-ENV-018 | Wedge kick-in |
| SFX-ENV-019 | Crowbar pry loop + pop `SFX-ENV-030` |
| SFX-ENV-020 | Store alarm loop |
| SFX-ENV-021 | Trap: hanging sign clatter |
| SFX-ENV-022 | Trap: bottle string jangle |
| SFX-ENV-023 | Alarm disarm beep |
| SFX-ENV-024 | Keycard swipe (accept 024, reject 025) |
| SFX-ENV-026 | Keypad beep, open `SFX-ENV-027`, wrong `SFX-ENV-028` |
| SFX-ENV-029 | Med Safe unlock clunk |
| SFX-ENV-031 | Generator start (cough, rev) |
| SFX-ENV-032 | Generator hum loop |
| SFX-ENV-033 | Power-on: lights clunk on, buzz swell |
| SFX-ENV-034 | Light shot out (pop + glass) |
| SFX-ENV-035 | Escalator running loop |
| SFX-ENV-036 | Service elevator: call ding, motor loop, doors (036, 037, 038) |
| SFX-ENV-039 | Fuel pour |
| SFX-ENV-040 | Container open: bin lid, locker, crate, till drawer, cabinet (040…044) |
| SFX-ENV-045 | Item pick up (generic) / drop (046) |
| SFX-ENV-047 | Emergency light buzz |
| SFX-ENV-048 | Fire crackle (barrels, molotov) |

### Zombies, The Janitor, mutants (`SFX-ZOM`, `SFX-JAN`, `SFX-MUT`)
| Id | Sound |
|---|---|
| SFX-ZOM-001…006 | Walker idle groans |
| SFX-ZOM-010 | Alert soft screech |
| SFX-ZOM-011 | Chase breathing loop |
| SFX-ZOM-012 | Walker footsteps shuffle loop |
| SFX-ZOM-020 | Lunge wind-up |
| SFX-ZOM-021 | Lunge leap |
| SFX-ZOM-022 | Grapple loop (snarl, struggle) |
| SFX-ZOM-023 | Shoved off |
| SFX-ZOM-024 | Bite |
| SFX-ZOM-025 | Pound on shutter / door loop |
| SFX-ZOM-030 | Hit reaction |
| SFX-ZOM-031 | Death |
| SFX-ZOM-040/041 | Crawler crawl / ankle grab |
| SFX-ZOM-050/051 | Sprinter run / swipe |
| SFX-ZOM-052 | Sprinter shriek (on spawn from a Sleeper) |
| SFX-ZOM-060 | Horde surge roar (Red Alert start, mall-wide) |
| SFX-JAN-001 | PA crackle (Janitor enters) |
| SFX-JAN-010 | Mop cart squeal loop |
| SFX-JAN-011 | Heavy breathing loop |
| SFX-JAN-012 | Wet inhale (grab tell) |
| SFX-JAN-013 | Grab + slam |
| SFX-JAN-014 | Stunned howl (UV flare) |
| SFX-JAN-015 | Footsteps (heavy boots) loop |
| SFX-MUT-001 | Sleeper corpse mutating (bones cracking) |
| SFX-MUT-002 | Stalker mutation scream (mall-wide) |
| SFX-MUT-003 | Supermutant transformation roar |
| SFX-MUT-004 | Supermutant death |
| SFX-MUT-005 | Explosive revive roar (Second Wind) |
| SFX-MUT-010…013 | Stalker roars (replace quick lines) |
| SFX-MUT-014 | Stalker claw, pounce (014, 015), climb skitter loop (016) |
| SFX-MUT-020…035 | Supermutant: slam ×2, charge start, charge loop, charge impact, screech, footsteps ×2, wall-run skitter, ceiling drop, hit reactions ×2, breathing loop, Banshee screech, Creeper skitter, Juggernaut steps |
| SFX-MUT-040 | Mutant Track "Grave Howl" roar |

### Infection and medical (`SFX-INF`, `SFX-MED`)
| Id | Sound |
|---|---|
| SFX-INF-001…004 | Sleeper suppressed coughs |
| SFX-INF-010 | Faint heartbeat (Sleeper symptom) |
| SFX-INF-011 | Bitten sting (own client) |
| SFX-INF-012 | Turning rising tone (own client, last 20 s) |
| SFX-INF-013 | Cure exhale (own client) |
| SFX-INF-014 | Scanner beep + result (clean 014, infected 015) |
| SFX-INF-016 | Thermometer beep |
| SFX-MED-001 | Bandage wrap |
| SFX-MED-002 | Pill bottle |
| SFX-MED-003 | Medkit open + rummage |
| SFX-MED-004 | Splint strap |
| SFX-MED-005 | Surgical kit (scissors, tape) |
| SFX-MED-006 | Syringe inject |
| SFX-MED-007 | Revive effort (both) |

### Raid flow (`SFX-RAID`, `SFX-RAD`)
| Id | Sound |
|---|---|
| SFX-RAID-001 | Freight lift descent: siren, motor, clunk |
| SFX-RAID-002 | Lift doors open |
| SFX-RAID-004 | Terminals online chime (mall-wide) |
| SFX-RAID-005 | Terminal activation beeps |
| SFX-RAID-006 | Terminal activated (alarm klaxon start) |
| SFX-RAID-010 | Red Alert siren loop (mall-wide) |
| SFX-RAID-011 | Evac open horn |
| SFX-RAID-020 | Helicopter rotor (approach, hover loop, lift-off) |
| SFX-RAID-021 | Garage freight lift (doors, rise) |
| SFX-RAID-030 | Departure abort alarm buzz |
| SFX-RAID-031 | Lockdown slam |
| SFX-RAID-032 | Reopen unlock |
| SFX-RAID-033 | Early depart confirm beep |
| SFX-RAID-040 | Sealed (blast doors far away, boom) |
| SFX-RAD-001 | Radio static intro (bounty call) |

### Comms, bounties, relics, crafting (`SFX-COM`, `SFX-BNT`, `SFX-REL`, `SFX-CRF`)
| Id | Sound |
|---|---|
| SFX-COM-001/002 | Squad radio key up / release click |
| SFX-COM-005 | Ping |
| SFX-COM-010 | VIP radio crackle |
| SFX-BNT-001 | Most Wanted Wall hum loop |
| SFX-BNT-002 | New #1 alarm sting |
| SFX-BNT-010 | Dogtag chain snap |
| SFX-BNT-011 | Claim cash register |
| SFX-BNT-020 | Hunter proximity ticking (2D) |
| SFX-BNT-030 | Vigilante sting (2D) |
| SFX-REL-001 | Relic found ping (squad) |
| SFX-REL-010 | Engraving |
| SFX-REL-020 | Record press hiss and thump |
| SFX-REL-021 | Vinyl needle drop (jukebox, boombox start) |
| SFX-REL-022 | Boombox click on/off |
| SFX-CRF-001…005 | Tape rip, metal clank, liquid pour, wire twist, wood saw |

### Loot and UI (`SFX-LOOT`, `SFX-UI`)
| Id | Sound |
|---|---|
| SFX-LOOT-001…006 | Reveal stingers: Common, Uncommon, Rare, Epic, Exotic, Relic |
| SFX-LOOT-010…015 | Rising reveal tones by tier |
| SFX-LOOT-020 | Face-down slot shuffle (container opens) |
| SFX-UI-001/002 | Panel open / close |
| SFX-UI-003/004/005 | Hover / press / error |
| SFX-UI-010 | Item drag pick / place (010, 011) |
| SFX-UI-012 | Item rotate |
| SFX-UI-020 | Value count-up tick |
| SFX-UI-021 | Haul total slam |
| SFX-UI-030 | Blueprint learned |
| SFX-UI-031 | Collection Book entry |
| SFX-UI-040 | Level up |
| SFX-UI-041 | Contract complete |
| SFX-UI-042 | Achievement |
| SFX-UI-050 | Raid found |
| SFX-UI-051 | Ready check |
| SFX-UI-060 | Purchase complete (cash) |
| SFX-UI-061 | Wheel success / consolation / destroyed (061, 062, 063) |
| SFX-UI-070 | Mail arrived (soft) |
| SFX-UI-080 | Survivor Draft card flip |

### Tower and flat (`SFX-TWR`, `SFX-FLT`)
| Id | Sound |
|---|---|
| SFX-TWR-001 | Arrival freight-elevator loading scene |
| SFX-TWR-002 | Internal lift ride (2 s) |
| SFX-TWR-003 | Transit Gate doors closing (raid found) |
| SFX-TWR-010 | Wheel ratchet spin |
| SFX-TWR-020…037 | Tower ambience (§24.3) |
| SFX-TWR-040 | Power flicker |
| SFX-TWR-041 | Turret servo (checkpoint idle) |
| SFX-FLT-001 | Flat door open/close |
| SFX-FLT-002 | Knock |
| SFX-FLT-003 | Build mode place / pick / invalid (003, 004, 005) |
| SFX-FLT-006 | Stash chest open |
| SFX-FLT-007 | Workbench tools loop, craft done ding `SFX-FLT-008` |
| SFX-FLT-009 | Moving boxes (Move-in) |

### Ambience (`SFX-AMB`)
`SFX-AMB-001…008` as §24.3.

## 24.7 Voice

| Id | Line(s) |
|---|---|
| VO-PA-001 | Mall PA: "Attention. This facility is under quarantine." (Deploy, once) |
| VO-PA-002 | "Security terminals are now online." (600 s) |
| VO-PA-003 | "Automatic evacuation in sixty seconds." (960 s) |
| VO-PA-004 | "Automatic evacuation triggered." (1020 s) |
| VO-PA-010 | "Evacuation authorised. Proceed to the {Rooftop Helipad / Basement Garage}." (two takes: 010 helipad, 011 garage) |
| VO-PA-012 | "Evacuation window open." |
| VO-PA-013 | "Departing in ten seconds." |
| VO-PA-020 | "Contamination detected. Evacuation suspended." |
| VO-PA-021 | "Evacuation resumed. Final departure." |
| VO-PA-030…045 | Tower Management announcements (16 lines: curfew, rent, bite reporting, lost and found, lift maintenance, "Do not feed the Pawnbroker", Most Wanted reminder, Flea scams warning, etc.) |
| VO-RAD-010…016 | Bounty sighting by wing: Food Court, Pharmacy, Department Store, Electronics, Cinema, Security Office, Maintenance/Garage |
| VO-RAD-020 | Radio static sign-off |
| VO-QL-001…048 | Quick lines (`20` §20.2): 8 lines × 3 takes × voices A and B |
| VO-VOX-001…064 | Voice packs: 4 packs × 8 lines × 2 takes |
| VO-NPC-001…078 | NPC lines (`14` §14.14, `15` §15.9): greetings, purchase, farewell, idle barks; script written in P1 |
| VO-TUT-001…008 | Orientation Run narrator (radio voice "Okafor" guiding the first raid): move, search, crouch, throw, struggle, bitten, terminal, extract |

## 24.8 Music (complete list)

| Id | Track |
|---|---|
| MUS-RAID-001…005, 010, 020, 021, 030, 031, 040, 050, 051, 060, 070 | §24.2, §24.3 |
| MUS-TWR-001 | Tower ground floor bed (low synth, crowd-friendly) |
| MUS-TWR-002 | Transit Gates hall tension bed |
| MUS-TWR-003 | Roof Black Market bed (wind + low bass) |
| MUS-TWR-004 | Arrival connecting loop |
| MUS-TWR-005 | The Drain bar ambient track |
| MUS-FLT-001…005 | Flat ambient tracks (jukebox selectable) |
| MUS-FLT-010…012 | Tower radio channels (Radio Set) |
| MUS-UI-001 | Haul tally loop |
| MUS-UI-002 | Death screen loop |
| MUS-UI-003 | Survivor Draft loop |
| MUS-UI-010 | Relic theme (reveal) |
| MUS-UI-011 | Wheel spin loop |
| MUS-UI-020 | Main menu / Arrival title sting |
| MUS-VIN-001…040 | Vinyl catalogue (`18` §18.8) |
| MUS-SEA-001 | Season trailer and pass page theme (per season; new id each season) |
