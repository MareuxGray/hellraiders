# 22 · Admin menu and testing tools

Owner of: who is an admin, the admin menu and every command, debug overlays, test bots, the Placeholders tab (asset requests), map audit, test places, automated checks and the per-stage checklists. The admin menu is built in S1 and grows with every stage: **each stage adds the commands for its own systems** (listed per stage in `26`).

---

## 22.1 Who can use it

- `Config.Admin.UserIds` (Mareux's user id and named testers) and `Config.Admin.GroupRank` (group rank ≥ 250 if a group owns the game).
- In **Studio** (`RunService:IsStudio()`), everyone is an admin.
- In **live servers**, admin commands work only for listed users, and every command is logged (`25` §25.8, `AdminEvent`) with user, command, arguments and server. Commands that grant currency or items in live servers need `Config.Admin.LiveGrants = true` (default **false**).
- Every command is a server function called through one remote (`Remotes.Admin`). The server checks admin status on every call. The client menu is only a front end.

## 22.2 Opening the menu

- PC **F8**, gamepad **hold Menu + View 2 s**, mobile: a small wrench button top-left (admins only).
- Panel `UI-ADM-001`: tabs on the left, command buttons with argument fields, a command line at the bottom (type `/command args`, with autocomplete), and a log of the last 50 results.
- Commands that target a player default to yourself; a player picker lists everyone in the server.

## 22.3 Commands

### Player
| Command | Effect |
|---|---|
| `/god [on|off]` | no damage, no struggle bites, no fear |
| `/heal` | full health, clear bleeds and fractures, fear 0, stamina 100 |
| `/hurt <zone> <dmg>` | damage a body zone |
| `/bleed <light|heavy>`, `/fracture <leg|arm>` | apply a state |
| `/fear <0-100>`, `/stamina <0-100>` | set |
| `/attr <name> <3-7>` | set a survivor attribute (live Stats recompute) |
| `/survivor new` | retire and open the Survivor Draft |
| `/noclip`, `/fly`, `/speed <n>` | movement debug |
| `/tp <wing|gate|exit|terminal|generator|x y z>` | teleport |
| `/invisible [on|off]` | AI ignore you, other players can't see you (for filming) |
| `/down`, `/kill`, `/revive` | life state |

### Infection and mutants
| Command | Effect |
|---|---|
| `/bite` | become a Sleeper now |
| `/incubation <seconds>` | set remaining incubation |
| `/cure` | Sleeper → Human |
| `/struggle [n]` | start a struggle with struggle number n |
| `/mutate stalker|super [variant]` | transform now |
| `/ghost` | die as a Sleeper (Sprinter + Ghost) |
| `/token <Mutate|Revive|Move|...> [n]` | grant tokens |

### Raid flow
| Command | Effect |
|---|---|
| `/clock <seconds>` | set the raid clock |
| `/redalert [helipad|garage]` | start Red Alert now with a chosen exit |
| `/evac open|depart` | skip to the Open window or force departure |
| `/lockdown` | force a Lockdown (makes you the Supermutant if you're a Sleeper, else spawns a test Supermutant bot) |
| `/reopen`, `/seal`, `/results` | jump states |
| `/janitor spawn|despawn|goto <x y z>` | The Janitor |
| `/catalyst <name|none>` | apply a catalyst to this raid |
| `/orientation` | start the Orientation Run (sets `orientationDone = false`) |
| `/raid solo` | start a 1-player raid from the tower without matchmaking |

### AI and world
| Command | Effect |
|---|---|
| `/spawn walker|crawler|sprinter [n]` | spawn at your aim point |
| `/ai freeze|resume|clear` | |
| `/ai cap <n>` | change the active cap |
| `/noise <radius>` | emit a noise event at your position |
| `/power <north|east|service|all> on|off` | generators |
| `/glass reset`, `/shutters <up|half|down|reset>`, `/doors reset` | world reset |
| `/lights out|on` | |

### Items and loot
| Command | Effect |
|---|---|
| `/give <itemId> [n]` | add to inventory (raid) or stash (tower) |
| `/givebp <category> <tier|model>` | a blueprint item |
| `/clearinv`, `/clearstash` | |
| `/loot reroll` | reroll every container |
| `/loot tier <tier>` | force every container to roll this tier (testing the reveal) |
| `/relic make <itemId>` | create a test Relic; `/relic pool` lists the world pool; `/relic place` claims one into this raid |
| `/taint` | taint the med item in your hand |

### Economy, progression and shop
| Command | Effect |
|---|---|
| `/mc <n>` | set Mall Cash |
| `/xp <n>`, `/level <n>` | progression |
| `/rep <merchant|mutant|vendor|helper> <n>` | reputations |
| `/contracts reset|complete` | |
| `/ach <id>|all|reset` | achievements |
| `/entitle <bunk|exec|penthouse>` | set flat entitlement |
| `/receipt <productName>` | run the product's grant handler as if a receipt arrived (Studio only) |
| `/policy restricted|normal` | fake `ArePaidRandomItemsRestricted` and `IsPaidItemTradingAllowed` for yourself |
| `/wheel force success|downgrade|destroy` | force the next wheel outcome (Studio only) |
| `/pass tier <n>` | Evac Pass tier |

### Tower and residency
| Command | Effect |
|---|---|
| `/tower info` | tower id, status, residents, vacancies, instances |
| `/tower fill <n>` | add n fake residents (bot records) to this tower |
| `/tower annex` | force an Annex instance |
| `/movein <towerId> [tier]` | run Move-in without payment (Studio) |
| `/inactive <days>` | pretend you've been away (relocation test) |
| `/rent due|paid` | |
| `/flat reset` | clear furniture (keeps it in storage) |

### Bounties and Flea
| Command | Effect |
|---|---|
| `/bounty add <pot>` | put a bounty on yourself |
| `/bounty clear`, `/bounty list` | |
| `/title <role|none>` | set a role title |
| `/flea seed <n>` | add n bot listings at random prices within limits |
| `/flea clear` | remove your listings |

### Matchmaking and bots
| Command | Effect |
|---|---|
| `/queue status` | tickets per pool, matchmaker server, last launch |
| `/bots raid <n> [squads]` | add n Test Raiders to this raid (§22.5) |
| `/bots queue <n>` | inject n fake solo tickets so you can test raid launch alone |

### Data and debug
| Command | Effect |
|---|---|
| `/profile dump` | print your profile JSON to the log |
| `/profile wipe` | reset your profile (Studio and test place only; asks to confirm) |
| `/save` | force save |
| `/perf` | toggle the performance HUD (§22.4) |
| `/overlay <name>` | toggle a debug overlay (§22.4) |
| `/audit map` | map audit (§22.7) |
| `/assets` | open the Placeholders tab (§22.6) |

## 22.4 Debug overlays

| Overlay | Shows |
|---|---|
| `noise` | expanding rings for every noise event, coloured by radius, with the source label |
| `vision` | AI vision cones (lit/dark range), current target lines |
| `ai` | AI state labels above heads, path lines, LOD tier colour |
| `loot` | container class and rolled tiers above every container |
| `light` | lit/dark per character, lightFactor |
| `zones` | evac area and zone volumes, floor volumes, wing volumes |
| `traverse` | AM tags and rail edges, planned paths |
| `hitbox` | hit parts and zone names, last shot rays and rewind positions |
| `stats` | live Stats v2 outputs for the selected player |
| `net` | remote calls per second, pose relay bytes per second |
| `perf` | FPS, server heartbeat, AI ms, physics ms, memory, active AI count |

## 22.5 Test Raiders (bots)

- Server-driven R15 characters (`MDL-CHR-090`) that count as players for the raid logic (squads, spawning, evac checks), never for saving.
- Behaviours (pick per bot or random): **Looter** (walks to containers, searches, moves on), **Camper** (holds a shop with the shutter down), **Hunter** (walks toward gunshots and shoots humans), **Evacuee** (heads to the exit during Red Alert), **Sleeper** (becomes a Sleeper at a set time and walks into the evac zone).
- Use: test Lockdowns alone, evac checks, AI budget at 12 players, and economy balance runs (§22.8).

## 22.6 Placeholders tab (asset requests)

- Lists every id in `AssetRegistry` (`25` §25.3) with: id, kind, description, owning stage, status (`Placeholder` or `Real`), and where it's used.
- Filters: by stage, by kind (ANIM, SFX, MUS, MDL, UI, VFX, TEX, VO, FUR), by status.
- **"Asset request" export:** a button builds a text list of all `Placeholder` ids for the current stage and the next one, in the format of `27`'s tables, and prints it to the log (copy to send to Mareux).
- At server start, the registry logs one summary line: `PLACEHOLDER count by kind`, and each first use of a placeholder logs `PLACEHOLDER <id> <description>` once.

## 22.7 Map audit

- `/audit map` walks the map and checks every tagged thing against `23` (counts and required attributes): shops (48) with a shutter and a service door each, containers by class and wing, Walker (60) and Crawler (12) spawn points, gates (4), terminals (3), generators (3), field workbenches (8), Med Safes (4), stockrooms (5), ladders, edge drops, windows, ledges (16), climbable box stacks (20+), crawl spaces (12), alarms (12), trap points (20), service elevators (2), escalators, evac areas and zones (2), light fixtures, glass panes by size.
- Prints `MAP ERRORS <n>` and each problem. Must be 0 before a stage that touches the map is accepted.

## 22.8 Automated checks

- `tools/check_numbers.py`: compares `src/shared/Config.luau` with `02` and the owning files, prints odds tables (wheel, rerolls, catalysts, crates) and economy checks (`26` P1). Must print `ERRORS 0`.
- `tools/check_assets.py`: every `ASSET-ID` used in `src/` exists in `27`; every id in `27` has a stage; reports placeholders by stage. Must print `ERRORS 0`.
- `tools/check_strings.py`: every `STR.*` used in `src/` exists in `Strings.luau`; every string in `21` §21.10 exists in `Strings.luau`. Must print `ERRORS 0`.
- **Unit tests** (TestEZ-style, run in Studio via the test runner script `tests/run.server.luau`): Stats compute, attribute generation (always 25, each 3–7), struggle check, inventory grid placement, loot rolling distributions (10,000 rolls within 1% of table), Flea tax and price limits, residency transactions (reserve/commit/rollback with simulated failures), receipt idempotency, wheel outcome distribution, matchmaker grouping.
- **Economy sim:** `/bots raid 10` with Looter bots for 50 raids (in Studio, accelerated clock ×4) logs haul values; median must be 6,000 MC ±15% (`02` §2.12).

## 22.9 Test places

- **HellRaiders-Dev** universe (separate from live): Arrival, Tower, Mall places. All S and F stages are built and tested here. DataStores in the dev universe are separate.
- **HellRaiders** (live) universe only from P1.

## 22.10 Stage checklists

- `tests/checklists/S{n}.md` and `F{n}.md`: the stage's acceptance list from `26`, copied with tick boxes, a date and the tester. A stage starts only when the previous checklist is fully ticked.
