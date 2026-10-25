# 06 · Stealth, noise, light and the interactive environment

Owner of: the noise system, hearing, visibility and light, flashlights, power and generators, breakable glass and shards, shop shutters, doors, barricades and wedges, locked rooms and keycards, alarms and traps, shootable lights, elevators, and destructible walls. Numbers are in `02` §2.5–2.6.

---

## 6.1 Noise events

- Every noise is a server event `Noise.emit(position, radius, kind, sourcePlayer?, multiFloor)` (`Services.Noise`). The old `Stats.EmitNoise` and `NoiseEmitted` event forward to it.
- Player movement noise is emitted by the server from the stance it infers from velocity (10 Hz), using `noiseRadius` from `05` §5.3. A footstep noise event fires at most every 0.5 s per player.
- **Floors:** the mall is split into floor volumes (Basement, Ground, First, Second, Roof; `23` §23.2). A noise heard on another floor uses radius ×0.5 unless it's multi-floor. Multi-floor noises reach every floor at full radius within their horizontal radius. Open atriums (tagged `Atrium`) count as the same floor for every floor they span.
- **Walls:** noise isn't blocked by walls (simple and readable). Exception: a closed shop shutter halves radius for noise made inside that shop (`Shutter.Muffle = 0.5`).
- **Who hears:** Walkers, Crawlers and The Janitor react (`08` §8.3). Sprinters react to Ghost lures. Mutant players see a **noise ping**: a pulsing ring at the source for 2 s, size by radius (`VFX-MUT-001`), for any noise within their full radius. Humans hear the actual sound (3D audio).

## 6.2 Hiding in shops (shutters)

- Every shop front has a roll-down security shutter (`MDL-ENV-010`), tagged `Shutter`. States: Up, Half, Down.
- **Context (hold 1.0 s)** at the shutter control (inside or outside) moves it one step: Up → Half → Down, or Down → Up. The full travel takes 2.0 s with a loud rattle (noise 40, `SFX-ENV-010`).
- **Down:** blocks movement and line of sight. Walkers and Crawlers outside lose track of anyone inside and won't search inside unless they heard noise from inside in the last 10 s. The Janitor and Supermutant break shutters (Janitor 3 s of bashing, Supermutant Charge instantly). Stalker Mutants can't pass a Down shutter, but can pass a Half shutter by crawling.
- **Half:** Crawlers and Stalker Mutants pass under it. Humans crouch under it (forced crouch, 1.2 s), or crawl under it prone with no delay (`04` §4.2).
- Anyone can raise a shutter from either side. That's the trust tension: a stranger can open your hiding spot, and you're shut in with whoever is inside.
- Each shop has a back service door into the corridor network (`23` §23.2), so a closed shop isn't always a dead end.

## 6.3 Visibility and light

- **Light level** at a character: "lit" if inside a powered wing with its lights on, inside any player's flashlight beam, inside a light radius (fire, flare, emergency light), or holding a lit flashlight. Otherwise "dark".
- `lightFactor` = 1 when lit, 0.375 when dark, so zombie sight range drops from 40 to 15 (`02` §2.6).
- **Mall default:** unpowered. Only emergency lights (dim red, decorative, `lit` radius 4 at each fitting) and moonlight through skylights (decorative, not lit).
- **Flashlight:** equipped in the Flashlight slot, toggled with `Light` (PC F, gamepad D-pad up, mobile light button). Cone 30°, range 45. Battery 300 s of on-time; a battery item restores it (1×1, Common). Beam flickers for the last 20 s.
  - Humans see far better with it on: post-processing darkness lifts inside the cone.
  - Mutant players see the **beam source through walls and windows within 120** as a glow (`VFX-MUT-002`).
  - Zombies see a flashlight holder at 40 and turn toward a beam that lands on them.
- **Shootable lights:** in powered wings, lights (`MDL-ENV-020…022`) can be shot out (one hit; glass break sound and noise 30). They stay out for the raid. Shooting lights in your area makes it dark.

## 6.4 Power and generators

- The mall has three **generators** (`MDL-ENV-030`), each powering one wing group (`23` §23.6):
  - **Generator North** powers Food Court and Department Store.
  - **Generator East** powers Electronics and Cinema.
  - **Generator Service** powers Maintenance tunnels, Security Office and the service elevators.
- **Starting a generator:** needs a **Fuel Can** (2×2, Uncommon). Hold Context 6 s (`ANIM-ACT-030`). Noise 150 multi-floor at start, then a hum (noise 20, constant). A lit amber lamp shows on its panel.
- **Powered wing effects:** lights on (everyone there is lit), escalators run, the wing's shutters can be operated from the Security Office panel, and its **service elevator** works (§6.9). Alarms in that wing become live (§6.8).
- Generators run for the rest of the raid. They can't be switched off, but their lights can be shot out.

## 6.5 Glass

- Breakable glass is tagged `Glass` with a size class: Small (display case), Medium (window, door glass), Large (storefront).
- **Breaks from:** any bullet (1 hit), melee hit, thrown bottle or brick, Supermutant charge or slam, Janitor contact, slide or roll impact into Small or Medium (not Large).
- **On break:** the pane is replaced by shards VFX (`VFX-ENV-001`) plus floor shards decal and collision-free trigger (`MDL-ENV-040`). Noise 120 multi-floor. Sound by size (`SFX-ENV-001…003`).
- **Shards on the floor** make noise when stepped on: walk 15, sprint 30, crouch 0. This turns old breaks into alarms.
- **Display cases** are containers (`11` §11.4). Breaking the glass skips the 1.2 s open hold but makes the noise.
- **Windows** are traversal targets once broken (`04` §4.6).

## 6.6 Destructible walls

- Non-structural walls and fittings are tagged `Destructible`: plasterboard partitions, shop dividers, glass storefronts, wooden barricades, kiosk panels.
- Only the Supermutant Charge and Slam break Destructible walls. Each breaks into pre-fractured chunks (`MDL-ENV-050` sets, simulated for 3 s, then anchored and collision-off) with dust VFX `VFX-ENV-005` and noise 120 multi-floor. This opens new routes and destroys hiding spots.
- Structural walls (`23` marks them) never break.

## 6.7 Doors, barricades, wedges and locks

| Thing | Behaviour |
|---|---|
| Interior door | Context to open/close (0.5 s). Can be slammed shut while sprinting through (noise 50). |
| Security door (heavy) | 1.2 s to open. Ghosts can slam and lock them for 6 s (`09` §9.10). |
| Barricade | Planks (1×3 item, Common, stack 3). Hold Context 3 s on a closed door frame to nail up (needs 3 planks; noise 35). Barricaded doors can't be opened by humans or Walkers. Crawlers can't pass. Humans break one with 3 melee hits (fire axe 1). The Janitor breaks one in 2 s, the Supermutant instantly, a Stalker Mutant in 4 s. |
| Door wedge | 1×1, Uncommon. Hold Context 1 s at a closed door. That door can't be opened from the far side for 30 s (`Wedge.Time = 30`), then the wedge drops. |
| Locked stockroom | Needs a matching **keycard** (Food Court, Electronics, Department Store, Pharmacy, Security; 1×1, Rare, single use) or a crowbar pry (hold 6 s, noise 60; the crowbar isn't used up). Inside: 2–4 containers with better tables (`11` §11.6). |
| Med Safe | Locked metal cabinet in the Pharmacy and Security Office. Opened with a Pharmacy keycard or a 4-digit code found on a sticky note in the same wing (code randomised per raid, shown on `MDL-ITM-090`). Antidotes spawn only in Med Safes (`09` §9.7). |

## 6.8 Alarms and traps

- **Store alarms** (`MDL-ENV-060`): on the door frames of 6 shops per raid (randomised from 12 marked shops). Unpowered: dead. In a powered wing: walking through at more than crouch speed sets it off (noise 200 multi-floor for 20 s, red light, `SFX-ENV-020`). Can be disarmed by holding Context 3 s at the alarm box (silent).
- **Hanging signs** and **bottle strings** (`MDL-ENV-061/062`): trip traps placed at 20 fixed points. Moving faster than crouch through them sounds a noise of 60. Visible if you look (they hang at head and ankle height), and reset after 30 s.
- **Ghost and Sleeper triggers:** Ghosts (`09` §9.10) and Sleepers (`09` §9.6) can trigger any alarm within their range, powered or not, as if it had been tripped. A sabotage trigger looks identical to a trip.

## 6.9 Elevators and escalators

- **Service elevators** (2, `23` §23.6) work only when Generator Service is running. Hold Context at the call panel. Car capacity 4. Travel 3 s per floor. Noise 40 at each stop. Ghosts can't control elevators.
- **Escalators:** unpowered = stairs (some broken: impassable, tagged). Powered = moving at 4 studs/s.
- **Freight lifts** at the entry gates are decorative after Deploy, except the Basement Garage freight lift, which is an evac exit (`10` §10.3).

## 6.10 Climbing between floors (humans)

Stairs, escalators, ladders (`04` §4.6), floor-edge drops (8–14 studs; no damage with the landing roll), service elevators (powered). Falls from higher edges deal fall damage. Humans can't climb walls.
