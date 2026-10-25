# 05 · Stats, fear, stamina, health, injuries and medical

Owner of: the Stats v2 graph, survivor attributes, fear, stamina, health, body-zone injuries, bleeding, medical items, Downed and revive, and the stat outputs to camera, audio and AI. Numbers are in `02` §2.4.

---

## 5.1 Stats v2 (port, then extend)

- The existing data-driven graph is kept: `Shared.Stats.Defs` rows (`name, layer, op, args`), `Stats.Graph.build` (rejects duplicates, unknown names, cycles and backward links), `Compute.run(snapshot, overrides)`, curves in `Stats.Config.Curves`. Its tests (Stats 48, Graph 31) must keep passing.
- **Layers:** Survivor attributes → Mechanical values → Primary stats (Health, Stamina, Fear, Infection) → Derived (never stored) → Outputs.
- **Server:** `Services.Stats` ticks at 10 Hz and owns the primary stats. It sends an owner-only packet on `Net.StatsState`. Stamina is simulated on the client and mirrored with plausibility checks (server rejects a client stamina value more than 15 above its own estimate).
- **Change from the old place:** five attributes instead of four, pool 25 instead of 20 (`02` §2.4). `Stealth` moves from Reserved to Enabled. `Agility`, `Dexterity`, `Resilience` and `Perception` stay reserved and unused.

## 5.2 Attributes

| Attribute | Mechanical value | Curve (3 / 4 / 5 / 6 / 7) |
|---|---|---|
| Endurance | `maxStaminaMult`, `staminaRegenMult` | 0.80/0.90/1.00/1.12/1.25 · 0.85/0.92/1.00/1.10/1.20 |
| Strength | `baseCarry` (kg) | 10/12/14/16/18 |
| Composure | `fearGainMult`, `incubationMult` | 1.00/0.93/0.85/0.78/0.70 · 0.90/0.95/1.00/1.05/1.10 |
| Marksmanship | `swayMult` | 1.25/1.12/1.00/0.90/0.80 |
| Stealth | `noiseMult` | 1.15/1.08/1.00/0.92/0.85 |

Fixed for everyone (PvP fairness): base speeds, max health 100, base noise radii.

## 5.3 Derived values and outputs

```
encumbrance  = carryWeight / maxCarry            (maxCarry = baseCarry + packBonus)
moveSpeed    = base[state] × fearBoost × carryMult(sprint only, plus overweight walk) × injuryMult × lowHealthMult
staminaDrain = base[state] × carryDrainMult
aimStability = 1 − fearPenalty − boostPenalty − lowStaminaPenalty − lowHealthPenalty − armFracture   (then × 1/swayMult)
noiseRadius  = base[state] × noiseMult × carryNoiseMult × injuryNoiseMult
visibility   = stanceFactor(stand 1, crouch 0.6) × lightFactor(lit 1, dark 0.375)   (lightFactor from 06 §6.3)
```

| Penalty | Value |
|---|---|
| fearPenalty | 0 at fear ≤ 30, linear to 0.35 at fear 100 |
| boostPenalty | 0.30 while fear boost is active |
| lowStaminaPenalty | 0.20 below 20 stamina |
| lowHealthPenalty | 0.15 below 25 health |
| armFracture | 0.25 per fractured arm |

`aimStability` drives weapon sway amplitude: sway = 0.4° × (2 − aimStability) × gun sway factor (`07` §7.3).

**Outputs** (read-only consumers): zombie hearing (noiseRadius), zombie sight (visibility), camera effects (`04` §4.11), weapon sway, breathing audio, heartbeat audio, vignette pulse, footstep volume.

**Link table** (from → to : effect), kept from the stats design:

| From | To | Effect |
|---|---|---|
| scare event | fear | + spike × fearGainMult |
| damage taken | health / fear | − / + small (damage × 0.3) |
| carry weight, maxCarry | encumbrance | ratio |
| movement state | stamina drain, move speed, noise, visibility | state multipliers |
| stamina regen | stamina | + per second |
| fear | fear boost | above 60, timed, capped |
| fear | aim stability, screen shake, vignette pulse, breathing | −, +, +, + |
| fear boost | move speed / aim stability / stamina | + temporary / − while active / − regen after |
| stamina | move speed, aim stability, breathing | sprint cut at 0, shaky below 20, heavy breath below 30 |
| health | move speed, aim stability, vignette | slower, shakier, pulse below 50 |
| encumbrance | sprint speed, stamina drain, noise | −, +, + |
| move speed | noise, shake, FOV, footsteps | + |
| noise | zombie hearing, footsteps | signal, volume |
| visibility | zombie sight | signal |
| zombie hearing/sight | scare event | feedback loop (capped, §5.4) |

## 5.4 Fear

- Range 0–100. Server-owned. `Stats.Scare(player, kind, amount)` applies `amount × fearGainMult`.
- **Only perceptible threats add fear.** A zombie noticing you (that you can't see or hear) adds none.

| Scare kind | Amount | Cooldown per source |
|---|---|---|
| First sight of a zombie within 15 | +8 | 10 s per zombie |
| Zombie lunge at you (struggle start) | +25 | — |
| Taking damage | damage × 0.3 | — |
| Sudden loud sound within 20 (glass, alarm, door slam, gunshot not yours) | +6 | 3 s |
| Seeing The Janitor within 30 | +20 | 20 s |
| Hearing The Janitor's cart within 40 (first time per approach) | +10 | 30 s |
| Squadmate Downed within 30 | +15 | — |
| Red Alert start | +15 | — |
| Lockdown slam | +30 | — |
| Supermutant screech within 15 | +20 | — |
| Stalker Mutant pounce at you | +20 | — |

- **Decay:** −4/s once no threat is within 30 for 5 s.
- **Fear boost (adrenaline):** fires once when fear rises past 60. +15% move speed for 4 s, aim stability −30% during it, then stamina regen −50% for 6 s. Re-arms when fear falls below 40, with a 20 s minimum cooldown (`Fear.BoostCooldown = 20`).
- **Feedback loop guard:** fear → speed → noise → zombies notice → fear. Capped by the boost duration, cooldown and recovery penalty. Tune in S8 so it feels like a tense chase, not a spiral.
- **Fear outputs:** heartbeat audio from fear 40 (`SFX-PLR-010`, rate 60 → 140 bpm at 100), breathing `SFX-PLR-011…013`, camera fear shake, hand tremor (aim sway).

## 5.5 Stamina

- Values in 02 §2.4. Spent by sprint (12/s), roll 20, slide 15, vault/mantle/window 10, shove 10, heavy melee 15, hold breath 20/s.
- Regen 15/s × staminaRegenMult after 1.0 s of no spending. During the fear boost recovery, regen ×0.5.
- At 0: sprint cuts out, rolls and shoves are blocked until 20, breathing is heavy, aim stability −0.2.
- **Hold breath** (counter to the Supermutant's echolocation): hold `HoldBreath` (PC Ctrl, gamepad L1, mobile breath button). While held and fully still you're invisible to echolocation. Ends at 0 stamina with a loud gasp (noise 25, `SFX-PLR-014`).
- Stamina is never shown as a number. HUD shows breath via screen and audio only (`21` §21.4). An optional thin stamina arc next to the weapon panel appears only while draining (`21` §21.4).

## 5.6 Health and body zones

- One health pool, 100, plus zone states. Server-owned.
- **Zones:** Head, Torso, Left Arm, Right Arm, Left Leg, Right Leg. Each hit is attributed to a zone by the hit part.
- **Fractures:**
  - **Leg:** from falls 12–20 (30% chance), falls 20–30 (100%), Janitor grab, Supermutant slam (25%), limb shots of 20+ damage (15%). Effect: no sprint, walk ×0.7, footstep noise ×1.5, limp clip.
  - **Arm:** from limb shots of 20+ damage (15%), Supermutant slam (25%). Effect: aim stability −0.25, reload time ×1.4.
- **Bleeding:**
  - **Light bleed:** 1 dmg/s. From Sprinter swipes (25%), Stalker Mutant claws (40%), shotgun pellets (10% per hit), glass climb-through without breaking first (not possible: glass must be broken).
  - **Heavy bleed:** 3 dmg/s. From Supermutant slam (50%), Stalker pounce (50%), any single hit of 40+ damage (30%).
  - Bleeding leaves a **blood trail** decal every 2 studs moved (`VFX-PLR-003`), lasting 60 s. Zombies, Sprinters and mutants follow blood trails as a scent (`08` §8.3).
- **Low-health effects:** below 50: edge desaturation and heartbeat pulse. Below 25: dark vignette, speed ×0.9, aim penalty, laboured breath.
- **Natural regen:** none in raids. In the tower, health and injuries reset fully on return.

## 5.7 Medical items

All medical use is a channelled action. Moving at more than walk speed, or taking a hit, cancels it (the item isn't used up if cancelled before 50%).

| Item | Size | Use time | Effect | Tier | Clip |
|---|---|---|---|---|---|
| Bandage | 1×1 | 2.0 s | stops light bleed (heavy bleed becomes light), +5 health | Common | `ANIM-MED-001` |
| Gauze Pack | 1×1 | 2.5 s | stops any bleed, +10 health | Uncommon | `ANIM-MED-001` |
| Painkillers | 1×1 | 1.0 s | for 60 s: ignore fracture speed limits (still noisy), aim penalty from fractures halved | Uncommon | `ANIM-MED-002` |
| Medkit | 2×2 | 5.0 s | +60 health over the channel (12/s), stops light bleed | Rare | `ANIM-MED-003` |
| Splint | 1×2 | 4.0 s | removes one fracture (leg first, then arm) | Uncommon | `ANIM-MED-004` |
| Surgical Kit | 2×1 | 7.0 s | removes all fractures and heavy bleed, +25 health | Epic | `ANIM-MED-005` |
| Infection Suppressant | 1×1 | 1.5 s | pauses incubation 90 s; on a Human it does nothing but is used up | Rare | `ANIM-MED-006` |
| Improvised Suppressant (crafted) | 1×1 | 2.0 s | as above | crafted | `ANIM-MED-006` |
| Antidote Syringe | 1×1 | 3.0 s | cures infection completely (Sleeper → Human, struggle counter resets to 1) | Exotic (fixed spawns, `09` §9.7) | `ANIM-MED-006` |
| Adrenaline Shot | 1×1 | 1.0 s | +40 stamina, triggers a fear boost (ignores cooldown), +10 fear | Rare | `ANIM-MED-006` |

- **Healing others:** Bandage, Gauze, Medkit and Splint can be used on a squadmate or a stranger within 3 studs (target must stand still). Use time ×1.25. Both see the action. Healing a stranger is +25 XP.
- **Tainted items** (Sleeper sabotage, `09` §9.6): a tainted Medkit, Bandage or Gauze looks and works normally, then bites the user (Human → Sleeper; Sleeper → no effect) at the end of the channel. A tainted item shows a faint dark vein texture **only under a flashlight beam within 3 studs** (`TEX-ITM-030`), which is the one clue.

## 5.8 Downed and revive

- Downed rules in `03` §3.5. Downed players crawl at 2 (`ANIM-MOV-017`), can't use items, can ping and use quick-lines, and bleed out in 30 s (a bar on their own screen only).
- **Revive:** a squadmate or a stranger holds Revive (Context) for 4 s within 2.5 studs (`ANIM-MED-007` both sides). The revived player returns at 25 health with existing injuries. Reviving a stranger: +50 XP for the helper and a "Helped by a stranger" tally in the revived player's results (`13` §13.5).
- A Downed player who's hit for 25+ more damage dies.
- Zombies prioritise lunging at Downed players they can see (struggle bar shows normally; the Downed player can still win it).
