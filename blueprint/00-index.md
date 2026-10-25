# HellRaiders Blueprint · Index

Version 1.0 · 25 October 2026 · written for Claude to build from.
Baseline: the Hell Raiders design review and every decision Mareux made in it ([design-review.md](design-review.md)). If something isn't in these files, it isn't in the game. Never invent behaviour, numbers or text; ask Mareux through `docs/questions.md`.

---

## Start here

1. Read `01-overview.md` (pitch, pillars, names, glossary, Stages vs Features).
2. Read `02-shared-values.md` (the numbers every system shares).
3. Follow `26-build-roadmap.md` one step at a time (S0 → S17 two-player Alpha, then F1 → F13, then P1). Each step lists the files to read, the admin commands to add, the **Asset requests** to send Mareux, what to screenshot, and the acceptance list.

## Which file wins

Shared values → `02`. Gameplay → the system's owning file. Anything paid → `19`. Code structure → `25`. On-screen text → `21` §21.10. Map positions → `23`. Asset ids → `27` (generated from `tools/assets_master.py`).

## Files

| File | What it covers |
|---|---|
| [01-overview.md](01-overview.md) | How to use the blueprint, pitch, pillars, tone, audience, raid at a glance, Stages and Features, names, glossary, research grounding |
| [02-shared-values.md](02-shared-values.md) | Every shared number with its Config key: players and servers, raid timing, movement, attributes, noise, vision, struggle and infection, combat, enemies, inventory, tiers and colours, economy anchors, settings |
| [03-raid-flow.md](03-raid-flow.md) | Places and travel, raid server states, spawning, the raid clock, life states, leaving, disconnects, results and payouts, Orientation Run, edge cases |
| [04-movement-and-camera.md](04-movement-and-camera.md) | Single-owner rule, locomotion, turning, roll, slide and tackle, traversal (Adaptive Motions), falls, ragdoll, animation pipeline, pose relay, camera rig and effects, mutant movement |
| [05-stats-fear-health.md](05-stats-fear-health.md) | Stats v2 port, attributes and derived values, fear, stamina and hold breath, body zones, fractures, bleeding, medical items, tainted items, Downed and revive |
| [06-stealth-noise-light-environment.md](06-stealth-noise-light-environment.md) | Noise events, hiding behind shutters, light and flashlights, generators and power, glass, destructible walls, doors, barricades, wedges, keycards, Med Safes, alarms and traps, elevators, climbing between floors |
| [07-combat.md](07-combat.md) | Weapon slots, aiming (no crosshair), firing and validation, recoil, reload, ammo, attachments, damage, PvP rules, hit feedback, melee, shove, takedowns, throwables, aim assist |
| [08-enemies-ai.md](08-enemies-ai.md) | Walkers, Crawlers, Sprinters, The Janitor, AI states, senses, targeting, pathing and budget, spawns and reinforcements, reaction clips |
| [09-infection-sleepers-mutants.md](09-infection-sleepers-mutants.md) | Struggle QTE, bites, the Sleeper, symptoms, sabotage, cures, suppressants, scanners, Sprinter and Ghost Guidance, Stalker Mutant, Supermutant and variants, Mutate Now, Second Wind, mutant rewards |
| [10-evac-extraction-lockdown.md](10-evac-extraction-lockdown.md) | Security terminals, Red Alert, the two exits, open window, early depart, departure check, Lockdown, Reopen, sealing, extraction cinematic, sound and VFX |
| [11-loot-containers-inventory.md](11-loot-containers-inventory.md) | Tiers, the full item catalogue, containers and loot tables, the ARC-style reveal, raid inventory, loot rolling, pickup, extraction, corpses |
| [12-crafting-blueprints-wheel.md](12-crafting-blueprints-wheel.md) | In-raid recipes, blueprints and learning, Exotic models, flat workbench, armour repair, the Blueprint Wheel with odds and compliance, Fixed Trade-up |
| [13-survivors-progression.md](13-survivors-progression.md) | Survivors and permadeath, Survivor Draft, rerolls with odds, Rebalance, levels and unlocks, reputations, Mutant Track, Memorial Wall, Collection Book, contracts, 40 achievements, tracked stats |
| [14-tower-residency-migration.md](14-tower-residency-migration.md) | The Dredd-style tower: places and routing, layout, tower shards, live instances and Annexes, residency transactions, flats per tower, upgrades, waitlists, rent, visiting, paid Move-in, inactivity relocation, parties, leaderboard, NPCs, edge cases |
| [15-flats-customisation.md](15-flats-customisation.md) | Flat interiors and tiers, fixtures, functional perks, displays, Overflow Crate, build mode, visiting, furniture catalogue |
| [16-economy-flea-insurance.md](16-economy-flea-insurance.md) | Mall Cash, vendors, the Flea (P2P trading hub), technical design, insurance, repossession, mail |
| [17-bounties-roles.md](17-bounties-roles.md) | Anonymous bounties, the Most Wanted Wall, Dogtags, Claim Tickets, role titles (Bounty Hunter, Bodyguard, Mercenary, Vigilante), radio calls, expiry, anti-abuse |
| [18-world-items-relics-vinyls.md](18-world-items-relics-vinyls.md) | "Nothing is ever lost": Relic records, the world pool, named gear, vinyl pressing (Keeper and Drifter), history cards and notices, jukeboxes, boombox, music catalogue |
| [19-shop-monetisation.md](19-shop-monetisation.md) | Where things are sold, paid random item compliance, receipts and tokens, every product and price, cosmetics, Evac Pass, catalysts, passes, Mall Cash bundles, gifting, Supermutant variants, Mall VIP |
| [20-social-matchmaking.md](20-social-matchmaking.md) | Voice routing, quick lines, pings, squad identification, emotes, text chat, parties, the matchmaker, invites and referrals, private servers, safety |
| [21-hud-ui-controls-strings.md](21-hud-ui-controls-strings.md) | Every control binding (PC, gamepad, mobile, each context), raid HUD, inventory screens, screen catalogue, tower HUD, settings, prompts and hints, UI style, every string |
| [22-admin-testing.md](22-admin-testing.md) | Admin access, the admin menu and every command, debug overlays, Test Raider bots, the Placeholders tab, map audit, automated checks, test places, checklists |
| [23-maps.md](23-maps.md) | Sunshine Valley Mall: floors, wings, shops, gates, spawns, evac areas, every fixed point with coordinates, containers per wing, lighting; High-Rise Tower layout; Arrival |
| [24-audio-music.md](24-audio-music.md) | Mix, adaptive music, ambience and sound zones, PA and radio, 3D rules, the full SFX, voice and music lists |
| [25-tech-architecture.md](25-tech-architecture.md) | Repo and tooling, code layout and services, AssetRegistry and placeholders, networking, profile schema, every DataStore and MemoryStore, performance budgets, analytics, security, porting the existing place, moderation |
| [26-build-roadmap.md](26-build-roadmap.md) | Rules for Claude, S0–S17 (to the two-player Alpha), F1–F13, P1, L1–L4, each with reads, build order, admin commands, Asset requests, screenshots and acceptance |
| [27-assets.md](27-assets.md) | Every asset (1,951) by step with id, description and placeholder size. Generated. |
| [28-live-ops-retention-virality.md](28-live-ops-retention-virality.md) | Retention hooks, session pacing, weekly Mall Conditions, seasons, L1–L4, store page, clip moments, launch plan and KPIs, research gap check (§28.9) |
| [tools/assets_master.py](tools/assets_master.py) | Master asset list (edit this, not 27) |
| [tools/build_assets.py](tools/build_assets.py) | Regenerates 27 and the Asset requests in 26 |
| [tools/check_assets.py](tools/check_assets.py) | Every asset id used in the blueprint (or `src/`) exists. Must print `ERRORS 0`. |
| [tools/check_numbers.py](tools/check_numbers.py) | Blueprint maths (raid length, tower slots, loot weights, container totals, level curve) and odds tables (survivor rerolls, wheel, crates); Config mirror in repo mode. Must print `ERRORS 0`. |
| [tools/check_strings.py](tools/check_strings.py) | Every `STR.*` key exists (blueprint and, in repo mode, `Strings.luau` and `src/`). Must print `ERRORS 0`. |
| [data/names_first.txt](data/names_first.txt), [data/names_last.txt](data/names_last.txt) | 120 + 120 survivor names |

## Key decisions carried from the review (Mareux, 25 Oct 2026)

- Keep every monetisation item that doesn't break Roblox rules; paid random items get odds before purchase, live odds, PolicyService fallbacks and an accurate maturity declaration.
- Keep the 10 s Supermutant revive prompt (Second Wind) and the paid Mutate Now.
- Matchmaking by party size only (Solo, Duo, Trio, Fill Squad). No aggression or behaviour matchmaking.
- Raid hiding uses shop shutters and barricades, not a safe room. Betrayal stays hidden. Bounties are anonymous.
- Build as Stages up to a two-player Alpha, then Features.
- The lobby is a Dredd-style tower per server with a fixed number of residents, run-down flats you upgrade, the ground floor as the P2P trading hub, and paid Move-in to live in a friend's tower (friends can always visit and raid together for free).
