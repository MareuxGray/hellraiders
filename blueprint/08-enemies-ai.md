# 08 · Enemies and AI

Owner of: Walkers, Crawlers, AI Sprinters, The Janitor, AI senses, the state machine, pathing, the performance budget, spawns, the horde surge, and how AI treats Sleepers. Player mutants are in `09`. Numbers are in `02` §2.9.

**Code decision:** the AI is built new in S8 as `Services.AI` with the design below. Yago's prototype and his 21 Oct roaming, pursuit and mall-extraction packages are reviewed at the start of S8 and reused only where they already match this file (e.g. path following). Write what was reused in `docs/changelog.md`.

---

## 8.1 Roster

| Enemy | Look | HP | Speed patrol / chase | Senses | Attack | Count per raid |
|---|---|---|---|---|---|---|
| **Walker** | Infected shopper, guard, cleaner, food-court worker (4 body variants, 3 outfit tints each) | 60 (head ×3) | 4 / 13 | hearing, sight, scent | Lunge → struggle | 30–36 placed + reinforcements |
| **Crawler** | Legless or broken-backed infected on the floor | 40 (head ×3) | 3 / 9 | hearing, scent (no sight beyond 10) | Ankle grab → struggle | 6–8 |
| **Sprinter** | A dead Sleeper's body, mutated (wears that player's clothes and gear) | 90 (head ×2) | 10 / 24 | hearing, sight, scent, Ghost lures | Swipe (15 dmg, 25% light bleed) and Lunge → struggle | per dead Sleeper |
| **The Janitor** | Hulking mutated mall janitor, 1.4× scale, dragging a squealing mop cart | cannot die | 8 / 18 | hearing (×1.5 radius), sight 30 | Grab → 60 damage + leg fracture + thrown 8 studs (ragdoll) | 1 |

## 8.2 State machine (Walkers, Crawlers, Sprinters)

| State | Behaviour | Exit |
|---|---|---|
| `Dormant` | far from all players (more than 160): not simulated, position frozen | a player comes within 160 |
| `Idle` | stands or shuffles in place, idle groans (every 6–14 s, `SFX-ZOM-001…006`) | hears a noise or sees a player |
| `Wander` | slow roam within 25 of its home point | as above |
| `Investigate` | walks at patrol speed to the last noise position, looks around for 6 s | sees a player → Chase; nothing → Wander |
| `Alert` | sees a possible target at the edge of its range: stops, faces, screeches softly (`SFX-ZOM-010`), 1.0 s | target confirmed → Chase; lost → Investigate |
| `Chase` | runs at chase speed along a path to the target; repaths every 0.5 s | loses sight for 4 s → Search |
| `Search` | goes to the last seen position, then checks 2 nearby points (8 s total) | sees target → Chase; else → Wander |
| `Lunge` | within 6 (Walker) / 3 (Crawler): 0.5 s wind-up (arms rise, `SFX-ZOM-020`), then leap 6 studs | hit → `Grapple`; miss → 1.2 s stumble → Chase |
| `Grapple` | struggle running (`09` §9.2) | struggle ends: shoved → knocked back, 1.5 s → Chase; bite → `Feeding` 2 s → Chase another target |
| `Stunned` | knocked down by a slide tackle (2 s), stagger by melee (0.6 s), brick headshot (1 s) | timer |
| `Surge` | Red Alert: runs to the exit zone at ×2 chase speed (26 Walkers), attacks humans on the way | Red Alert ends |
| `Dead` | ragdoll corpse, anchored after 3 s, despawns after 90 s if no player within 40 | — |

## 8.3 Senses

- **Hearing:** reacts to any noise event (`06` §6.1) whose radius (floor-adjusted) reaches it. Louder and closer noises override older ones. Walkers already in Chase ignore noises unless they lose sight.
- **Sight:** cone ±50°, range 40 vs lit targets, 15 vs dark, ×0.6 vs crouched (02 §2.6). Line-of-sight raycast from the head, 4 Hz per AI in Idle/Wander/Investigate, 10 Hz in Chase. Smoke blocks sight.
- **Scent:** follows blood trail decals (`05` §5.6) within 20, newest first. Sprinters and Crawlers also follow the Sleeper scent trail (`09` §9.6).
- **Flashlight:** a beam landing on a Walker within 45 makes it turn toward the beam source and go to Alert.
- **Shared alerts:** a Walker that enters Chase emits a soft "call" to Walkers within 25 (they Investigate the target's position). This is not a noise event (it doesn't stack fear).

## 8.4 Targeting rules

- Valid targets: Humans and Downed players. Priority: Downed in sight > closest Human in sight > last heard.
- **Sleepers:** Walkers, Crawlers and Sprinters ignore Sleepers (they don't see, hear or lunge at them) **unless the Sleeper damaged that zombie in the last 15 s**. Ignored Sleepers still get blocked by bodies (collision). This is a deliberate clue for observant players.
- Mutant players: AI ignores them and never attacks them; mutants can pass through AI collision (no blocking).
- Players in spawn protection: ignored.

## 8.5 Pathing and performance budget

- `PathfindingService` with agent params per type (Walker radius 1.5, height 5; Crawler radius 1.5, height 2, can pass Half shutters; Janitor radius 2.5, height 7). Costs: shards ×1 (no avoidance), fire ×50 (avoid), glass ×1.
- **Path sharing:** AI chasing the same target reuse one computed path (repath every 0.5 s per target, not per AI).
- **Update LOD:** Chase 10 Hz; Investigate, Search 4 Hz; Idle, Wander 2 Hz; Dormant 0.
- **Caps:** at most 40 active (non-Dormant) AI per server and 24 within 120 of any player (`AI.MaxActive`, `AI.NearCap`). Over the cap, the farthest Idle AI go Dormant first.
- Server owns AI physics: `SetNetworkOwner(nil)` on all AI root parts.
- **Budget target:** AI total under 4 ms per server frame at 40 active (measured in S8 and S17 with the micro-profiler).
- Animation: AI play clips on the server-owned Animator; clients replicate. Walk/run clips are speed-matched.

## 8.6 Spawning

- **Placed spawns:** the map has about 60 Walker points and 12 Crawler points tagged by wing (`23` §23.4). At Loading the server fills 30–36 Walker points and 6–8 Crawler points, never within 40 of an entry gate.
- **Reinforcements:** every 120 s, up to 4 Walkers spawn at service doors (out of any player's sight, at least 50 away) in the wing with the most noise in the last 2 minutes, until the active cap.
- **During Red Alert:** 10 extra Walkers spawn at service doors across the mall at the start (still under the cap; Dormant AI near nobody are culled first).
- **Corpses:** killed AI never respawn in place.
- Body variants and outfit tints are random per spawn (`MDL-ZOM-001…004`, `TEX-ZOM-001…012`).

## 8.7 The Janitor

- Enters at 480 s from the Maintenance tunnels service door nearest the loudest noise of the last minute. PA crackle `SFX-JAN-001` plays mall-wide (no subtitle; players learn the sound).
- **Hunting rule:** goes to the loudest noise event heard in the last 20 s (radius × recency weight). Without one, patrols a route through the three busiest wings. Hears at 1.5× radius. Sees 30 (lit and dark alike).
- **Audio tell:** its mop cart squeals continuously while moving (`SFX-JAN-010`, audible to 60, 3D), and its heavy breathing is audible to 20 (`SFX-JAN-011`). It stops the cart and goes silent for 3 s before a grab (`SFX-JAN-012` wet inhale), which is the dodge tell.
- **Grab:** within 4 studs, 0.6 s wind-up, then grab. Victim takes 60 damage, a leg fracture, and is thrown 8 studs (ragdoll). If the victim has 60 health or less, the grab kills them. Rolling out of the wind-up line dodges it. 6 s cooldown after a grab.
- **Stun:** a UV Stun Flare within 10 stuns it for 6 s (cover face, `ANIM-JAN-005`). 120 gun damage within 5 s staggers it for 1.5 s. Nothing kills it.
- **Doors and barriers:** opens doors, breaks barricades in 2 s, bashes a Down shutter for 3 s and raises it. Can't use elevators. Can't climb.
- **Red Alert:** it goes to the exit zone with the surge and patrols its edge. It never enters the evac zone itself (the zone is safe from it, so the Supermutant is the only threat in a Lockdown).
- Clips `ANIM-JAN-001…008`. Model `MDL-JAN-001`.

## 8.8 Sprinter (AI + Ghost)

- Spawned from a Sleeper who dies (`09` §9.10). It keeps the dead player's clothes and armour visual and carries their backpack. It's an AI with the Sprinter stats above. Its target choice is AI-driven, but the Ghost's lures (alarms, door slams, flashlight flicker) give it new targets: any human affected by a Ghost tool becomes its priority target for 10 s.
- When killed, it drops the original backpack (`11` §11.9) and the Ghost becomes a normal spectator.

## 8.9 Reactions and audio summary

| Event | Clip | Sound |
|---|---|---|
| Idle groan | `ANIM-ZOM-001` | `SFX-ZOM-001…006` |
| Notice (Alert) | `ANIM-ZOM-002` | `SFX-ZOM-010` |
| Chase run | `ANIM-ZOM-003` | `SFX-ZOM-011` (breathing loop) |
| Lunge wind-up / leap | `ANIM-ZOM-004/005` | `SFX-ZOM-020/021` |
| Grapple loop | `ANIM-ZOM-006` (paired with `ANIM-STR-001`) | `SFX-ZOM-022` |
| Shoved off | `ANIM-ZOM-007` | `SFX-ZOM-023` |
| Bite | `ANIM-ZOM-008` (paired `ANIM-STR-003`) | `SFX-ZOM-024` |
| Hit reaction | `ANIM-ZOM-009` | `SFX-ZOM-030` |
| Death | ragdoll + `ANIM-ZOM-010` start | `SFX-ZOM-031` |
| Crawler crawl / grab | `ANIM-ZOM-020/021` | `SFX-ZOM-040/041` |
| Sprinter run / swipe | `ANIM-ZOM-030/031` | `SFX-ZOM-050/051` |
