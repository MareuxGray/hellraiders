# 26 · Build roadmap: from an empty project to a published game

Owner of: the order of work. **Stages S0–S17** build the complete raid loop up to the **two-player Alpha**. **Features F1–F13** add the tower, residency, flats, economy, social meta, monetisation, art and audio. **P1** is pre-launch and publishing. **L1–L4** are post-launch updates. Each step says what to read, what to build in order, the admin commands it adds, the assets it needs (**Asset requests**), how to see it working, and the acceptance list that must pass before the next step starts.

---

## 26.1 Rules for Claude while building

1. **One step at a time, in order.** Never start a step before the previous step's acceptance list is fully ticked in `tests/checklists/{step}.md`.
2. **Read first.** Read every listed blueprint file fully before writing code.
3. **Numbers only from Config, text only from Strings, assets only from AssetRegistry.** Missing number or text: copy it from the blueprint. Not in the blueprint: write the question in `docs/questions.md` and ask Mareux. Never invent.
4. **Server decides** everything listed in `25` §25.9. Clients send intentions and show results.
5. **Placeholders.** Every asset is used through `AssetRegistry` from the first line of code. Until the real asset arrives, the registry returns the placeholder (`25` §25.3) and logs it.
6. **Asset requests.** At the **start** of each step, post the step's Asset requests list (the `27` rows for that step, exported by the admin Placeholders tab, `22` §22.6) to Mareux in one message, then build with placeholders while waiting. Never block on an asset. When Mareux supplies an id, put it in `AssetRegistry` and check it in game.
7. **See it.** After each step, run the step's visual checks: play test through Studio MCP, run `tests/scenes/{step}_{shot}.luau` to set up the state, `screen_capture`, save to `tests/screens/{step}/{shot}.png`, and **look at every shot** before ticking it. Gameplay shots are from the player's camera. Overview shots use the Studio-only debug camera `tests/DebugCam.luau`.
8. **Tests.** Unit tests (`22` §22.8) run every step and all pass. `tools/check_numbers.py`, `tools/check_assets.py`, `tools/check_strings.py` print `ERRORS 0` whenever their inputs change. `/audit map` prints `MAP ERRORS 0` for any step that touches a map.
9. **Admin commands.** Each step adds the admin commands for its systems (listed per step; full list in `22` §22.3).
10. **Commit** after a step passes: "S{n}: {name}" (or F{n}, P1, L{n}), tag `s{n}-done`, update `docs/changelog.md`.
11. **Multiplayer tests:** Studio Test → Local Server with 2–4 players (12 where a step says so); Test Raiders (`22` §22.5) fill raids.
12. **Devices:** Studio Device Emulator for iPhone 14, a 3-year-old Android phone profile, iPad, 1080p desktop and Xbox. Each step that adds UI takes one shot per device. Real-device tests where listed.
13. **Conflicts:** shared values → `02`; the system's owning file for gameplay; anything paid → `19`; code → `25`; text → `21` §21.10; map positions → `23`.

---

## S0 · Project setup
**Read:** 00, 01, 02, 25, 27.
**Build in order:**
1. Repo MareuxGray/hellraiders with the layout in `25` §25.2. `aftman.toml`, Rojo, Wally packages, Selene, StyLua, `tools/precommit.sh`.
2. Create the **group-owned** HellRaiders-Dev universe with places **Arrival** (start place), **Tower**, **Mall** (`25` §25.1). Experience private. HTTP requests on, API access to Studio on, Allow third-party teleports off. Animations and audio are always uploaded by the group (`04` §4.9).
3. Copy `tools/` and `data/` from this blueprint into the repo. Run all three check scripts.
4. Write `Config.luau` completely from `02` and every owning file; `Strings.luau` completely from `21` §21.10; `AssetRegistry.luau` with every id from `27` (`id = 0`, stage, desc, placeholder size for MDL); `Items.luau`, `LootTables.luau`, `Recipes.luau`, `Contracts.luau`, `Achievements.luau`, `Names.luau` (from `data/`), `Epithets.luau`, `Vinyls.luau`, `MallShops.luau`, `Cosmetics.luau`, `Furniture.luau`, `Products.luau` (product names and prices from `19`, ids 0).
5. `Net.luau` with every channel in `25` §25.4. Bootstrap with place gating and every service in `25` §25.2 (empty `init`/`start`).
6. `docs/questions.md`, `docs/changelog.md`, `tests/run.server.luau`, `tests/checklists/`.
**Admin:** none yet.
**Asset requests:** none (S0 only registers ids).
**See it:** Studio output on each place shows the service start order and `PLACEHOLDERS …` counts, no errors.
**Accept:**
- [ ] Rojo syncs all three places; Selene and StyLua clean.
- [ ] All three check scripts print `ERRORS 0`.
- [ ] Every `27` id is in `AssetRegistry`; every `21` §21.10 string is in `Strings`.
- [ ] Each place starts with no errors and logs its services.

## S1 · Port movement, camera, stats and input
**Read:** 04, 05 §5.1–5.5, 21 §21.1–21.2, 22 §22.1–22.4, 25 §25.10.
**Build in order:**
1. Port `CameraRig`, `Gait`, `Body`, `Actions`, `MoveSpeed`, `Session.claim` and Stats v2 (Defs, Graph, Compute) per `25` §25.10, with the rule changes in `04` and `05` §5.1 (five attributes, pool 25, idle timers).
2. `Input` controller: every binding in `21` §21.2 for PC, gamepad and mobile (mobile buttons as placeholders `UI-MOB-*`), device switching, rebinding storage.
3. Locomotion states, sprint, crouch, roll, slide, slide tackle on a test dummy, turning, acceleration (`04` §4.2–4.5).
4. Camera rig values and every camera effect, with Shake and Reduce Motion (`04` §4.11).
5. `Services.Stats` 10 Hz with stamina (client sim + server mirror), hold breath, fear stub (`05` §5.4–5.5).
6. Admin menu framework (`22` §22.1–22.2) and the debug overlay host.
7. A grey-box test room in the Mall place (`tests/TestRoom` model): flat floor, ramps, a 4-stud rail, a 14-stud ledge, stairs.
**Admin:** `/god`, `/heal`, `/stamina`, `/fear`, `/attr`, `/noclip`, `/fly`, `/speed`, `/tp x y z`, `/perf`, `/overlay stats`.
**Asset requests:** <!-- ASSETS S1 -->86 assets, full rows in `27` Step S1. Models (3): MDL-CHR-037…039; Animations (26): ANIM-ACT-001…006, ANIM-MOV-001…015, ANIM-MOV-018…022; Sound effects (27): SFX-PLR-010…014, SFX-PLR-021…023, SFX-PLR-025…026, SFX-PLR-050…061, SFX-UI-001…005; UI images (30): UI-ADM-001, UI-FRM-001…004, UI-HUD-022, UI-MOB-001…024.<!-- /ASSETS -->
**See it:** shots of idle, walk, sprint, crouch walk, roll mid-frame, slide, aim walk, shoulder swap left, fear shake at 80 (overlay on), mobile layout on iPhone 14.
**Accept:**
- [ ] Ported Stats tests (48 + 31) pass, plus new five-attribute tests.
- [ ] Every movement number matches `02` §2.3 (check script).
- [ ] Feet don't glide at walk or run (ClipAnalyzer report attached).
- [ ] Roll and slide have no FOV pop; slide tackle ragdolls the dummy.
- [ ] Every input works on PC, gamepad and mobile emulator; rebinding saves.
- [ ] Admin menu opens only for admins; commands log.

## S2 · Sunshine Valley Mall grey-box
**Read:** 23 (all), 06 §6.2, §6.5–6.10 (for tags), 22 §22.7.
**Build in order:**
1. Build the full mall grey-box to `23` coordinates: floors, galleria, bridges, wings, 48 shops (shutter frames, storefront glass parts, back service doors), service corridors, stairs, escalators (static), service elevator shafts, ladders, rail-less lips, windows, gates A–D with lift boxes, both evac areas, roof.
2. Tag everything (`23`): wings, floors, shops, `Structural`/`Destructible`, `Glass` (size), `Traverse.*`, spawns, containers (as grey boxes with class attributes), terminals, generators, benches, Med Safes, stockrooms, trap points, alarms, barricadable frames, sound zones.
3. Streaming settings, base lighting (`23` §23.8), emergency light placeholders.
4. `/audit map` (`22` §22.7).
**Admin:** `/tp <wing|gate|exit|terminal|generator>`, `/audit map`, `/overlay zones`.
**Asset requests:** <!-- ASSETS S2 -->157 assets, full rows in `27` Step S2. Models (101): MDL-ENV-010, MDL-ENV-020…023, MDL-ENV-070, MDL-ENV-080, MDL-ENV-090, MDL-ENV-100…183, MDL-ENV-185, MDL-ENV-187…188, MDL-ENV-191…192, MDL-ENV-196, MDL-RAID-001, MDL-RAID-012…013; Sound effects (15): SFX-AMB-001…008, SFX-ENV-047, SFX-PLR-062…067; Visual effects (1): VFX-ENV-020; Textures (40): TEX-ENV-001…040.<!-- /ASSETS -->
**See it:** debug-camera overview of each floor; galleria from Second floor bridge; a shop with its service door; each gate lobby; both evac areas.
**Accept:**
- [ ] `/audit map` prints `MAP ERRORS 0`; container count 215–235.
- [ ] Every wing reachable on foot from every gate (walk test with `/noclip` off).
- [ ] Part count under 60,000; streaming on; Mall place memory under 25 MB for the map.
- [ ] Floor-to-floor 14 everywhere; all 8 rail-less lips placed.

## S3 · Raid flow skeleton, data and travel
**Read:** 03 (all), 25 §25.4–25.6, 14 §14.2 (routing basics only).
**Build in order:**
1. `Services.Data` with ProfileStore, schema v1, migrations, auto-save, release-before-teleport (`25` §25.5).
2. Arrival place: load profile, route to the Tower place (one public Tower server for now), connecting screen.
3. Tower place grey-box ground floor (`23` §23.9 positions, boxes) with the Transit Gates hall.
4. Raid state machine (`03` §3.2) in the Mall place with `/raid solo` from the tower: reserved server, teleport data, Loading (30 s cap), Deploy (lift box), Active with clock and wristwatch (`03` §3.4), RedAlert/Open/Sealed states on timers only (no evac logic yet), Results, teleport home.
5. Life states Human/Dead/Extracted (others stubbed), leaving early, disconnect and `pendingRaid` reconnect (`03` §3.6–3.7), teleport failure handling.
6. Results stub screen (`UI-RES-020`).
**Admin:** `/raid solo`, `/clock`, `/results`, `/seal`, `/profile dump`, `/profile wipe`, `/save`.
**Asset requests:** <!-- ASSETS S3 -->14 assets, full rows in `27` Step S3. Models (4): MDL-ARR-001, MDL-PLR-010, MDL-TWR-001, MDL-TWR-080; Animations (1): ANIM-ACT-020; Sound effects (3): SFX-RAID-001…002, SFX-TWR-001; Music (3): MUS-RAID-001, MUS-TWR-004, MUS-UI-020; Voice (1): VO-PA-001; UI images (2): UI-ARR-001, UI-RES-020.<!-- /ASSETS -->
**See it:** Arrival connecting screen; Transit Gates hall; lift interior at Deploy; wristwatch raised at 05:00; results screen.
**Accept:**
- [ ] Join → Arrival → Tower → `/raid solo` → Mall → results → Tower, three times in a row, profile saved each time.
- [ ] Killing the Mall server mid-raid follows the crash rule (`25` §25.5) on next join.
- [ ] Rejoining within 120 s puts you back in the same raid at your body.
- [ ] Two Studio clients can't load the same profile at once.

## S4 · Inventory, items and the loot reveal
**Read:** 11 (all), 02 §2.10–2.11, 21 §21.4.
**Build in order:**
1. Port `Services.Inventory`; extend to the raid layout (`11` §11.5): equip slots, pockets, Safe Pocket, Blueprint Slot, quick slots, backpack grid, weight.
2. Inventory UI (`UI-INV-001`) on PC, gamepad and mobile, with tooltips, drag, rotate, split, item actions, colour-blind shapes.
3. Item catalogue (`Items.luau`), item icons (placeholders), world items, pickup and drop (`11` §11.7).
4. Containers: classes, slot counts, loot rolling (`11` §11.6), hold-to-open, the face-down reveal with tier glow and timings (`11` §11.4), container panel, grabbing mid-reveal, search noise events (noise system stub).
5. Corpses and dropped backpacks (`11` §11.9).
6. Tower stash chest (grey box) and extraction to stash (from `/results` extracted) with the haul tally (`UI-RES-001`) and overflow (`15` §15.6).
**Admin:** `/give`, `/givebp`, `/clearinv`, `/clearstash`, `/loot reroll`, `/loot tier`, `/overlay loot`.
**Asset requests:** <!-- ASSETS S4 -->227 assets, full rows in `27` Step S4. Models (62): MDL-CON-001…013, MDL-FLT-011, MDL-ITM-001…004, MDL-ITM-010…032, MDL-ITM-040…050, MDL-ITM-060…064, MDL-ITM-094…095, MDL-PCK-001…003; Animations (6): ANIM-ACT-010…015; Sound effects (27): SFX-ENV-040…046, SFX-LOOT-001…006, SFX-LOOT-010…015, SFX-LOOT-020, SFX-PLR-036…037, SFX-UI-010…012, SFX-UI-020…021; Music (1): MUS-UI-001; UI images (129): UI-HUD-002, UI-HUD-023, UI-HUD-030, UI-ICO-002…031, UI-INV-001, UI-INV-010, UI-ITM-001…093, UI-RES-001; Visual effects (2): VFX-ITM-001, VFX-UI-001.<!-- /ASSETS -->
**See it:** container mid-reveal with an Epic tile glowing; a full backpack; the haul tally mid-count; mobile inventory.
**Accept:**
- [ ] 10,000-roll test: tiers per class within 1% of `11` §11.3.
- [ ] Reveal timings per tier match `02` §2.10; the glow colour is always the true tier.
- [ ] Items can't be duplicated by fast moves or by two players grabbing the same slot (test with 2 clients).
- [ ] Safe Pocket and Blueprint Slot survive death; everything else drops in a corpse.
- [ ] Overweight effects match `02` §2.3.

## S5 · Traversal, falls, ragdoll and pose relay
**Read:** 04 §4.6–4.10, 23 §23.6.
**Build in order:**
1. Port Traverse, RailPlanner, ProcPose: mantle, vault, vault into hang, hang moves, drop (`04` §4.6).
2. New: floor-edge drop with landing roll, ladders, window climb-through (needs broken glass; use `/glass break` stub), automatic step-over, mantle onto boxes (onto vs over), ledge climb-up, stacked boxes, prone and crawl with crawl spaces (`04` §4.2, §4.6).
3. Falls and fall damage, fractures from falls (`05` §5.6 stub), ragdoll (`Services.Ragdoll`) and get-up.
4. `RemotePose` and the AM relay (`04` §4.10). Measure bandwidth.
5. Fix clipping to under 0.2 studs worst frame.
**Admin:** `/overlay traverse`, `/overlay net`.
**Asset requests:** <!-- ASSETS S5 -->16 assets, full rows in `27` Step S5. Models (3): MDL-ENV-186, MDL-ENV-197…198; Animations (7): ANIM-ACT-060…062, ANIM-MOV-023…026; Sound effects (6): SFX-PLR-024, SFX-PLR-034…035, SFX-PLR-040…042.<!-- /ASSETS -->
**See it:** vault mid-frame seen from a second client; hang on a galleria rail; ladder climb; window climb; edge drop landing roll; standing on a crate after a mantle; ledge climb-up mid-frame; crawling under a collapsed slab and under a Half shutter.
**Accept:**
- [ ] Second client sees every traversal move matching the first client (side-by-side shots).
- [ ] Pose relay under 1.5 KB/s per character.
- [ ] Worst-frame penetration under 0.2 studs on the 10 test edges.
- [ ] Fall damage and fracture chances match `05` §5.6, and the landing roll halves 12–20 damage.
- [ ] Step-over, mantle onto a box, ledge climb-up and crawl work on every test edge, and a second client sees them correctly.
- [ ] Nothing over 7.5 studs is climbable; standing up inside a crawl space is blocked.

## S6 · Combat
**Read:** 07 (all), 02 §2.8, 11 §11.2 (weapons).
**Build in order:**
1. Weapon slots, swap, holster, holster visuals.
2. Aiming (no crosshair on PC; mobile and gamepad dot), firing, server hit validation with 250 ms rewind, damage by zone, armour.
3. Recoil and sway, reload, ammo types, attachments.
4. Hit feedback (no hitmarkers), damage direction arc.
5. Melee (light, heavy, durability), shove, stealth takedown stub (needs AI: dummy).
6. Port `Services.Throwables`; add Bottle, Brick, Noise Decoy, Molotov, UV Stun Flare, Smoke Can.
7. Aim assist on mobile and gamepad.
8. PvP rules: friendly fire off, spawn protection, kill credit, unprovoked-kill flag.
**Admin:** `/overlay hitbox`, `/give` for all guns and attachments.
**Asset requests:** <!-- ASSETS S6 -->140 assets, full rows in `27` Step S6. Models (25): MDL-ARM-001…003, MDL-GUN-001…005, MDL-THR-001…006, MDL-WPN-010…012, MDL-WPN-020…024, MDL-WPN-030…032; Animations (42): ANIM-HIT-001…004, ANIM-MEL-001…011, ANIM-THR-001…002, ANIM-WPN-001…006, ANIM-WPN-010…016, ANIM-WPN-020…025, ANIM-WPN-030…035; Sound effects (63): SFX-ENV-048, SFX-MEL-001…012, SFX-THR-001…009, SFX-WPN-001…032, SFX-WPN-040…048; UI images (1): UI-HUD-001; Visual effects (9): VFX-ENV-021, VFX-HIT-001, VFX-WPN-001…007.<!-- /ASSETS -->
**See it:** aim down sights with each gun; recoil pattern trace (overlay); molotov fire; mobile Fire button visible only while aiming.
**Accept:**
- [ ] Every gun's damage, RPM, mag, recoil and falloff match `02` §2.8 and `07`.
- [ ] Shots validated server-side at 150 ms simulated ping hit what the shooter saw.
- [ ] Squadmates take no bullet damage; molotov 50%.
- [ ] Throwables break glass (stub) and make the listed noise.

## S7 · Health, fear, medical, Downed and death
**Read:** 05 (all), 03 §3.5, §3.8.
**Build in order:**
1. Body zones, fractures, bleeding and blood trails, low-health effects (`05` §5.6).
2. Medical items with channelled use, healing others, tainted-item flag (no Sleepers yet) (`05` §5.7).
3. Fear: every scare source hook (some fire later), decay, boost, outputs (heartbeat, breathing, camera, tremor) (`05` §5.4).
4. Downed state, crawl, bleed-out, revive by squadmate or stranger (`05` §5.8).
5. Death: corpse, death screen (`UI-RES-010` without bounty button), death payout, permadeath stub (survivor retired flag).
**Admin:** `/hurt`, `/bleed`, `/fracture`, `/down`, `/kill`, `/revive`.
**Asset requests:** <!-- ASSETS S7 -->33 assets, full rows in `27` Step S7. Animations (9): ANIM-MED-001…007, ANIM-MOV-016…017; Sound effects (15): SFX-MED-001…007, SFX-PLR-027…033, SFX-PLR-038; Music (2): MUS-RAID-031, MUS-UI-002; UI images (6): UI-HUD-020…021, UI-HUD-024…025, UI-RES-010, UI-VFX-001; Visual effects (1): VFX-PLR-003.<!-- /ASSETS -->
**See it:** heavy bleed with trail; leg fracture limp; below-25 vignette; Downed crawl; revive from the reviver's view; death screen.
**Accept:**
- [ ] Every medical item's time and effect matches `05` §5.7; cancelling before 50% keeps the item.
- [ ] Fear boost fires once past 60 and re-arms per the rule.
- [ ] Downed bleed-out 30 s; extra 25 damage kills.

## S8 · Zombies, noise, light and stealth
**Read:** 08 (all), 06 §6.1, §6.3, 02 §2.5–2.6, §2.9.
**Build in order:**
1. `Services.Noise`: noise events, floor rules, multi-floor (`06` §6.1).
2. Light levels and flashlight (`06` §6.3), emergency lights.
3. `Services.AI`: Director with spawns, LOD and budget (`08` §8.5–8.6); Walker and Crawler state machines, senses, targeting (Sleeper rule stubbed), pathing.
4. Lunge (struggle stub: instant knock-down for now), hit reactions, deaths, corpses.
5. Stealth takedown on Walkers and Crawlers.
6. Reinforcements and blood-trail following.
7. Tune the fear loop with AI (`05` §5.4).
**Admin:** `/spawn`, `/ai freeze|resume|clear|cap`, `/noise`, `/overlay noise|vision|ai|light`, `/invisible`.
**Asset requests:** <!-- ASSETS S8 -->48 assets, full rows in `27` Step S8. Models (4): MDL-ZOM-001…004; Animations (12): ANIM-MEL-020…021, ANIM-ZOM-001…005, ANIM-ZOM-007, ANIM-ZOM-009…010, ANIM-ZOM-020…021; Sound effects (18): SFX-MEL-013, SFX-ZOM-001…006, SFX-ZOM-010…012, SFX-ZOM-020…021, SFX-ZOM-023, SFX-ZOM-025, SFX-ZOM-030…031, SFX-ZOM-040…041; Music (2): MUS-RAID-002…003; Textures (12): TEX-ZOM-001…012.<!-- /ASSETS -->
**See it:** a Walker turning to a thrown bottle (noise overlay); a chase in the dark with a flashlight; a takedown; a Crawler under a Half shutter (shutters stubbed).
**Accept:**
- [ ] 40 active AI at under 4 ms per server frame (micro-profiler capture).
- [ ] Dark halves sight to 15; crouch-walk behind a Walker at 3 studs isn't noticed.
- [ ] AI never path through Structural walls; no AI stuck for more than 10 s in a 20-minute bot raid.

## S9 · World interactables and power
**Read:** 06 §6.2, §6.4–6.10, 23 §23.6.
**Build in order:**
1. Shutters (Up/Half/Down, rules for AI and humans), doors, slam, barricades, wedges.
2. Glass break by every source, shards noise, display-case break-open, broken windows enabling climb-through.
3. Generators and power per wing: lights, escalators, shutter panel in Security, service elevators, alarms live, CCTV static.
4. Shootable lights.
5. Keycards, locked stockrooms, crowbar pry, Med Safes with codes and code notes.
6. Alarms (6 of 12 armed per raid) and trap points, disarm.
7. Destructible wall chunk sets (triggered by admin until the Supermutant exists).
**Admin:** `/power`, `/glass reset`, `/shutters`, `/doors reset`, `/lights out|on`.
**Asset requests:** <!-- ASSETS S9 -->65 assets, full rows in `27` Step S9. Models (17): MDL-ENV-030, MDL-ENV-040, MDL-ENV-060…062, MDL-ENV-184, MDL-ENV-189…190, MDL-ENV-193…195, MDL-ITM-080…084, MDL-ITM-090; Animations (10): ANIM-ACT-030, ANIM-ACT-070…078; Sound effects (35): SFX-ENV-001…004, SFX-ENV-010…039, SFX-MEL-014; Music (1): MUS-RAID-070; Visual effects (2): VFX-ENV-001, VFX-ENV-022.<!-- /ASSETS -->
**See it:** a hiding shop with the shutter at Half from inside; a storefront shattering; a powered wing lighting up; a stockroom opened by keycard; an alarm going off.
**Accept:**
- [ ] Every noise number in `06` matches (check script + noise overlay video).
- [ ] Walkers lose track behind a Down shutter unless noise came from inside in the last 10 s.
- [ ] Generator Service powers the elevators and Security panel only.
- [ ] Med Safe code differs per raid and matches its note.

## S10 · Struggle, infection, Sleepers, Ghosts and Stalker Mutants
**Read:** 09 §9.1–9.11, 08 §8.4, §8.8, 05 §5.7 (tainted items), 20 §20.1 (dead voice rule).
**Build in order:**
1. Struggle QTE (client bar, server check), paired clips, intercepts (`09` §9.2).
2. Bites, Sleeper state, incubation (Composure), own-screen view, symptoms for others (`09` §9.3–9.5).
3. AI ignoring Sleepers unless attacked (`08` §8.4).
4. Sabotage toolkit (alarm trip, taint, scent trail, Gesture hold) (`09` §9.6).
5. Cures, Suppressants, scanners and thermometer (`09` §9.7–9.9). Antidote fixed spawns.
6. Sleeper death → Sprinter AI + Ghost camera and tools (`09` §9.10).
7. Incubation end → Stalker Mutant kit (`09` §9.11).
8. Voice and chat rules for mutants and the dead (stubs for voice routing).
**Admin:** `/bite`, `/incubation`, `/cure`, `/struggle`, `/mutate stalker`, `/ghost`, `/taint`.
**Asset requests:** <!-- ASSETS S10 -->62 assets, full rows in `27` Step S10. Models (4): MDL-ITM-070…071, MDL-MUT-001, MDL-ZOM-005; Animations (18): ANIM-INF-001, ANIM-INF-010, ANIM-MUT-001…008, ANIM-STR-001…004, ANIM-ZOM-006, ANIM-ZOM-008, ANIM-ZOM-030…031; Sound effects (25): SFX-INF-001…004, SFX-INF-010…016, SFX-MUT-001…002, SFX-MUT-010…016, SFX-ZOM-022, SFX-ZOM-024, SFX-ZOM-050…052; Music (3): MUS-RAID-005, MUS-RAID-050…051; UI images (5): UI-GHO-001, UI-INF-001, UI-INF-010, UI-MUT-002, UI-STR-001; Visual effects (5): VFX-MUT-001…004, VFX-MUT-010; Textures (2): TEX-INF-001, TEX-ITM-030.<!-- /ASSETS -->
**See it:** struggle bar at struggle #2; Sleeper veins stage 3; a cough heard by a second client; Ghost thermal view; Stalker pounce.
**Accept:**
- [ ] Struggle zones and timings match `09` §9.2; 100 ms tolerance check passes at 200 ms ping.
- [ ] Nothing on any other client reveals a Sleeper (audit of every remote sent to non-owners).
- [ ] The Gesture hold looks identical for Humans and Sleepers.
- [ ] Antidote cures; Suppressant pauses 90 s; scanner and thermometer readings match the rules.

## S11 · The Janitor
**Read:** 08 §8.7, 24 §24.2 (Janitor motif), 06 §6.2 (shutters).
**Build in order:**
1. Janitor model, entry at 480 s, hunting rule, patrol, senses (`08` §8.7).
2. Audio tells (cart squeal, breathing, silent wind-up) and the PA crackle.
3. Grab (wind-up dodge window, roll escape), slam damage and fracture, shutter and barricade bashing.
4. UV Stun Flare stun; never enters the evac zone (stub volume).
5. Janitor motif music layer.
**Admin:** `/janitor spawn|despawn|goto`.
**Asset requests:** <!-- ASSETS S11 -->17 assets, full rows in `27` Step S11. Models (1): MDL-JAN-001; Animations (8): ANIM-JAN-001…008; Sound effects (7): SFX-JAN-001, SFX-JAN-010…015; Music (1): MUS-RAID-004.<!-- /ASSETS -->
**See it:** Janitor at the end of a dark corridor with flashlight; mid-grab wind-up; stunned by UV flare.
**Accept:**
- [ ] It always goes to the loudest recent noise within its rules.
- [ ] The wind-up is dodgeable with a roll every time in 10 tries; ACH-014 condition logs.
- [ ] It can't be killed by any damage.

## S12 · Red Alert Evac and extraction
**Read:** 10 §10.1–10.5, §10.8–10.10, 03 §3.2, §3.8.
**Build in order:**
1. Security terminals (lock until 600, activation, failsafe at 1020) and the PA lines.
2. Red Alert: sirens, strobes, horde surge, random exit, HUD marker and countdown, route signs.
3. Both exits: helicopter and freight lift sequences, evac areas and zones.
4. Open window, early depart, departure check (Humans extract; Sleeper Lockdown stubbed to "abort"), extraction cinematic, results.
5. Sealing and Results with full payouts and XP (`03` §3.8).
**Admin:** `/redalert`, `/evac open|depart`.
**Asset requests:** <!-- ASSETS S12 -->30 assets, full rows in `27` Step S12. Models (3): MDL-ENV-071, MDL-RAID-010…011; Animations (1): ANIM-ACT-031; Sound effects (10): SFX-RAID-004…006, SFX-RAID-010…011, SFX-RAID-020…021, SFX-RAID-033, SFX-RAID-040, SFX-ZOM-060; Music (2): MUS-RAID-010, MUS-RAID-030; Voice (7): VO-PA-002…004, VO-PA-010…013; UI images (4): UI-HUD-040…042, UI-HUD-090; Visual effects (3): VFX-ENV-010…012.<!-- /ASSETS -->
**See it:** Red Alert galleria with strobes; the HUD marker; helicopter landing; freight lift rising; haul tally after extract.
**Accept:**
- [ ] Only one Red Alert per raid; terminals go dark after.
- [ ] Early depart only when every living Human and Sleeper is inside.
- [ ] Raid always ends by 1305 s.

## S13 · Lockdown and the Supermutant
**Read:** 10 §10.5–10.7, 09 §9.12–9.14, 06 §6.6.
**Build in order:**
1. Departure check finds a Sleeper → Lockdown: doors slam, area locks, transformation, Lockdown theme (`10` §10.6).
2. Supermutant Brute kit, HP formula, surface running, Screech outlines, hold-breath counter, weaknesses.
3. Destructible walls broken by Charge and Slam; shutters and barricades.
4. Reopen and final departure; second failure ends the raid (`10` §10.7).
5. Supermutant death, Trophy drop, revive window (prompt UI with **admin-only** grant until F11 wires the product; tokens stored).
6. Mutant Rep rewards (`09` §9.15).
**Admin:** `/lockdown`, `/reopen`, `/mutate super [variant]`, `/token`.
**Asset requests:** <!-- ASSETS S13 -->44 assets, full rows in `27` Step S13. Models (3): MDL-ENV-050, MDL-ITM-051, MDL-MUT-010; Animations (11): ANIM-MUT-010…020; Sound effects (20): SFX-ENV-005, SFX-MUT-003…005, SFX-MUT-020…032, SFX-RAID-030…032; Music (2): MUS-RAID-020…021; Voice (2): VO-PA-020…021; UI images (2): UI-MUT-001, UI-MUT-010; Visual effects (4): VFX-ENV-005, VFX-MUT-011…013.<!-- /ASSETS -->
**See it:** Lockdown slam from inside the cage; Supermutant transformation; Charge through a shop wall; Screech outline from the Supermutant view; Reopen.
**Accept:**
- [ ] A Sleeper inside at departure always triggers Lockdown; only one Supermutant at a time.
- [ ] HP formula matches `09` §9.12 for 1–8 humans.
- [ ] Holding breath and staying still hides you from Screech.

## S14 · In-raid crafting, survivors and progression basics
**Read:** 12 §12.1–12.2, 13 §13.1–13.4, §13.7 (Memorial only), 03 §3.8–3.9.
**Build in order:**
1. Inventory crafting and field workbenches with every recipe (`12` §12.1).
2. Blueprint items, Blueprint Slot behaviour, learning at a grey-box workbench in the tower.
3. Survivors: generation (25 points, 3–7), names, looks, Survivor Draft (`UI-SUR-001`), permadeath retirement, Memorial Wall list (`13` §13.1–13.2, §13.7).
4. XP, level curve and level rewards up to level 5 (`13` §13.4).
5. Orientation Run (`03` §3.9).
**Admin:** `/survivor new`, `/xp`, `/level`, `/orientation`.
**Asset requests:** <!-- ASSETS S14 -->58 assets, full rows in `27` Step S14. Models (36): MDL-CHR-001…036; Animations (1): ANIM-ACT-040; Sound effects (8): SFX-CRF-001…005, SFX-UI-030, SFX-UI-040, SFX-UI-080; Music (2): MUS-RAID-060, MUS-UI-003; Voice (8): VO-TUT-001…008; UI images (3): UI-HUD-050, UI-INV-020, UI-SUR-001.<!-- /ASSETS -->
**See it:** Survivor Draft with 3 cards; crafting a Molotov; field bench panel; Orientation struggle at 50% zone.
**Accept:**
- [ ] 10,000 generated survivors all total 25 with each attribute 3–7.
- [ ] Orientation Run can't be failed and takes about 4 minutes.
- [ ] Blueprint learned is permanent; second blueprint drops on death.

## S15 · Squads, matchmaking and comms
**Read:** 20 (all), 03 §3.3, 14 §14.12.
**Build in order:**
1. Parties in the tower (one instance for now), party panel, leader, Stick Together.
2. Deploy panel, Ready, Fill Squad, the MemoryStore matchmaker with leader election, raid launch to a reserved server, `RaidFound` messaging (`20` §20.8).
3. Spawning squads across gates A–D (`03` §3.3).
4. Squad armbands, squad tags, Downed tags, squad list.
5. Quick lines, pings, emotes and Gesture, text channels, voice routing (proximity, squad radio, dead muted, mutants muted).
6. Leaving early and reconnect with squads.
**Admin:** `/queue status`, `/bots queue`, `/bots raid`.
**Asset requests:** <!-- ASSETS S15 -->75 assets, full rows in `27` Step S15. Models (2): MDL-CHR-090, MDL-PLR-011; Animations (4): ANIM-EMO-001…004; Sound effects (6): SFX-COM-001…002, SFX-COM-005, SFX-TWR-003, SFX-UI-050…051; Music (1): MUS-TWR-002; Voice (48): VO-QL-001…048; UI images (14): UI-COM-001…002, UI-COM-010, UI-DEP-001…003, UI-HUD-010, UI-HUD-080…085, UI-TWR-020.<!-- /ASSETS -->
**See it:** deploy panel with a 2-player party; "Raid found"; a stranger's grey armband next to a squadmate's coloured one; quick-line bubble; ping on an item.
**Accept:**
- [ ] Solo, Duo and Trio pools launch at max size, or 4+ after 45 s (with injected tickets).
- [ ] Two parties in two Tower servers land in the same raid.
- [ ] Strangers never see squad tags, pings or names.
- [ ] Dead players can't be heard by the living.

## S16 · Basic tower and flat
**Read:** 14 §14.3 (Ground only), 15 §15.1–15.3, §15.6, 21 §21.6–21.8, 16 §16.2 (Quartermaster and Pawnbroker only).
**Build in order:**
1. Tower ground floor at `23` §23.9 positions (grey box) with the Quartermaster and Pawnbroker working (`16` §16.2).
2. One **Bunk Studio** interior per player in the interior bays (no residency yet: every player gets "their" Bunk door in a single test corridor).
3. Fixed fixtures: Stash Chest, Workbench (learn, craft with queue, repair), Survivor Terminal (Draft), Flat Terminal (stats only), Memorial Wall, Overflow Crate.
4. Tower HUD, settings menu, first-time hints.
5. Measure network and performance budgets (`25` §25.7) in a 12-player raid with bots.
**Admin:** `/mc`, `/flat reset`.
**Asset requests:** <!-- ASSETS S16 -->55 assets, full rows in `27` Step S16. Models (14): MDL-FLT-001, MDL-FLT-010, MDL-FLT-012…017, MDL-NPC-002…003, MDL-TWR-010…012, MDL-TWR-020; Sound effects (5): SFX-FLT-001, SFX-FLT-006…008, SFX-UI-060; Music (1): MUS-TWR-001; Voice (20): VO-NPC-011…030; UI images (15): UI-FLT-001, UI-FLT-010, UI-FLT-020, UI-HUD-100…105, UI-HUD-110, UI-ICO-001, UI-SET-001, UI-SET-010, UI-SET-020, UI-VEN-001.<!-- /ASSETS -->
**See it:** the tower atrium; a Bunk Studio with stash open; workbench queue; settings on mobile.
**Accept:**
- [ ] Buy ammo, deploy, extract, sell at the Pawnbroker, see MC change.
- [ ] Workbench crafts finish while offline (test with clock offset).
- [ ] Budgets met or listed in `docs/questions.md` with numbers.

## S17 · Two-player Alpha
**Read:** 01 §1.6–1.7, 22 §22.5, §22.8.
**Build in order:**
1. Full raid loop with two real players plus Test Raiders: deploy together, loot, get bitten, evac, betray (Lockdown) or extract, keep loot in the saved stash and basic flat.
2. Economy sim (50 bot raids): tune container tier weights only until median haul is 6,000 MC ±15%.
3. Bug bash: every acceptance item from S1–S16 re-run.
4. Real-device test: one phone, one PC, one gamepad.
**Admin:** none new.
**Asset requests:** <!-- ASSETS S17 -->none.<!-- /ASSETS -->
**See it:** a two-player session video: deploy, loot, struggle, Red Alert, one Lockdown, one extract.
**Accept (Alpha gate):**
- [ ] Two real players complete 5 raids in a row with no blocking bugs.
- [ ] At least one Lockdown and one clean extract happen naturally.
- [ ] Median haul in range; AI and network budgets met.
- [ ] Mareux plays it and signs off in `tests/checklists/S17.md`.

---

## F1 · Towers and residency
**Read:** 14 (all), 25 §25.6.
**Build in order:** Arrival routing with launchData and presence; tower records and the index; live instances and Annexes; residency transactions (two-phase); new player assignment near friends; all tower floors, lifts, corridors, flat doors, NPCs, ambience, PA, power flicker, Tower Standing board; visiting friends' towers; parties across towers; read-only fallback.
**Admin:** `/tower info|fill|annex`.
**Asset requests:** <!-- ASSETS F1 -->94 assets, full rows in `27` Step F1. Models (23): MDL-NPC-001, MDL-NPC-020, MDL-NPC-030…041, MDL-TWR-013…014, MDL-TWR-018…019, MDL-TWR-021…022, MDL-TWR-024, MDL-TWR-030, MDL-TWR-090; Animations (20): ANIM-NPC-001…020; Sound effects (21): SFX-TWR-002, SFX-TWR-020…037, SFX-TWR-040…041; Music (1): MUS-TWR-003; Voice (26): VO-NPC-001…010, VO-PA-030…045; UI images (3): UI-TWR-001, UI-TWR-010, UI-TWR-030.<!-- /ASSETS -->
**See it:** lift floor picker; a Low Block corridor with the mugging scene; Penthouse corridor; Annex join notice.
**Accept:**
- [ ] 64 residents across simulated joins never double-book a slot (fault-injection test: kill servers mid-transaction).
- [ ] Annex opens at 46 players; friends routed to the right instance.
- [ ] A visitor raids from the tower and returns per Stick Together.

## F2 · Flat tiers and customisation
**Read:** 15 (all), 14 §14.8, 19 §19.5 (furniture prices).
**Build in order:** Executive and Penthouse templates; upgrades with entitlement vs occupied slot; waitlists with 48 h holds; rent with auto-pay and perk pause; build mode with every placement rule; furniture catalogue and Second-Hand Sal; displays (mounts, pedestals, case, trophy mounts); functional perks; door settings, visiting and knocking; furniture moving between flats; Furniture Storage.
**Admin:** `/entitle`, `/rent`.
**Asset requests:** <!-- ASSETS F2 -->141 assets, full rows in `27` Step F2. Models (44): MDL-FLT-002…003, MDL-FLT-020…023, MDL-FUR-001…036, MDL-NPC-007, MDL-TWR-017; Animations (2): ANIM-TWR-020…021; Sound effects (4): SFX-FLT-002…005; Music (8): MUS-FLT-001…005, MUS-FLT-010…012; Voice (6): VO-NPC-073…078; UI images (57): UI-FLT-030, UI-FUR-001…056; Textures (20): TEX-FLR-001…008, TEX-WAL-001…012.<!-- /ASSETS -->
**See it:** each tier furnished; build mode with a red invalid ghost; weapon wall with 3 guns; a visitor inspecting a display.
**Accept:**
- [ ] Furniture saves and reloads at the same coordinates; overflow to storage on downgrade.
- [ ] Perks work only in the occupied flat and pause on unpaid rent.

## F3 · Migration
**Read:** 14 §14.10–14.11, §14.15.
**Build in order:** Move-in flow with 120 s reservations and the Move Ticket fallback (admin grant until F11 wires Robux); full-tower waitlists; moving at a lower tier; 24 h cooldown; inactivity relocation to Quiet towers; Homecoming Ticket.
**Admin:** `/movein`, `/inactive`, `/token Move`.
**Asset requests:** <!-- ASSETS F3 -->2 assets, full rows in `27` Step F3. Sound effects (1): SFX-FLT-009; Visual effects (1): VFX-TWR-001.<!-- /ASSETS -->
**See it:** Concierge vacancies panel; moving-boxes scene; relocation notice at Arrival.
**Accept:**
- [ ] Two players racing for the last slot: one succeeds, the other is told before any purchase prompt.
- [ ] A receipt after expiry grants a Move Ticket.

## F4 · Economy and the Flea
**Read:** 16 §16.1–16.3, §16.6, 13 §13.5 (Merchant Score).
**Build in order:** full vendor rules and loyalty; mail system and Mail Room; the Flea (access gates, listings, fees, tax, limits, purchase limits, barter, appraisal, payouts, history, expiry); Paid-origin trading rules (policy stub `/policy`).
**Admin:** `/flea seed|clear`, `/rep`, `/policy`.
**Asset requests:** <!-- ASSETS F4 -->14 assets, full rows in `27` Step F4. Models (5): MDL-NPC-006, MDL-TWR-015, MDL-TWR-050…052; Sound effects (1): SFX-UI-070; Voice (4): VO-NPC-047…050; UI images (4): UI-FLEA-001…003, UI-MAIL-001.<!-- /ASSETS -->
**See it:** Flea browse with filters; barter panel; appraisal graph; mail with a payout.
**Accept:**
- [ ] Two buyers on one listing: exactly one gets it; the seller is paid once (fault injection).
- [ ] Tax matches `16` §16.3 for MS 0/20/60/100 with and without pass and desk.

## F5 · Insurance and repossession
**Read:** 16 §16.4–16.5.
**Build in order:** insurance at the Transit Gates (MC; Robux stub), return mail after 60 minutes, "taken by a raider" check; repossession holds, MC reclaim (Robux stub).
**Asset requests:** <!-- ASSETS F5 -->2 assets, full rows in `27` Step F5. UI images (2): UI-DEP-010, UI-MAIL-010.<!-- /ASSETS -->
**Accept:**
- [ ] Insured items extracted by another player never return; others return after 60 min (−15% with desk).
- [ ] Repossession only lists uninsured, unextracted, non-Relic items for 24 h.

## F6 · Bounties and roles
**Read:** 17 (all), 07 §7.7.
**Build in order:** heat, contributions (death screen button and terminals), the Most Wanted Wall with viewport renders, Dogtags and claims, Claim Tickets, role titles (MC; Robux stub), Dossier, proximity tick, Bodyguard escort contracts and VIP radio, Hire Board, Vigilante justice and sense, radio bounty call, expiry and refunds, anti-abuse checks.
**Admin:** `/bounty`, `/title`.
**Asset requests:** <!-- ASSETS F6 -->39 assets, full rows in `27` Step F6. Models (4): MDL-ITM-091, MDL-NPC-005, MDL-TWR-060…061; Animations (1): ANIM-ACT-050; Sound effects (8): SFX-BNT-001…002, SFX-BNT-010…011, SFX-BNT-020, SFX-BNT-030, SFX-COM-010, SFX-RAD-001; Voice (18): VO-NPC-037…046, VO-RAD-010…016, VO-RAD-020; UI images (8): UI-BNT-001…002, UI-BNT-010, UI-BNT-020, UI-BNT-030, UI-BNT-040, UI-HUD-060…061.<!-- /ASSETS -->
**See it:** the wall rotating cards; harvesting a Dogtag; Dossier panel; escort VIP marker.
**Accept:**
- [ ] No name of a target, contributor or hunter appears anywhere.
- [ ] Friends and party members can't claim each other's bounties.

## F7 · World items, Relics and vinyls
**Read:** 18 (all).
**Build in order:** Relic records, the world pool and claims, Loading placement, history and notices; Name Tags and engraving; Pressing Booth (Blank Vinyl path; Robux stub), Keeper and Drifter; flat and Drain jukeboxes; boombox in raids; vinyl catalogue placeholders.
**Admin:** `/relic make|pool|place`.
**Asset requests:** <!-- ASSETS F7 -->79 assets, full rows in `27` Step F7. Models (8): MDL-ITM-065…066, MDL-ITM-092…093, MDL-NPC-004, MDL-TWR-016, MDL-TWR-070…071; Animations (3): ANIM-ACT-055, ANIM-FLT-010, ANIM-TWR-010; Sound effects (5): SFX-REL-001, SFX-REL-010, SFX-REL-020…022; Music (42): MUS-TWR-005, MUS-UI-010, MUS-VIN-001…040; Voice (6): VO-NPC-031…036; UI images (15): UI-REL-001, UI-REL-010, UI-REL-020, UI-VIN-001…012.<!-- /ASSETS -->
**See it:** a Relic reveal with story card; a history card; the Drain jukebox "Now playing".
**Accept:**
- [ ] A lost Relic reappears in a later raid and transfers on extract; previous owner gets the notice.
- [ ] A crashed raid server's claimed Relics return to the pool after 30 minutes.

## F8 · Blueprint Wheel, Fixed Trade-up and Exotics
**Read:** 12 §12.2–12.6, 19 §19.2.
**Build in order:** Exotic models; flat workbench full tiers and queues; Black Market roof grey-box with Vex; the wheel with odds panel, MC spins (Robux stub), pity counter; Fixed Trade-up; restricted-player path.
**Admin:** `/wheel force`, `/givebp`.
**Asset requests:** <!-- ASSETS F8 -->25 assets, full rows in `27` Step F8. Models (7): MDL-ARM-004, MDL-GUN-006…007, MDL-NPC-010, MDL-TWR-023, MDL-TWR-040, MDL-WPN-025; Animations (1): ANIM-TWR-001; Sound effects (4): SFX-TWR-010, SFX-UI-061…063; Music (1): MUS-UI-011; Voice (10): VO-NPC-051…060; UI images (2): UI-SHOP-020, UI-WHL-001.<!-- /ASSETS -->
**Accept:**
- [ ] 100,000 simulated spins match the odds within 0.5%.
- [ ] Restricted players never see spin buttons.

## F9 · Supermutant variants and catalysts
**Read:** 09 §9.12, 19 §19.7, §19.11.
**Build in order:** Banshee, Creeper, Juggernaut kits; The Lab and Dr. Halloran; catalysts (Blood Moon, Blackout, High-Roller Supply Drop) with odds panels, HUD icon and live odds; matchmaker catalyst separation and restricted filter; Sully's stall.
**Admin:** `/catalyst`.
**Asset requests:** <!-- ASSETS F9 -->29 assets, full rows in `27` Step F9. Models (8): MDL-CON-020, MDL-MUT-011…013, MDL-NPC-011…012, MDL-TWR-041…042; Sound effects (3): SFX-MUT-033…035; Music (1): MUS-RAID-040; Voice (12): VO-NPC-061…072; UI images (3): UI-CAT-001, UI-HUD-070, UI-LAB-001; Visual effects (2): VFX-CAT-001…002.<!-- /ASSETS -->
**Accept:**
- [ ] Two catalyst squads never share a raid; restricted players never join catalyst raids.

## F10 · Progression and retention
**Read:** 13 (all), 28 §28.1–28.4.
**Build in order:** full level rewards; reputations; Mutant Track; Collection Book; contracts (starter, daily, weekly, reroll); 40 achievements and trophies; tracked stats panel; tower leaderboard rewards; weekly Mall Conditions; Relic and craft notices; first-time hints complete.
**Admin:** `/contracts`, `/ach`.
**Asset requests:** <!-- ASSETS F10 -->72 assets, full rows in `27` Step F10. Models (20): MDL-FLT-090, MDL-MUT-020…025, MDL-TRO-001…012, MDL-TWR-062; Sound effects (4): SFX-MUT-040, SFX-UI-031, SFX-UI-041…042; UI images (47): UI-ACH-001…040, UI-COL-001, UI-NPF-001…006; Visual effects (1): VFX-MUT-020.<!-- /ASSETS -->
**Accept:**
- [ ] Every achievement unlocks by its condition in a scripted test.
- [ ] Daily reset at 00:00 UTC; weekly Monday 00:00 UTC.

## F11 · Shop, monetisation and compliance
**Read:** 19 (all), 25 §25.5 (receipts), 22 §22.3 (shop commands).
**Build in order:** `Services.Shop` with ProcessReceipt and tokens; wire every Robux stub from S13, F3, F5, F6, F7, F8, F9; cosmetics with previews and the gunsmith; Evac Pass; Mall VIP; Merchant Tax Pass; stash expansions; Mall Cash bundles; gifting; PolicyService gating everywhere; odds tables generated and checked; referral rewards (`20` §20.9).
**Admin:** `/receipt`, `/pass tier`, `/policy`.
**Asset requests:** <!-- ASSETS F11 -->320 assets, full rows in `27` Step F11. Models (41): MDL-CHM-001…012, MDL-FLT-091…099, MDL-OUT-001…020; Animations (8): ANIM-EMO-005…012; Voice (64): VO-VOX-001…064; UI images (135): UI-COS-001…130, UI-FLT-040, UI-PASS-001, UI-PASS-010, UI-SHOP-001, UI-SHOP-010; Visual effects (18): VFX-DTH-001…006, VFX-FLR-001…006, VFX-MFX-001…006; Textures (54): TEX-FIN-001…024, TEX-STK-001…030.<!-- /ASSETS -->
**Accept:**
- [ ] Every product grants exactly once under duplicate receipts and server crashes.
- [ ] Every paid random item shows odds before purchase; restricted fallbacks work for each.
- [ ] No pop-up sells anything except the Second Wind prompt.

## F12 · Art pass
**Read:** 23 §23.8, 27 (all MDL, TEX, VFX, UI rows), 21 §21.9.
**Build in order:** replace every MDL, TEX, VFX and UI placeholder with the supplied assets in this order: characters and zombies, weapons and items, mall kit and wings, tower and flats, furniture and cosmetics, UI art, VFX; lighting pass per wing; performance re-check.
**Asset requests:** <!-- ASSETS F12 -->none.<!-- /ASSETS -->
**Accept:**
- [ ] Placeholders tab shows 0 MDL/TEX/VFX/UI placeholders.
- [ ] Performance budgets still met on the phone profile.

## F13 · Animation, audio pass and polish
**Read:** 04 §4.9, 24 (all), 21 §21.7.
**Build in order:** replace every ANIM, SFX, MUS and VO placeholder; music layers and ducking; occlusion; NPC voice lines and subtitles; accessibility options complete; mobile layout polish; tutorial hint timing; bug bash.
**Asset requests:** <!-- ASSETS F13 -->none.<!-- /ASSETS -->
**Accept:**
- [ ] Placeholders tab shows 0 placeholders of any kind.
- [ ] Every clip passes ClipAnalyzer; every sound normalised.

---

## P1 · Pre-launch and publishing
**Read:** 19 §19.2, 25 §25.11, 28 (all).
**Build in order:**
1. Live universe (group-owned), copy places, live product ids into `Products.luau`, live DataStores clean.
2. Maturity & Compliance Questionnaire (paid random items, violence, voice); private server price; VIP subscription price; Evac Pass Season 1.
3. Store page: title, description, icon, thumbnails, trailer (`28` §28.6).
4. Analytics funnels verified; audit log working; `/ban`; data erasure tool.
5. Vinyl catalogue licences confirmed; voice cast script for NPC and PA lines.
6. 48-hour soak test with bots across 3 Tower servers and 10 Mall servers; DataStore and MemoryStore budget checks.
7. Closed test with 20 players (friends), then public.
**Asset requests:** <!-- ASSETS P1 -->7 assets, full rows in `27` Step P1. Music (1): MUS-SEA-001; UI images (6): UI-STO-001, UI-STO-010…014.<!-- /ASSETS -->
**Accept:**
- [ ] `ERRORS 0` on all checks; 0 placeholders; questionnaire submitted.
- [ ] Soak test: no data loss, no duplicated items, no stuck tower records.
- [ ] Mareux approves going public.

## L1–L4 · Post-launch updates
Planned in `28` §28.5. Each update is planned as its own step list in a new file `29-update-L{n}.md` written when it starts.
