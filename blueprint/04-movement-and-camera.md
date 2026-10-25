# 04 · Movement, traversal, animation and camera

Owner of: locomotion, crouch, sprint, roll, slide and slide tackle, turning, traversal (Adaptive Motions), falls, ragdoll, character animation ownership, multiplayer pose relay, the camera rig and every camera effect, and mutant movement. Numbers are in `02` §2.3.

The existing place already contains working versions of most of this (Gait, Body, Actions, CameraRig, Combat slide, Services.Ragdoll, Traverse/RailPlanner/ProcPose, RemotePose, ClipAnalyzer). S1 ports them into the repo (`26` S1). The rules below are what the ported code must do. Where the old code differs, change the code.

---

## 4.1 Single-owner rule (keep it)

Exactly one module writes each thing. No other script may write it.

| Thing | Owner | Notes |
|---|---|---|
| Camera CFrame, FOV | `CameraRig` (client) | Every other system requests effects through `CameraRig.request(effectName, params)`. |
| Ground locomotion clips (idle, walk, run, strafe, back, crouch) | `Gait` (client, local character) | Weight-blended with one shared stride clock. |
| Model yaw, leg twist, lean, foot grounding | `Body` (client) | |
| Joints during traversal | `ProcPose` (client) | |
| Action clips (roll, slide, pickup, throw, reload, heal, search, struggle, tackled, emotes) | `Actions` (client) | |
| Humanoid WalkSpeed | `MoveSpeed` (client, new) | Computes speed from 02 §2.3 and the stats packet. Gait and Aim read it and never write WalkSpeed directly. |
| Ragdoll state | `Services.Ragdoll` (server) | Clients play the get-up clip. |
| Remote players' corrections | `RemotePose` (client) | Replays root and joint corrections for other characters (§4.10). |

## 4.2 Ground locomotion

- **States:** Idle, Walk, Sprint, Crouch Idle, Crouch Walk, Prone Idle, Prone Crawl, Aim Walk (strafe set), Walk Back, Overweight Walk, Injured Walk (leg fracture), Downed Crawl.
- **Clips (ids in 27):** idle `ANIM-MOV-001`, walk `ANIM-MOV-002`, run `ANIM-MOV-003`, crouch idle `ANIM-MOV-004`, crouch walk `ANIM-MOV-005`, strafe left/right `ANIM-MOV-006/007`, walk back `ANIM-MOV-008`, aimed walk forward/back `ANIM-MOV-009/010`, start and stop transitions (walk and run, 4 clips) `ANIM-MOV-011…014`, overweight walk `ANIM-MOV-015`, injured limp `ANIM-MOV-016`, downed crawl `ANIM-MOV-017`, idle-bored variants ×3 `ANIM-MOV-018…020`.
- **Blending:** Gait blends by speed and direction weights with one stride clock (feet stay in phase). Foot-speed matching (`FOOT_MATCH`) scales playback up to walk ×2.0 and run ×2.4 to cut foot gliding.
- **Idle timers:** idle variant after 5 s still, bored variant after 25 s (`Move.IdleAfter = 5`, `Move.BoredAfter = 25`). The test values (1 s and 10 s) in the old place must be replaced.
- **Acceleration:** ground speed changes by up to 60 studs/s² when speeding up and 80 studs/s² when stopping (`Move.Accel = 60`, `Move.Decel = 80`). Start and stop clips play when the change is from or to 0.
- **Sprint:** hold Sprint (PC Shift, gamepad L3 click toggles, mobile auto-sprint when the stick is pushed past 90%). Not possible while aiming, crouched (Sprint stands you up), overweight, leg-fractured, or at 0 stamina.
- **Crouch:** toggle (PC C, gamepad B, mobile crouch button). Noise 0 and zombie sight range ×0.6.
- **Prone and crawl:** hold Crouch for 0.5 s (PC hold C, gamepad hold B, mobile long-press the Crouch button) to drop prone; hold it again to rise to a crouch, or press Sprint to stand. Going down takes 0.6 s (`ANIM-MOV-023`), getting up 0.7 s (`ANIM-MOV-024`); prone idle `ANIM-MOV-025`, crawl loop `ANIM-MOV-026` (elbows and knees, weapon slung across the back). Crawl speed 3, noise 0, zombie sight range ×0.4, character height 2 studs (`Move.Prone.*` in `02`). While prone you can't sprint, roll, slide, traverse, aim, fire or melee; you can use medical items from quick slots, ping and use quick lines. Leaving a crawl space you're standing up in is blocked until there's 6 studs of headroom (the stand prompt greys out). A leg fracture doesn't slow crawling. Going prone drops the Fear boost. Downed Crawl is a different state (`05` §5.8) and isn't affected by this input.
- **Where crawling matters:** under Half shutters without the 1.2 s forced crouch (`06` §6.2), through crawl spaces tagged `CrawlSpace` (collapsed ceiling slabs, under display counters and parked cars, broken vent runs; `23` §23.6), and lying still in a dark spot to stay unseen.
- **Speeds** are in 02 §2.3. Multipliers stack by multiplying: fear boost, carry, injury, low health (below 25 health: ×0.9).
- **No jumping.** `Humanoid.JumpPower = 0`, jump input unbound. Space (and mobile's Action button) is the dodge roll, or traversal when a traversal edge is in front (§4.6).
- **Input buffer:** Roll, Slide, traversal, reload and melee pressed up to 0.15 s before they become possible (during a cooldown, a landing, or the last frames of another action) are stored and fire on the first valid frame (`Move.InputBuffer`). Only the latest press is kept. A buffered press is dropped if the player is grabbed, Downed or in a struggle.
- **Traversal grace (the coyote-time rule for a game with no jump):** a traversal edge stays valid for 0.12 s after it leaves the detection box (`Move.EdgeGrace`), so a press just after running past a counter or railing still vaults it instead of rolling.

## 4.3 Turning (Body)

- **Standing, not aiming:** a free-look cone of ±60°. The body turns only when the camera yaw leaves the cone, using 90° and 180° turn clips (`ANIM-MOV-021/022`) with a rate-limited smooth follow.
- **Moving:** the body faces the move direction in any direction (S turns you around), except when aiming.
- **Aiming or firing:** the body faces the camera aim point. Strafe set plays. Leg twist is a continuous function of the angle between movement and torso (no hard switch at 90°).
- **Lean:** into turns while running, up to 8° (`Body.LeanMax = 8`).
- **Foot grounding:** feet-only IK onto slopes and stairs, up to 1.2 studs of offset (`Body.GroundMax = 1.2`).

## 4.4 Dodge roll

- Press Roll (Space, gamepad A, mobile Action) while moving or standing. Rolls in the move direction (forward if standing) for 0.6 s and 9 studs, then keeps the speed you entered with. Clip `ANIM-ACT-001`.
- Costs 20 stamina. 1.0 s cooldown. Noise 20.
- **Lunge dodge:** a roll started during a zombie's 0.5 s lunge wind-up, moving out of its lunge line, makes the lunge miss. This is the main skill-expression counter to tackles.
- No invulnerability to bullets.
- Root motion is cancelled into `Root.C0` locally and relayed (§4.10). FOV holds during the roll (no FOV pop).

## 4.5 Slide and slide tackle

- Press Slide (PC V, gamepad B while sprinting, mobile Crouch while sprinting). Requires moving at walk speed or faster on the ground.
- Duration scales with entry speed: 0.8 s at walk (12) to 1.6 s at sprint (22). Start speed = entry ×1.2, end speed 5–10. Exits into a run when Sprint is held, keeping momentum (0.35 s hold). Costs 15 stamina. Cooldown 1.8 s. Noise 25.
- Clip `ANIM-ACT-002` (in-place, hips dip 1.09, from the published slide), fitted to the duration.
- **Slide camera:** eases down 0.7 to 1.4 studs, pulls 0.8 studs closer, FOV +up to 8, head-following roll ×0.7 plus a lean toward the travel direction up to 10°, clamped at 22°, mirrored by shoulder.
- **Slide tackle:** a sliding character that touches another player ragdolls them for 1.5 s (`Services.Ragdoll`, get-up `ANIM-ACT-003`). It also knocks Walkers down for 2.0 s. No damage. 2.0 s immunity after a get-up. There are no hostility markers, so a slide tackle is just physical.
- Server-owned velocity. The owning client predicts it (§4.10).

## 4.6 Traversal (Adaptive Motions)

Procedural traversal. The existing AM system (Traverse, RailPlanner, ProcPose) plans the pelvis path and hand and foot anchors from the measured edge, solves the limbs with joint-limited IK and adds spring follow-through (budget 0.3 ms per frame).

| Move | Trigger | Result | Config key |
|---|---|---|---|
| Step-over (automatic) | walking or running into an obstacle 1.0–2.5 high tagged `Traverse.Rail` or `Traverse.Box` (kerbs, fallen signs, low planters, toppled bins) | step over in stride, no input, no stamina, speed ×0.85 for 0.3 s; noise as footsteps | `AM.Step.*` |
| Mantle (standing) | Space at a guardrail or box, waist height 2.5–4.5, while still or walking | climb onto/over in 0.9 s. **Onto vs over:** if the top is walkable (at least 2×2 studs flat, 6 studs of headroom) you end standing on it: crates, counters, car roofs, planters. Otherwise (a rail or a thin edge) you go over it | `AM.Mantle.*` |
| One-hand vault (running) | Space at a guardrail while sprinting | vault over in 0.55 s, keep 80% speed | `AM.Vault.*` |
| Vault into hang | vault where the far side drops more than 6 studs | hang on the outside of the rail | `AM.Hang.*` |
| Ledge climb-up | Space facing a ledge whose top is 4.5–7.5 above your feet, tagged `Traverse.Ledge` or a `Traverse.Box` stack that tall, with a walkable top | hands-on pull-up in 1.4 s: hands plant, boots scrabble, knee up, stand on top. 15 stamina, noise 18. Not while overweight, leg-fractured, holding a two-handed carried object, or under 15 stamina (the prompt doesn't show) | `AM.Ledge.*` |
| Pull up from a ledge hang | a climb-up that starts while sprinting off a lip, or a drop from a hang with a ledge within 1 stud below | catch the ledge and hang; then the hang moves above apply | `AM.Hang.*` |
| Hang moves | W climbs back over (0.9 s), A/D hop sideways 2.5 studs, S or Crouch drops | | `AM.HangMove.*` |
| Drop | from a hang, falls; fall damage applies from the hang height | | — |
| Floor-edge vault (S5) | Space at a floor opening edge with rail-less lip | jump down onto the floor below if the drop is 8–14 (landing roll, no damage) | `AM.EdgeDrop.*` |
| Ladder (S5) | Context at a ladder base or top | climb at 6 studs/s; can't use items; noise 12 | `AM.Ladder.*` |
| Window climb-through (S5) | Space at a broken window frame (sill 2–4.5) | climb through in 1.1 s; unbroken glass must be broken first | `AM.Window.*` |
| Low cover crouch-walk | automatic under 4.5-stud ceilings | forced crouch | — |
| Crawl space | automatic under 2.5-stud ceilings: you can only enter prone (hold Crouch at the gap; the prompt shows `STR.HINT.CRAWL`) | crawl through at speed 3 | `Move.Prone.*` |
| Stacked boxes | a `Traverse.Box` on a `Traverse.Box`: each 2.5–4.5 step is a mantle, a 4.5–7.5 total is a ledge climb-up | climb crate stacks as a route (stockrooms, loading dock, Garage) | — |

- Costs 10 stamina (mantle, vault, window), 15 (ledge climb-up), 0 (step-over). Noise 18 on landing. Sounds: mantle and vault `SFX-PLR-024`, ledge climb-up `SFX-PLR-042`, prone drop and rise `SFX-PLR-040`, crawl loop `SFX-PLR-041`.
- **Anything over 7.5 studs** can't be climbed by survivors. Use ladders, stairs or a crate stack.
- **Falling from a climbed object** uses §4.7 and the fall damage in `02` §2.3, measured from where you stood (a car roof is about 5 studs: no damage).
- Clipping target: under 0.2 studs of penetration on the worst frame (old place: about 0.5). Fix in S5.
- Other players must see traversal correctly: the AM relay (§4.10) is built in S5.
- Mutants don't use AM. They climb any wall (§4.12).
- Traversal edges are tagged in the map (`Traverse.Rail`, `Traverse.EdgeDrop`, `Traverse.Ladder`, `Traverse.Window`) with attributes for height (`23` §23.6).

## 4.7 Falls and landing

- Fall height = highest point minus landing point. Damage in 02 §2.3: none below 12 studs; 12–20: 20 damage and a 30% chance of a leg fracture; 20–30: 45 damage and a sure leg fracture; over 30: death. Mall reference: one floor is 14 studs, so dropping one floor over a rail hurts, and dropping two floors (28) nearly kills. The rail-less floor-edge drops (§4.6) are the safe exception: a landing roll and no damage.
- A dodge roll pressed within 0.2 s of landing from 12–20 studs cuts the damage by half and removes the fracture chance (`Fall.RollWindow = 0.2`, `Fall.RollCut = 0.5`). It does nothing above 20.
- Damage is decided by the server from the server-side fall start height (anti-exploit, `25` §25.9).
- Landing under 6: no clip. 6–12: soft land `ANIM-ACT-004`. 12–20: hard land `ANIM-ACT-005` (0.4 s no control). Over 20: ragdoll 1.2 s, then get-up.
- Landing noise: 18 for 6–12, 30 above 12.

## 4.8 Ragdoll

- `Services.Ragdoll` swaps Motor6Ds for BallSocketConstraints (with joint limits) and restores them on get-up. It's used for slide tackles, Janitor throws, hard falls, explosive knockback (molotov does none) and death.
- Get-up: front or back clip by the torso's facing (`ANIM-ACT-003`, `ANIM-ACT-006`), 0.9 s.
- Deaths stay ragdolled. The corpse anchors after 3 s of rest (performance) and keeps a backpack prompt.

## 4.9 Animation pipeline rules

- Every clip is authored in place (no hips travel on X/Z). Import checks via `ClipAnalyzer`: speed, foot contacts, float, glitches. A clip fails the check if any single-frame limb change is over 45°, LowerTorso X/Z travel is over 0.2, or the keyframe count is 0.
- Read back every published id with `KeyframeSequenceProvider:GetKeyframeSequenceAsync` before wiring it.
- All animations are owned by the **group** that owns the experience (they must not be uploaded from a personal account; `26` S0).
- Priority: Core for locomotion, Movement for Gait blends, Action for Actions clips, Action4 for struggles, emotes and deaths.
- Mixamo or Blender clips: export "In Place", R15 retarget, check units (Studio imports at about 100×; fix scale before publishing).

## 4.10 Multiplayer pose relay (required before Alpha)

- Local corrections (turn clips, roll and slide root cancel, foot grounding, lean, AM traversal) are invisible to others unless relayed.
- **RemotePose** receives a compact per-character state at 20 Hz (`Net.PoseState`): body yaw, lean, root offset, current action id and its time, traversal plan id plus anchors. Other clients apply the same corrections to remote characters.
- **AM relay:** the local client sends the traversal plan at start (edge id, entry pose, move type). Remote clients run the same deterministic planner from those inputs instead of streaming joints.
- Bandwidth target: under 1.5 KB/s per character. Measured in S16.

## 4.11 Camera rig

Third-person over-the-shoulder in raids and the tower. Owner: `CameraRig`.

| Topic | Value | Config key |
|---|---|---|
| Boom distance (default / sprint / aim) | 9 / 10 / 4.8 | `Cam.Dist.*` |
| Shoulder offset (right, mirrored on swap) | X 2.2, Y 1.6 | `Cam.Shoulder = {X=2.2, Y=1.6}` |
| Field of view (default / sprint / aim) | 70 / 78 / 50 | `Cam.FOV.*` |
| Boom lag (position follow rate) | 12 | `Cam.Lag = 12` |
| Look weight (yaw sensitivity scale when aiming) | 0.65 | `Cam.AimLookScale = 0.65` |
| Pitch limits | −70 to +60 | `Cam.Pitch.*` |
| Wall handling | spherecast radius 0.6, pull in, ease out at 6 studs/s | `Cam.Wall.*` |
| Shoulder swap | Q (PC), gamepad R3 click, mobile swap button; 0.25 s blend | `Cam.SwapTime = 0.25` |
| Aim near-blur on own character | `Lighting.AimBlur` size 8 while aiming | — |
| Mouse | locked at centre, hidden, no crosshair in raids. Free while a menu is open or Alt is toggled. | — |
| Tower camera | same rig. Mouse is free while hovering interactables. Aim is disabled in the tower. | — |

**Camera effects (requested from other systems, all scaled by the Shake setting and Reduce Motion):**

| Effect | Trigger | Amount |
|---|---|---|
| Breathing sway | always | 0.05° at rest, rising with stamina loss to 0.35° |
| Fear shake | fear above 40 | noise shake 0 → 0.6° at fear 100 |
| Speed FOV | sprint, slide | to 78, slide +8 |
| Hit punch | taking damage | 2° kick away from the source, 0.15 s |
| Tackle | struggle start | camera pulls to 3.5 studs and tilts 8° for the struggle |
| Bite | failed struggle | 0.4 s red flash, 4° roll, low-pass audio 1 s |
| Explosion/glass/door slam within 15 | event | 0.8° shake 0.3 s |
| Screech (Supermutant within 3 studs) | `09` §9.12 | heavy blur 2 s, drop held light |
| Lockdown slam | doors lock | 1.5° shake 0.6 s |
| Ragdoll | ragdoll | camera follows the head with 0.3 s lag |
| Downed | Downed | camera lowers to 1.5 studs, desaturate 50% |

- **Low health** (no number): below 50 health the screen edges desaturate and pulse with the heartbeat; below 25 the vignette darkens and audio low-passes (`21` §21.4).
- **Reduce Motion:** all shakes ×0.25, no FOV kicks, no roll tilt.

## 4.12 Mutant movement

| Mutant | Movement |
|---|---|
| Stalker Mutant | Run 20, sprint 26 (no stamina). Climbs any wall at 12 (hold Climb), drops from heights without damage, can crawl under shutters that are down halfway or more. Camera boom 7, FOV 80. |
| Supermutant | Run 22, sprint 28. Surface alignment: runs on walls and ceilings at full speed (camera rolls to the surface with a 0.3 s blend). Charge: a 14-stud dash at 45 that breaks glass, barricades, shutters and non-structural walls (`06` §6.6). Camera boom 11, FOV 85. |
| Sprinter (AI + Ghost) | AI pathing only. The ghost camera is attached (`09` §9.10). |
| The Janitor | AI only, 8 patrol and 18 chase, opens any door, breaks barricades in 2 s. |

Mutant animations: `ANIM-MUT-001…008` (Stalker) and `ANIM-MUT-010…020` (Supermutant) (`27`).
