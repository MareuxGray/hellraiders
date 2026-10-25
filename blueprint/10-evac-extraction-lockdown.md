# 10 · Red Alert Evac, departure, Lockdown and Reopen

Owner of: Security terminals, Red Alert, the two exits, the evac zone and evac area, the departure check, early depart, the Lockdown, the Reopen, sealing the mall, and the extraction cinematic. Numbers are in `02` §2.2.

---

## 10.1 Security terminals

- Three terminals (`MDL-ENV-070`): **Security Office** (2nd floor), **Food Court kiosk** (ground floor), **Garage booth** (basement). Positions in `23` §23.6.
- Locked (dark screen) until 600 s. At 600 they light up green (`SFX-RAID-004` chime mall-wide, `STR.RAID.TERMINALS_LIVE`).
- **Activate:** hold Context 5 s (`ANIM-ACT-031`, noise 60). Any human or Sleeper can do it. A progress ring shows on the activator's screen only. Interrupted by a hit or by moving more than 2 studs.
- Activation starts Red Alert for the whole raid. All terminals go dark. If nobody activates by 1020 s, Red Alert starts on its own (`STR.RAID.FAILSAFE`), from the Security Office.
- A paid "Mutate Now" (`09` §9.13) also starts Red Alert.

## 10.2 Red Alert: countdown (120 s)

- Mall-wide: sirens loop (`SFX-RAID-010`), red strobes in every wing (`VFX-ENV-010`, emergency lights brighten and pulse), PA voice `VO-PA-010` ("Evacuation authorised. Proceed to the {exit}."), music `MUS-RAID-010` (Red Alert theme). Fear +15 for every human.
- **Exit chosen** at random, 50/50: Rooftop Helipad or Basement Garage. Both are revealed to everyone: a HUD marker toward the exit (`UI-HUD-040`, the only objective marker in the game; squad tags and pings are squad-only, `20` §20.3–20.4), the PA names it, and wall signs along routes light up with arrows (`MDL-ENV-071`).
- **HUD:** an evac countdown appears top-centre (`UI-HUD-041`, MM:SS), from now until the raid ends.
- **Horde surge:** every AI enters `Surge` (`08` §8.2): ×2 chase speed, unlimited aggro range toward the exit zone, attacking humans on the way. 10 extra Walkers spawn at service doors.
- The Janitor heads to the exit and patrols the edge of the evac area. It never enters the evac zone.

## 10.3 The two exits

| Exit | Where | Evac area (lockable) | Evac zone (inside the area) | Departure visual |
|---|---|---|---|---|
| **Rooftop Helipad** | Roof, reached by the main stair tower and the Department Store service stair | Fenced rooftop cage, 40 × 40, with two gates (north stair, south stair) | Painted landing circle, radius 10 | Helicopter descends during the Open window (`MDL-RAID-010`, `SFX-RAID-020` rotor), lands at 0, lifts off with everyone in the zone |
| **Basement Garage** | Basement level, via the two car ramps and the service corridor | Garage bay behind two blast shutters (east ramp, service corridor), 50 × 30 | Freight lift platform, 16 × 12 | Freight lift doors close and it rises (`MDL-RAID-011`, `SFX-RAID-021`) |

- The evac zone is a server-side volume. Players inside see the zone floor glow (`VFX-ENV-011`).

## 10.4 Open window (45 s)

- At 0 on the countdown: the helicopter lands or the freight lift opens. Zone glow turns green. The HUD countdown restarts at 45.
- **Departure** happens when the window ends, or earlier by **early depart**: when every living Human and Sleeper in the raid (mutants excluded, Downed included) is inside the zone, any one of them can hold Context for 3 s (`STR.EVAC.DEPART`). With some players still outside, early depart isn't available.
- Players can enter and leave the zone freely during the window.

## 10.5 The departure check

At the moment of departure the server checks every player inside the zone:

- **No Sleepers inside:** everyone inside extracts (`Extracted`, extraction cinematic §10.9). Then the mall seals (`03` §3.2): everyone else dies.
- **Any Sleeper inside:** extraction fails. Go to Lockdown (§10.6).

Mutant players inside the zone never affect the check.

## 10.6 Lockdown (90 s)

1. Alarm buzz (`SFX-RAID-030`), and the helicopter aborts (pulls up and hovers out of reach) or the freight lift doors slam shut. Both evac area gates or blast shutters slam and lock (`SFX-RAID-031`). Camera slam shake. Fear +30.
2. The evac area is now sealed both ways for 90 s: nobody gets in or out. Players outside the area keep fighting zombies (the surge continues outside).
3. **The Sleeper who triggered it transforms into the Supermutant** (`09` §9.12), free. If several Sleepers were inside, one is chosen at random as the Supermutant (only if no Supermutant exists yet); the others become Stalker Mutants.
4. HUD countdown shows 90 (`STR.EVAC.LOCKDOWN`). Music `MUS-RAID-020`. The PA says `VO-PA-020` ("Contamination detected. Evac locked.").
5. Ends after 90 s:
   - **At least one living human (Human or Sleeper) inside the evac area:** go to Reopen.
   - **None:** mutant win. The mall seals (everyone dies), and the Supermutant gets +100 Mutant Rep.
   - **The Supermutant died** during the Lockdown: the Lockdown still runs to 90 s (the doors are on a timer), then Reopen.

## 10.7 Reopen (30 s)

- The gates or shutters unlock (`SFX-RAID-032`), the helicopter lands again or the lift reopens. Anyone can now enter or leave the evac area, including players who were outside.
- Departure at 30 s, or early depart as in §10.4.
- **Departure check again:** no Sleepers inside → everyone inside extracts, then the mall seals. Any Sleeper inside → the extraction fails for good: no second Lockdown. The helicopter or lift leaves empty, the Sleeper(s) inside become Stalker Mutants, and the mall seals (everyone dies). Mutant players get +100 Mutant Rep each.

## 10.8 Sealing

- When the sequence ends, every non-extracted human dies with cause "Sealed in". The screen fades to black with `STR.RAID.SEALED`. Mutant players fade out too, and are recorded as Dead for their human loss.
- `Results` follows (`03` §3.8).

## 10.9 Extraction cinematic

- On departure, extracted players see a 4 s scripted camera (`04` §4.11, no player control): the helicopter lifting off over the mall roof at night, or the freight lift rising through the shaft, with music sting `MUS-RAID-030` and `STR.EVAC.EXTRACTED`.
- Then the teleport to the tower and the haul tally (`03` §3.8).

## 10.10 Sound and VFX list

| Moment | Sound | VFX |
|---|---|---|
| Terminals live | `SFX-RAID-004` | terminal screens green |
| Terminal activation | `SFX-RAID-005` (beeps) | progress ring `UI-HUD-042` |
| Red Alert | `SFX-RAID-010` siren loop, `VO-PA-010` | `VFX-ENV-010` strobes |
| Helicopter approach / land / lift | `SFX-RAID-020` | rotor wash dust `VFX-ENV-012` |
| Freight lift open / close / rise | `SFX-RAID-021` | — |
| Lockdown | `SFX-RAID-030/031`, `VO-PA-020` | red flash |
| Reopen | `SFX-RAID-032`, `VO-PA-021` | green flash |
| Sealed | `SFX-RAID-040` | fade |
