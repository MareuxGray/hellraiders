# 03 · Raid flow

Owner of: the raid state machine, deploying, spawning, the raid clock, player life states, death, disconnects, leaving, results, payouts, the Orientation Run, and edge cases. Evac details are in `10`, infection in `09`, matchmaking in `20`.

---

## 3.1 Places and travel

- Universe places: **Arrival** (start place: loads the profile and routes the player, `14` §14.2), **Tower** (lobby), **Mall** (raid place). The Orientation Run uses the Mall place with `RaidMode = "Orientation"`.
- Tower to raid: the matchmaker (`20` §20.8) reserves a Mall server (`TeleportService:ReserveServer`) and teleports the matched players with teleport data `{raidId, mode, squads, catalyst?, privateRaid?}`.
- Raid to tower: on extract, death-exit or raid end, players teleport back to **their own tower** (their residency tower id from the profile; `14` §14.4). If that tower's live instance is full, they go to its Annex.
- Profiles are saved and released before every teleport and loaded with a session lock on arrival (`25` §25.5).

## 3.2 Raid server states

| State | Enters when | Lasts | What happens |
|---|---|---|---|
| `Loading` | server starts | until all expected players arrive or 30 s | Map is ready, loot is rolled (`11` §11.6), world items are claimed from the pool (`18` §18.3), the catalyst is applied (`19` §19.7). Arriving players see the freight-lift interior (`MDL-RAID-001`), with a gate number and their squad visible. |
| `Deploy` | Loading ends | 6 s | Lift descent sequence: siren `SFX-RAID-001`, lights flicker, doors open at the entry gate. Camera is player-controlled inside the lift. |
| `Active` | lift doors open | until Red Alert starts | Raid clock runs. Spawn protection for 20 s. The Janitor enters at 480. Terminals unlock at 600. |
| `RedAlert.Countdown` | terminal activated, or 1020 failsafe, or a paid early Supermutant mutation (`09` §9.13) | 120 s | Sirens, red strobes, horde surge, exit revealed (`10`). |
| `RedAlert.Open` | countdown ends | 45 s, or until early depart | Evac zone open. |
| `Lockdown` | departure check finds a Sleeper inside | 90 s | Doors lock, Supermutant transformation (`10` §10.6). |
| `Reopen` | Lockdown ends with at least one living human inside the evac area | 30 s | Doors unlock, final departure (`10` §10.7). |
| `Sealed` | Open/Reopen ends with no lockdown, or the Lockdown ends with no living humans | 3 s | Everyone still in the mall who didn't extract dies (cause "Sealed in"). Mutant players are released. |
| `Results` | after Sealed | 8 s | Remaining clients see the raid summary and teleport home. The server shuts down after the last teleport. |

Only one Red Alert happens per raid. Once triggered, terminals go dark.

## 3.3 Spawning

- Four basement entry gates: **Gate A** (north-west), **Gate B** (north-east), **Gate C** (south-west), **Gate D** (south-east). Positions are in `23` §23.4.
- Squads are spread across the gates in this order: A, D, B, C, A, D… so the first two squads are on opposite corners. A squad always spawns together in one lift.
- In the Trio pool (4 squads) each gate gets one squad. In the Solo pool (10 players) gates get 3, 3, 2, 2.
- **Spawn protection (20 s):** no PvP damage dealt or taken; zombies within 40 studs of a gate are idle and don't aggro. Protection ends early for a player who fires a weapon.

## 3.4 The raid clock

- The clock is server-owned and replicated as `RaidStart` (server time) plus the current state.
- Players see time only on their **wristwatch**: hold `Watch` (PC `T`, gamepad D-pad down, mobile watch button) to raise the left wrist (`ANIM-ACT-020`) and show MM:SS elapsed and the next event ("Terminals live", "Evac in 1:42"). There's no always-on timer on the HUD until Red Alert (`21` §21.4).
- At 600 (terminals unlock) every player hears the PA chime `SFX-RAID-004` and a subtitle: `STR.RAID.TERMINALS_LIVE`.
- At 960 (one minute before the failsafe) the PA warns `STR.RAID.FAILSAFE_SOON` with `VO-PA-003`.

## 3.5 Player life states

| State | How you get there | You can | Others see |
|---|---|---|---|
| `Human` | spawn | everything | a survivor |
| `Sleeper` | bitten once (`09` §9.3) | everything a Human can, plus sabotage actions (`09` §9.6) | a survivor, plus symptoms over time |
| `Downed` | health reaches 0 from damage that isn't instantly lethal (bullets, swipes, bleed) and a squadmate is alive in the raid | crawl at 2, ping, quick-lines; bleed out in 30 s; a squadmate can revive (hold 4 s, uses no item, back at 25 health) | a downed survivor |
| `Dead` | bleed-out, killed while Downed, instantly lethal damage (fall > 30, Janitor grab at ≤ 60 health, Sealed in), or Downed with no living squadmate | spectate squadmates (or the killer if solo) and leave to the tower | a corpse with the backpack (`11` §11.9) |
| `Sprinter (Ghost)` | a Sleeper killed by a second bite or by damage | Ghost Guidance tools (`09` §9.10) | an AI Sprinter |
| `StalkerMutant` | incubation runs out | play as the Stalker Mutant (`09` §9.11) | a mutant |
| `Supermutant` | Lockdown, or paid early mutation | play as the Supermutant (`09` §9.12) | the boss |
| `Extracted` | departed from the evac zone | watch the summary and leave | gone |

- A **Sleeper who reaches 0 health** becomes a Sprinter (Ghost), never Downed.
- A Downed player who is bitten (Walkers lunge at downed players) is killed if already a Sleeper, otherwise becomes a Sleeper and stays Downed.

## 3.6 Leaving early

- **Tower menu > Leave raid** while alive opens a confirmation (`STR.RAID.LEAVE_CONFIRM`): leaving counts as death. You lose what you carried except the Safe Pocket and Blueprint Slot, and the survivor dies.
- Dead players can leave at any time with no extra cost. They get the death payout.

## 3.7 Disconnects

- On disconnect the character stays in the world for 120 s (`Raid.ReconnectWindow`). It's motionless but can be damaged, looted only if killed, and bitten (counts normally).
- The profile stores `pendingRaid = {placeId, accessCode, raidId, expires}`. If the player rejoins the game within the window, they're teleported straight back into the raid and resume control.
- If the window passes, the character dies (cause "Lost signal") and the normal death rules apply. The corpse stays lootable.
- If the raid server closes while a player is disconnected, the result applies: extracted if they had already departed, otherwise dead.

## 3.8 Results and payouts

**Extracted:**
1. All items carried (equipped, pockets, backpack, quick slots, Safe Pocket, Blueprint Slot) move to the stash. If the stash is full, overflow goes to the **Overflow Crate** in the flat (`15` §15.6), held 7 days. A warning appears before the next deploy.
2. **Haul tally screen** (`UI-RES-001`, `03`-style spectacle): items slide into a grid one by one, sorted by tier from low to high. Each shows its tier colour, and the MC value counts up (`SFX-UI-020` tick, tier stingers `SFX-LOOT-001…006`). New blueprints pop with `STR.RES.BLUEPRINT_NEW`, and Relics get their own full reveal (`18` §18.6).
3. XP: 100 for extracting + 1 XP per 100 MC of haul value (max 300) + 50 per human revived + 25 per zombie killed (max 250) + 150 if cured this raid + 200 for surviving a Lockdown.
4. Contract and achievement progress (`13`).

**Died:**
1. You lose everything you carried except the Safe Pocket and Blueprint Slot, which go to the stash.
2. The survivor is retired. Its rolled attributes and any role title are gone (`13` §13.2). Account level, stash, blueprints and flat stay.
3. Death payout: 300 MC + 50 XP, plus 25 XP per zombie killed (max 250).
4. On your next tower visit the **Survivor Draft** opens: pick 1 of 3 new survivors (`13` §13.2).

**Mutant outcomes:** a Stalker Mutant or Supermutant player is "Dead" as a human (loses carried items, as above) but earns **Mutant Rep** (`13` §13.6): +20 per human downed, +40 per human killed, +100 for winning a Lockdown (no human extracts from that Lockdown).

**Cured:** a Sleeper who uses an Antidote is fully Human again (counter and symptoms cleared).

## 3.9 Orientation Run (first raid only)

- Triggered for profiles with `orientationDone = false`. Solo, in the Food Court wing only, with the rest of the mall gated by shutters.
- Script (all prompts are icon-first with a short string; `21` §21.8):
  1. Lift opens. Prompt: move and look (`STR.TUT.MOVE`).
  2. Search a till (teaches hold and reveal; guaranteed Uncommon item).
  3. Crouch past a Walker facing away (`STR.TUT.CROUCH`). Takedown prompt if close.
  4. Throw a bottle to lure a second Walker (`STR.TUT.THROW`).
  5. Guaranteed lunge from a third Walker: the struggle bar shows with the zone at 50% width (tutorial-only). On success: `STR.TUT.STRUGGLE_OK`. On failure the player is "bitten" in tutorial mode: veins vignette, `STR.TUT.BITTEN`, then finds an Antidote in the pharmacy kiosk.
  6. A Security terminal triggers a mini Red Alert (30 s countdown, 20 s open) to the food-court service lift.
  7. Extract. Haul tally shows. The player keeps the items found.
- About 4 minutes. Can't be failed: dying respawns at the last step. Sets `orientationDone = true`. Skippable from the tower settings for returning players (`STR.TUT.SKIP`).

## 3.10 Edge cases

- **All humans dead before Red Alert:** remaining mutant players keep playing until the failsafe sequence completes, or the server goes straight to `Sealed` if no human or mutant players remain connected.
- **Only Sleepers left alive:** they can still depart; a departure with only Sleepers inside triggers a Lockdown with no victims. It ends immediately as a mutant win, and the Sleepers extract nothing.
- **Can a Sleeper ever extract?** No. The departure check runs at every departure (Open, early depart and Reopen) and fails if any Sleeper is inside. A failed check during Open starts the Lockdown; a failed check during Reopen ends the raid (`10` §10.7). The only way out for a Sleeper is to be cured first.
- **A Sleeper is cured inside the zone before departure:** they count as Human at the check.
- **Incubation ends inside the zone during the Open window:** the player becomes a Stalker Mutant at once (not a Supermutant). The departure check only looks at Sleepers, so the lift can still go.
- **Player is Downed in the zone at departure:** they extract if alive, and are revived on arrival (back at 25 health in the tower; no effect).
- **Squad split across exits:** there's only one exit per raid.
- **Teleport fails:** retry 3 times with 2 s backoff (`TeleportService` error handling, `25` §25.4). If it still fails, return to the tower; for an arriving player, the result is treated as if they never deployed (gear refunded to the stash).
