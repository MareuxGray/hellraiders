# 18 · World items: Relics, named gear, vinyls, the jukebox and the boombox

Owner of: the "nothing is ever truly lost" system: Relic records, the world pool, how lost Relics re-enter raids, named gear (Name Tags), vinyl pressing, the Drifter copy, history cards, notices, the jukeboxes and the boombox, and the music catalogue rules. Built in Feature F7 (`26`).

**Rules that never change:**
- A Relic is **one of one**. It has a permanent world record. It's never deleted by being lost; it goes back into the world.
- Relics give **no power**. A named gun has the same stats as the base gun. Vinyls are music.
- Players never upload or choose free text or audio. Names come from Roblox display names in a fixed format; music comes from a curated, licensed catalogue only.
- Relics can't be sold to the Pawnbroker, traded on the Flea, insured, or repossessed (`16`).

---

## 18.1 Relic types

| Type | How it's made | Item id |
|---|---|---|
| **Named gear** | Apply a Name Tag to a gun or armour piece you own (§18.4) | keeps its base id, plus `relicId` |
| **Vinyl** | Pressed at the Pressing Booth (§18.5), or found | `ITM-VIN` + `relicId` |

- Tier: **Relic** (red-gold rim, `02` §2.11). Reveal: 2.6 s, Relic theme, story card (`11` §11.4).
- Size: named gear keeps its base size; a vinyl is 2×2, 0.3 kg.
- Display: wall mounts (guns), pedestals and the glass case (vinyls and armour) (`15` §15.5).

## 18.2 The Relic record

DataStore `Relics/<relicId>`:

```
Relic {
  relicId: string,            -- "R-" .. 8 base32 chars
  kind: "Gear" | "Vinyl",
  baseItem: string,           -- e.g. "ITM-GUN-004" or "ITM-VIN"
  title: string,              -- built by the server, e.g. "Maru's Kestrel" / "Maru's pressing #00412 (Keeper)"
  epithet: string?,           -- preset only (§18.4)
  finish, stickers, charm,    -- cosmetics copied at naming time (gear)
  track, sleeve, colour,      -- vinyl only
  creatorUserId, creatorName, -- display name at creation (server-only id)
  ownerUserId: number?,       -- nil while in the world
  status: "Owned" | "InRaid" | "Lost" | "Claimed",
  claimedBy: {jobId, at}?,    -- raid server holding it
  lostAt, lostWing, lostFloor,
  history: { {event, name, at, wing?} }   -- last 20 kept
}
```

- `event` values: Created, Pressed, Extracted, Lost, Found, Returned (finder was a former owner), Displayed.
- `name` in history is the actor's Roblox display name at the time. It's shown only on the history card. If a user is moderated, their entries show "a raider".

## 18.3 The world pool

- **When a Relic is lost:** its carrier dies (or is sealed in) and no player extracts it by the end of the raid. At `Results`, the raid server sets `status = "Lost"`, `ownerUserId = nil`, `lostAt`, `lostWing`, `lostFloor`, adds a Lost history entry, and adds the relic to MemoryStore SortedMap `RelicPool` (score = `lostAt`).
- **Cooldown:** a lost Relic can re-enter a raid only after 30 minutes.
- **Claiming at Loading (`03` §3.2):** the raid server reads the 50 oldest eligible entries, picks up to **6** at random (Orientation Runs pick none), and for each calls `UpdateAsync` to set `claimedBy = {jobId, now}` only if it's unclaimed or its claim is older than 30 minutes. Successful claims are placed in a random Display case, Stockroom crate or Locker, replacing that container's top slot (`11` §11.3).
- **During the raid:** the record is `InRaid`. If a player loots it, it's in their inventory like any item.
- **At Results:** extracted → `Owned` by the extractor (Found entry; Returned if they were a former owner, which unlocks ACH-013). Not extracted → back to `Lost` with the new wing, and back into the pool.
- **Server crash:** the claim lease expires after 30 minutes and the relic is claimable again. A relic carried by a disconnected player follows `03` §3.7.
- **Placement ping:** when a Relic slot is revealed, the finder's squad gets a short gold ping on their screens and a sting (`SFX-REL-001`). Nobody else is told.

## 18.4 Named gear (Name Tags)

- A **Name Tag** (`ITM-GER-009`, 1×1) is found in raids (Rare) or bought from **Vex** on the roof for 5,000 MC, or in the shop for 25 R$ (`19` §19.5).
- At the flat workbench > **Engrave** (`UI-REL-001`): pick a gun or armour piece from your stash that has at least one finish applied. Optionally pick an **epithet** from a preset list of 40 (`src/shared/Epithets.luau`, e.g. "Old Faithful", "Lucky", "The Widowmaker", "Night Shift", "Sunday Best"). Confirm (`ANIM-FLT-010` engraving, `SFX-REL-010`).
- The item becomes a Relic titled `"{DisplayName}'s {ItemName}"` or `"{DisplayName}'s {ItemName}, {Epithet}"`. Its finish, stickers and charm are locked in (they're part of the Relic now; the cosmetics stay in your collection for other guns).
- The Name Tag is consumed. A Relic can't be renamed. Max 20 named items created per account (a Relic that leaves your hands still counts).
- **Finder:** keeps the original title. Their name is added to the history. They can use, display or carry it.

## 18.5 Vinyls

### Pressing
- **The Pressing Booth** is in the back room of The Drain on the ground floor (`MDL-TWR-070` record press, NPC **June** the bartender runs it, `14` §14.14).
- Panel `UI-REL-010`:
  1. Pick a **track** from the catalogue (§18.8). Each track has a 15 s preview.
  2. Pick a **sleeve design** (12 presets, `UI-VIN-001…012`) and a **vinyl colour** (8: black, red, blue, gold, clear, green, purple, splatter).
  3. Confirm with **99 R$** (product "Press a Vinyl", `19` §19.4) or one **Blank Vinyl** item (`ITM-VIN-000`, Exotic loot, Stockroom crates and Display cases only, 1% of Exotic rolls; value 0, not tradeable).
- Pressing plays a 3 s press animation (`ANIM-TWR-010`, `SFX-REL-020` hiss and thump).
- **One pressing makes two copies**, each its own Relic with the same track, sleeve and colour and a global serial number:
  - **Keeper** (`"{DisplayName}'s pressing #{serial} (Keeper)"`): goes to your stash.
  - **Drifter** (`"{DisplayName}'s pressing #{serial} (Drifter)"`): goes straight into the world pool (status Lost, `lostWing = "Unknown"`), so it can turn up in anyone's raid.
- Robux pressings are flagged `PaidOrigin` (irrelevant to trading since Relics can't be traded, but kept for records).

### Playing vinyls
- **Flat jukebox** (Functional furniture, `15` §15.4): play any vinyl in your stash or on display, for everyone in the flat.
- **The Drain jukebox** (public, `MDL-TWR-071`): any player can queue one vinyl they own; queue of 10, one entry per player; each track plays up to 3 minutes for the bar zone (radius 40). The jukebox shows "Now playing: {title}". With nothing queued, it plays the Drain ambient track (`MUS-TWR-005`).
- **Boombox** in raids (`ITM-GER-008`, §18.7).

## 18.6 History cards and notices

- **Inspect** a Relic (inventory, display, or a visitor inspecting your display) opens its **history card** (`UI-REL-020`): title, creator, current owner, kind, and the last 20 history lines, e.g. "Lost on Floor 2, Electronics · 3 days ago", "Found by Kai · yesterday".
- **Notices** (mail and a quiet toast in the tower, `STR.REL.*`):
  - To the **creator**: when any copy of their Relic is found ("Someone found your pressing #00412 (Drifter)").
  - To every **previous owner**: when the Relic they lost is found by someone else ("Your lost Kestrel turned up. Someone extracted it from Electronics.").
  - Max 3 Relic notices per player per day (the rest are batched into one mail).
- These are the "someone found your lost gun" tomorrow hooks (`28`).

## 18.7 Boombox (in raids)

- Equip `ITM-GER-008` in a quick slot. Use: place it on the ground (0.8 s, `ANIM-ACT-055`), then pick a vinyl from your inventory to insert. The vinyl moves into the boombox (it's inside the placed world object; anyone can pick up the boombox, which takes the vinyl with it).
- While playing: noise 100 every 2 s (`02` §2.5; zombies and The Janitor are drawn to it), 3D music audible to 100 studs (`Sound.RollOffMaxDistance = 100`). Plays until the track ends (up to 3 min) or someone turns it off (Context). It's a lure, a trap, and a social moment.
- A boombox playing during Red Alert gets buried under the sirens (music volume −60%).
- Shooting a placed boombox (20 damage) breaks it and drops the vinyl (vinyls can't be destroyed).

## 18.8 Music catalogue (vinyl tracks)

- 40 tracks at launch (`MUS-VIN-001…040`), grouped by mood: Mall Muzak (8), Synth Night (8), Grunge Garage (8), Lo-fi Rooftop (8), Doom Choir (8).
- Sources, in order: tracks the game owns or commissions; Roblox's licensed music library tracks that are allowed in experiences. Each track is listed in `src/shared/Vinyls.luau` with `{id, title, artistCredit, assetId, mood, licence}`. Placeholders until P1 (`26`).
- The catalogue grows in live updates (`28`). Removed tracks: existing vinyls keep playing if the asset is still allowed; if Roblox removes an asset, vinyls of that track switch to a replacement in the same mood and their history notes "Re-pressed".

## 18.9 Limits and anti-hoarding

- The pool is unlimited in size, but each raid claims at most 6, oldest-first pick from 50, so lost Relics come back in roughly the order they were lost.
- A player can hold any number of Relics. Carrying a Relic into a raid is a real risk; that's the point.
- Never sell a cosmetic copy of a Relic or of a named item's look as its own product.
