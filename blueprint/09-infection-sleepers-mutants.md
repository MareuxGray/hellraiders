# 09 · Struggles, infection, Sleepers, Ghosts and mutants

Owner of: the struggle QTE, bites, the Sleeper state, incubation, symptoms, scanners, cures and suppressants, Sleeper sabotage, the Stalker Mutant, Sprinter Ghost Guidance, the Supermutant and its variants, the paid revive and paid transformation. Numbers are in `02` §2.7 and §2.9.

---

## 9.1 Rules that never change

1. **Nothing on another player's screen ever says who is a Sleeper.** No icon, no colour, no name tint, no squad marker change.
2. The Sleeper always knows they're infected.
3. Every Sleeper symptom has an innocent explanation (fear tremor, cold, injury), except the Blood Scanner result.
4. Sabotage actions use the same prompts, timings and animations as normal actions.

## 9.2 The struggle (timing-bar QTE)

- **Starts when** a Walker or Sprinter lunge connects, or a Crawler ankle-grabs, on a Human, Sleeper or Downed player.
- **Paired animation:** zombie `ANIM-ZOM-006` + victim `ANIM-STR-001` (pinned standing, or `ANIM-STR-002` on the floor for Crawlers and Downed). Camera pulls to 3.5 studs and tilts 8°. Fear +25.
- **The bar** (`UI-STR-001`): a horizontal bar centred low on screen with a green zone at a random position (never touching either end), and a needle that sweeps back and forth.

| Struggle # this raid | Green zone width | Needle sweep period (one way) | Time limit |
|---|---|---|---|
| 1 | 30% | 1.6 s | 5.0 s |
| 2 | 20% | 1.3 s | 3.0 s |
| 3 | 12% | 1.0 s | 1.5 s |
| 4+ | no bar: instant bite | — | — |

- **Input:** one button, `Struggle` (PC Space or LMB, gamepad A, mobile: tap anywhere on the bar). One press per struggle. Pressing with the needle inside the zone = success; outside = failure; timeout = failure.
- **Success:** shove animation `ANIM-STR-004`. The attacker is knocked back 6 studs and takes 10 damage. 1.5 s escape window (no lunges can target you). Counter +1.
- **Failure:** bite (§9.3). Counter +1.
- **Teammate intercept:** any bullet, melee or shove hit on the grappling zombie, from anyone, ends the struggle instantly. The zombie dies if the hit was a bullet or melee, or is knocked back if it was a shove. Counter is NOT increased. The interceptor gets +25 XP (+50 if it was a stranger).
- **Tutorial:** in the Orientation Run, the first bar has a 50% zone.
- The bar runs on the client for responsiveness. The client sends `{pressTime, needlePos}` and the server checks it against its own copy of the needle (same seed and start time), with 100 ms tolerance.

## 9.3 Bites

| Victim | Result |
|---|---|
| Human | becomes a **Sleeper**. Bite animation `ANIM-STR-003`, then the zombie releases and goes for another target (2 s feeding). |
| Sleeper | killed: becomes a **Sprinter** with a Ghost (§9.10). |
| Downed Human | becomes a Downed Sleeper. |
| Downed Sleeper | killed: Sprinter (§9.10). |

- The bite happens in full view: nearby players can see someone was bitten. Hiding a bite means making sure nobody saw it.
- Bites from tainted medical items (§9.6) are silent and private.

## 9.4 The Sleeper (own view)

- On becoming a Sleeper: private screen message `STR.INF.BITTEN` ("You've been bitten. Find an Antidote, or don't."), a 0.4 s red flash and a low heartbeat.
- **Incubation:** hidden timer of `180 × incubationMult` seconds (Composure 3: 162 s, 5: 180 s, 7: 198 s). Suppressants pause it 90 s each (stacking by adding pause time).
- **What the Sleeper sees** (`UI-INF-001`, screen-edge veins): three stages by progress (0–33%, 33–66%, 66–100%), each creeping further in. At 20 s left: veins pulse, `STR.INF.TURNING` and a rising tone. No exact numbers.
- The Sleeper's sabotage actions appear in their normal context prompts (§9.6).
- Walkers, Crawlers and Sprinters ignore them (`08` §8.4) unless they attack one.

## 9.5 Symptoms (what others can notice)

Symptoms come in by incubation progress. They stay at their current level while paused by a Suppressant, and vanish on cure.

| From progress | Symptom | Who can notice |
|---|---|---|
| 20% | Suppressed cough when standing still for 4+ s, every 15–25 s (`SFX-INF-001…004`) | anyone within 12 |
| 40% | Hand tremor: the weapon visibly jitters on the character model while aiming (amplitude 0.6°; same visual as high-fear tremor) | anyone who looks |
| 60% | Faint heartbeat pulse audible to Humans within 6 (`SFX-INF-010`) | Humans within 6 |
| 70% | Pale skin and dark veins on face and hands, visible only to a viewer whose flashlight beam is on the Sleeper within 10 (`TEX-INF-001`; drawn per viewer on the client) | flashlight holders |
| 90% | A small twitch animation every 8–12 s (`ANIM-INF-001`) | anyone who looks |

- Zombies ignoring a Sleeper is also visible behaviour.
- Innocent look-alikes: fear tremor (any player with fear above 50 shows the same weapon jitter), cold breath (none), injured breathing (heavy breathing at low stamina sounds similar to the cough at a distance).

## 9.6 Sleeper sabotage toolkit

All actions are invisible to others, except for their effects. They use the same Context hold as normal actions.

| Action | How | Effect | Cooldown | Clue left |
|---|---|---|---|---|
| Trip an alarm or trap | Context hold 1.0 s within 8 of an alarm box, hanging sign or bottle string (powered or not) | It goes off as if tripped (`06` §6.8) | 60 s | You were near it when it went off |
| Taint a med item | Inventory: right-click (long-press on mobile) a Bandage, Gauze or Medkit you hold > "Inspect" (the menu item is the same for everyone, and for a Sleeper it has a second option "Taint", 2 s) | The item bites its user at the end of use (`05` §5.7). Can then be dropped, put in a container, or handed over. | once per Sleeper life | Faint veins on the item under a flashlight within 3 |
| Scent trail | Hold `Gesture` 1 s (same key as the emote wheel, a hold rather than a tap) | For 20 s you leave an invisible scent trail that Walkers, Crawlers and Sprinters follow (they path along it toward the newest point) | 90 s | Zombies arriving from where you walked |
| Waste and lie | — | Firing wildly, "missing", dropping squad loot | — | Behaviour |
| Evac betrayal | Be inside the evac zone at the departure check | Lockdown, you become the Supermutant (`10` §10.6) | — | Obvious, afterwards |

- **Bitten solo players** have the same toolkit. Their two strategies: race for an Antidote, or **go rogue**: approach a stranger squad as a friendly solo, join their evac, and trigger the Lockdown.

## 9.7 Cures

- **Antidote Syringe:** 1–3 per raid, placed only in Med Safes (Pharmacy ×3 safes, Security Office ×1 safe; `23` §23.6). Each raid picks the count and which safes hold one (the others hold normal medical loot). Revealed as tier Exotic.
- Using one (3.0 s, `ANIM-MED-006`) cures completely: Sleeper → Human, symptoms cleared, struggle counter reset to 1. Using one on a Human does nothing but uses it up (you can test someone by asking them to inject in front of you; a Human loses a valuable item, which is part of the trust game).
- Antidotes can be extracted and sold or kept (stash value 15,000 MC).

## 9.8 Suppressants

- **Infection Suppressant** (Rare loot) and **Improvised Suppressant** (crafted: Chemical Flask + Syringe, `12` §12.2) pause incubation for 90 s each. Used on a Human: no effect, used up.

## 9.9 Scanners

| Scanner | Tier | Uses | Time | Range | Result | Noise |
|---|---|---|---|---|---|---|
| Infrared Thermometer | Rare (1×1) | 3 | 3 s | 4 | "FEVER" if the target's incubation is at 30% or more, otherwise "NORMAL". Shown only to the user (`UI-INF-010`). | 20 |
| Blood Scanner | Epic (1×2) | 1 | 5 s | 2 (target must stand still, they see a prompt to accept or refuse: refusing is itself a clue) | "INFECTED" or "CLEAN", shown to both players and to anyone within 8 as a beep and light colour on the device model (`MDL-ITM-071`) | 20 |

- Scanning animations `ANIM-INF-010` (user) and the target sees the device pointed at them. Moving out of range cancels it.
- The thermometer can be fooled by early infection (under 30%), on purpose.

## 9.10 Death of a Sleeper: Sprinter and Ghost Guidance

- When a Sleeper dies (second bite, or health 0, never Downed), their body mutates in place (`VFX-MUT-010`, 1.5 s, `SFX-MUT-001`) into an AI **Sprinter** (`08` §8.8) wearing their gear visuals and carrying their backpack.
- The dead player becomes its **Ghost**: a desaturated thermal camera orbiting the Sprinter (boom 10), seeing Humans and Sleepers alike as heat silhouettes within 40 (`VFX-MUT-003`). They can't steer the Sprinter's legs or attacks.
- **Ghost tools** (`UI-GHO-001`, 4 buttons; every target must be within range of the Sprinter's position):

| Tool | Range | Effect | Cooldown |
|---|---|---|---|
| Slam & Lock Door | 30 | A door slams shut (noise 50) and can't be opened for 6 s | 20 s |
| Trigger Alarm / Trap | 40 | Sets off an alarm or trap (`06` §6.8) | 30 s |
| Smash Glass | 30 | Breaks a glass pane or display (noise 120) | 25 s |
| Flashlight Interference | 25 | Target human's flashlight flickers violently for 4 s (off 70% of the time) | 30 s |

- Any human affected by a Ghost tool becomes the Sprinter's priority target for 10 s.
- When the Sprinter is killed, it drops the original backpack (`11` §11.9) and the Ghost becomes a spectator (squad or free camera on the raid).
- Ghosts earn Mutant Rep (`13` §13.6).

## 9.11 Stalker Mutant (incubation ran out)

- When incubation hits 0, the Sleeper mutates on the spot (`VFX-MUT-010`, `SFX-MUT-002` scream audible mall-wide). Their backpack and loot drop as a corpse container (`11` §11.9). They become a **Stalker Mutant**, played by them.
- **Kit:** HP 250. Run 20, sprint 26, no stamina. Claw (LMB) 30 damage, 0.7 s, 40% light bleed. Pounce (RMB toward a target within 12): a leap that deals 45 damage, knocks the target down 1 s and causes heavy bleed 50% of the time. 8 s cooldown. Climbs any wall (hold Climb). No fall damage. Crawls under Half shutters.
- **Senses:** noise pings (`06` §6.1) and flashlight beacons (`06` §6.3) within range. Night-vision tint (`VFX-MUT-004`).
- Can't loot, use items, open containers, extract, or speak on proximity voice (voice is muted for mutants to stop call-outs from the "dead"; quick-lines are replaced by roars `SFX-MUT-010…013`).
- AI ignore Stalker Mutants and the reverse (no damage between them).
- On death it ragdolls and the player becomes a spectator. Clips `ANIM-MUT-001…008`, model `MDL-MUT-001` (built from the player's survivor with mutation overlays).

## 9.12 The Supermutant

- **Becomes one:** the Sleeper who triggered a Lockdown (`10` §10.6), or a Sleeper who bought the paid transformation (§9.13). Only one Supermutant can exist at a time; any other Sleeper who triggers a Lockdown while one exists becomes a Stalker Mutant instead (the Lockdown still happens).
- Transformation: 2.5 s, invulnerable, `VFX-MUT-011`, `SFX-MUT-003` (roar), `MUS-RAID-020` (Lockdown theme starts). Backpack drops as a corpse container.
- **Brute (default variant) kit:**

| Ability | Input | Effect | Cooldown |
|---|---|---|---|
| Slam | LMB | 55 damage in a 6-stud frontal arc; 25% fracture, 50% heavy bleed; breaks glass and barricades | 1.2 s |
| Charge | Shift + move (gamepad LB, mobile Charge button) | 14-stud dash at 45; 70 damage to the first human hit, knocks them down 1.5 s; breaks Destructible walls, shutters, barricades, glass | 10 s |
| Echolocation Screech | E (gamepad Y, mobile Screech button) | Roar heard mall-wide. For 9 s, every human within 55 who is moving, shooting or has a flashlight on is outlined through walls for the Supermutant. Humans within 11 get Sonic Stun: heavy blur 2 s, held flashlight switches off for 4 s. Humans who are holding breath and fully still aren't outlined. | 25 s |
| Wall and ceiling run | passive | runs on any surface at full speed; drops from ceilings with a 30-damage landing hit in radius 4 | — |

- **HP:** 1200 + 300 per living human above 2 inside the evac area at transformation (for a paid transformation: per living human in the raid above 2, capped at 3000).
- **Weaknesses:** UV Stun Flare blinds it 4 s; headshots ×1.5; molotov fire does full damage.
- **Death:** a 10 s **revive prompt** appears (§9.14). If not bought, it dies (ragdoll, `SFX-MUT-004`), and the player becomes a spectator.
- **Variants** (Feature F9, sidegrades; the transforming player's selected variant is used):

| Variant | Changes from Brute |
|---|---|
| Banshee | Screech radius 80 and cooldown 18 s; Sonic Stun radius 14; HP ×0.8 |
| Creeper | Surface speed ×1.3; Charge cooldown 7 s; HP ×0.75; Slam 45 |
| Juggernaut | HP ×1.4; no ceiling run (walls only); Slam radius 8; Charge cooldown 14 s |

- Clips `ANIM-MUT-010…020`, models `MDL-MUT-010…013`, sounds `SFX-MUT-020…035`.

## 9.13 Paid transformation (Supermutant on demand)

- Product **"Mutate Now"** (199 R$, `19` §19.4). Shown only to a living Sleeper, from 300 s into the raid, while no Supermutant exists and the raid isn't in Lockdown or Reopen. Opened from the Sleeper's inventory screen (never auto-prompted).
- On purchase: immediate transformation (§9.12). If Red Alert hasn't started, it starts now (120 s countdown), the "siren event early".
- If the receipt arrives after the conditions stop being true (e.g. the player died), the purchase is stored as a **Mutate Token** on the profile, usable in a later raid.

## 9.14 Second-chance revive (10 s prompt)

- Product **"Second Wind"** (79 R$, `19` §19.4). When a Supermutant reaches 0 HP, a 10 s prompt appears on that player's screen only (`UI-MUT-010`, `STR.MUT.REVIVE`). Buying it revives the Supermutant at full HP with an explosive roar (knockback 10 studs within radius 12, `VFX-MUT-012`). Once per Supermutant life.
- During the 10 s the Supermutant is invulnerable and frozen in a kneeling pose (`ANIM-MUT-019`), so humans see the prompt window as a pause.
- If the receipt arrives after the 10 s window, the purchase becomes a **Revive Token** (used automatically at the next Supermutant death, which then skips the prompt).
- Available in every raid, including private raids.

## 9.15 Mutant rewards

Mutant Rep (`13` §13.6): Stalker Mutant +20 per human downed, +40 per kill; Supermutant +40 per kill, +100 for winning a Lockdown (no human extracts from it); Ghost +15 per human downed by its Sprinter, +5 per tool use followed by a struggle within 10 s. Mutant Rep unlocks mutant cosmetics on the Mutant Track (`13` §13.6).
