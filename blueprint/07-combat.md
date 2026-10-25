# 07 · Combat: guns, melee, shove, takedowns, throwables

Owner of: aiming and firing, recoil and sway, reload and weapon handling, ammo, attachments, armour, damage rules, PvP rules, hit feedback, melee, shove, stealth takedowns, throwables, and aim assist. Numbers are in `02` §2.8.

---

## 7.1 Weapon slots and handling

- Equip slots: **Primary** (any gun), **Secondary** (pistol only), **Melee**. Holstered weapons show on the body (back for long guns, thigh for pistol, hip for melee; existing holster code).
- **Swap:** X cycles Primary → Secondary → Melee (gamepad Y, mobile weapon wheel tap). 1, 2, 3 select directly on PC. Swap time 0.6 s (pistol 0.4 s). Clips `ANIM-WPN-001…006`.
- **Holster:** B puts the weapon away (needed for climbing ladders, using two-handed items, and showing the hands-up emote).
- **Pickup:** walking over isn't enough. Hold Context 0.4 s on a world item (`ANIM-ACT-010`, with rifle-held variant `ANIM-ACT-011`).

## 7.2 Aiming and firing

- **No hip fire** (`Combat.AllowHipFire = false`). Firing needs Aim (PC RMB hold, gamepad LT, mobile Aim button which toggles).
- **Aim:** camera pulls in to 4.8, FOV 50, near-blur on your character, body faces the aim point, aimed walk speeds (02 §2.3). Aim IK blends the arms toward the camera aim point (`WeaponPose.AimIkBlend = 0.6`).
- **No crosshair on PC.** Players aim with the weapon's line and the muzzle. Mobile and gamepad get a **dim centre dot** (2 px, 40% opacity) only while aiming, because the camera can't be steered as precisely (`AimDot.Mobile = true`). This is the one exception to the no-crosshair rule and it gives no hit information.
- **Firing:** LMB (gamepad RT, mobile Fire button, shown only while aiming). Shots are hitscan from the barrel to the camera aim point, validated on the server.
- **Server validation:** the client sends `{weaponId, origin, direction, clientTime, hitPart?}`. The server checks the origin is within 3 studs of the muzzle, the fire rate, the ammo, and line of sight, rewinding target positions by up to 250 ms (lag compensation, `Combat.RewindMax = 0.25`). The server decides damage.
- **Instant local feedback:** muzzle flash, recoil, sound and the tracer play on the client at once. Blood and impact decals play when the server confirms.

## 7.3 Recoil and sway

| Gun | Vertical kick per shot | Horizontal (random ±) | Recovery per second | Sway factor |
|---|---|---|---|---|
| P9 | 1.6° | 0.5° | 10° | 1.0 |
| Wasp | 0.9° | 0.6° | 12° | 1.1 |
| Brace | 5.0° | 1.0° | 8° | 1.0 |
| Kestrel | 1.1° | 0.45° | 11° | 1.2 |
| Longhorn | 6.0° | 0.8° | 6° | 1.5 |

- Recoil moves the camera aim point (the player has to pull down). Grip attachment ×0.75 vertical. Arm fracture ×1.3.
- Sway: `0.4° × (2 − aimStability) × swayFactor`, a slow figure-eight. Hold breath while aiming (HoldBreath key) cuts sway by 70% and drains stamina at 20/s.

## 7.4 Reload and ammo

- R (gamepad X, mobile reload button). Reload times: P9 1.6 s, Wasp 2.2 s, Brace 0.55 s per shell (interruptible), Kestrel 2.4 s, Longhorn 0.7 s per round. Arm fracture ×1.4. Clips `ANIM-WPN-010…016`.
- Reloads pull ammo from the backpack, pockets and quick slots (nearest first). A partial mag keeps its rounds (no mag loss).
- **Ammo types:** Light (P9, Wasp), Medium (Kestrel), Heavy (Longhorn), Shells (Brace). Ammo boxes are 1×1 and stack to 60 (Light), 60 (Medium), 20 (Heavy), 24 (Shells).
- Empty click sound `SFX-WPN-030` when you fire dry.

## 7.5 Attachments

| Attachment | Slot | Effect | Fits |
|---|---|---|---|
| Red Dot Sight | Sight | Aim FOV 45 instead of 50, faster aim-in (0.15 s instead of 0.25 s) | Wasp, Kestrel, P9 |
| 4× Scope | Sight | Aim FOV 20, sway ×1.2 | Kestrel, Longhorn |
| Suppressor | Muzzle | Noise 50 instead of 250, damage ×0.9 | P9, Wasp, Kestrel |
| Extended Mag | Mag | Mag ×1.5 (rounded down), reload ×1.1 | P9, Wasp, Kestrel |
| Foregrip | Underbarrel | Vertical recoil ×0.75 | Wasp, Kestrel, Brace |

- Attachments are items (1×1). Attach from the inventory screen by dragging onto the weapon (0.5 s, can be done in raid). Attached parts are lost with the weapon.
- Visible on the weapon model (`MDL-WPN-020…024`).

## 7.6 Damage rules

- Damage by zone: head ×2.0 (players) or ×3.0 (Walkers, Crawlers), torso ×1.0, limbs ×0.7 (02 §2.8). Range falloff per gun: full damage to the falloff start, then linear down to the min damage at 2× the falloff start.
- **Armour:** torso damage reduced by the vest (Light 30%, Heavy 50%) while durability lasts. Durability drops by damage absorbed. At 0 the vest does nothing until repaired at the workbench (`12` §12.5). Helmet turns head ×2.0 into ×1.4 while durability lasts.
- Armour weight: Light vest 4 kg (3×3), Heavy vest 9 kg (3×3), Helmet 2 kg (2×2).
- **Explosions:** none in the launch build.

## 7.7 PvP rules

- **Squadmates:** friendly fire OFF (bullets pass through squadmates with no damage). Slide tackles on squadmates still ragdoll them (the fun clip). Molotov fire damages squadmates at 50%.
- **Strangers:** full damage.
- **No hostility markers.** Shooting a stranger reveals nothing on screen. The only consequences are bounties (`17`), what the victim saw and heard, and the radio bounty call.
- **Kill credit** for bounty and stats goes to whoever dealt the final damage. "Unprovoked kill" (for bounties) = you killed a human who hadn't damaged you or your squad in the last 30 s and who wasn't a mutant (`17` §17.2).
- Spawn protection blocks PvP damage for 20 s (`03` §3.3).

## 7.8 Hit feedback (no hitmarker)

- No hitmarker, no damage numbers, no kill feed.
- **Attacker feedback:** a dull flesh-impact thud on hit (`SFX-WPN-040`, 3D at the target, heard by the shooter at +3 dB), the target's hit reaction animation (`ANIM-HIT-001…004` by zone) and blood (`VFX-HIT-001`). Headshots play a distinct crack (`SFX-WPN-041`).
- **Victim feedback:** camera hit punch toward the source, a direction-of-damage blood smear on the screen edge (`UI-HUD-020`, 1 s), health screen effects.

## 7.9 Melee

| Weapon | Damage | Swing | Range | Extra |
|---|---|---|---|---|
| Fists (no melee equipped) | 8 | 0.5 s | 2.5 | — |
| Pipe | 25 | 0.6 s | 3.5 | — |
| Crowbar | 30 | 0.75 s | 3.5 | pries locked stockrooms (hold 6 s) |
| Fire Axe | 50 | 1.1 s | 4.0 | breaks a barricade in 1 hit |

- Light attack: LMB with Melee equipped (no aim needed). Heavy attack: hold LMB 0.6 s, ×1.8 damage, ×1.6 swing, 15 stamina.
- Hits on Walkers stagger them 0.6 s. Melee noise 15.
- Clips: 3 light swings in a chain per weapon class (blunt, axe), plus heavy (`ANIM-MEL-001…010`).
- **Teammate intercept:** any melee or bullet hit on a zombie that's grappling someone ends the struggle (`09` §9.2).

## 7.10 Shove

- Context tap while facing a target within 2.5 studs, no weapon aimed (gamepad RB, mobile shove button that replaces Fire when not aiming). 10 stamina, 1.0 s cooldown. 6-stud knockback, 0 damage.
- On a zombie grappling a squadmate or stranger: ends the struggle (teammate intercept).
- On a player: staggers them 0.5 s (cancels their channelled actions).
- Clip `ANIM-MEL-011`.

## 7.11 Stealth takedown

- Crouched, behind an unaware Walker or Crawler (its state isn't `Chase` or `Alert`), within 3 studs and inside its rear 120°. Prompt appears (`UI-HUD-030`). Hold Context 1.2 s. Silent kill. Clips `ANIM-MEL-020/021` (paired).
- Interrupted if the target turns (it hears a noise) or you're hit.

## 7.12 Throwables

- **Throw:** hold Throw (PC G, gamepad RB hold, mobile throw button in the quick bar) to wind up (0.3 s minimum), aim with the camera, release to throw. Throw strength scales with hold time up to 1.0 s (range 10 → 30 studs). No arc preview (design choice). Server simulates, clients draw (existing `Services.Throwables`). Clips `ANIM-THR-001/002`.
- Thrown items come from the quick slots or the inventory.

| Throwable | Size | Effect | Source |
|---|---|---|---|
| Bottle | 1×1 | Shatters on impact: noise 60 at the landing point. Breaks Small and Medium glass. | Common loot |
| Brick | 1×1 | Noise 40 on landing. Breaks any glass. Stuns a Walker 1 s on a head hit. | Common loot |
| Noise Decoy | 1×1 | Lands, then after 3 s plays an alarm: noise 150 multi-floor for 12 s. | Crafted (Radio + Wire) or Uncommon loot |
| Molotov | 1×1 | Fire patch radius 5 for 10 s: 15 dmg/s, zombies avoid it, humans take 15 dmg/s, Light Bleed doesn't apply. Light source. | Crafted (2 Alcohol + Rag) |
| UV Stun Flare | 1×2 | Lands and blazes for 8 s. Stuns The Janitor (6 s) and blinds Stalker Mutants and Supermutants within 10 (vision whites out, 4 s) the first time they're in its light. Light source. | Crafted (Flashlight + Tape + Battery) |
| Smoke Can | 1×1 | Smoke cloud radius 8 for 15 s that blocks sight (zombie and player). | Uncommon loot |

## 7.13 Aim assist (mobile and gamepad only)

- On while aiming, if the setting is on. Magnetism: when a valid target's centre mass is within 4° (AI) or 2° (players) of the aim point, the aim point is pulled toward it at up to 20°/s. Slowdown: look sensitivity ×0.6 while the aim point is within 6° of a target.
- Never through walls. Never on Sleepers in a different way from Humans (they're identical targets).
- PC mouse: none.
