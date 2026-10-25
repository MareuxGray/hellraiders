# 11 · Loot, containers, the reveal, and the grid inventory

Owner of: tiers, the item catalogue, containers and their loot tables, the ARC-style reveal, picking up, the raid inventory (grid, equip slots, pockets, Safe Pocket, Blueprint Slot, quick slots, backpacks), weight, corpse and backpack looting, and loot balance. Numbers are in `02` §2.10–2.11. Values are in Mall Cash.

---

## 11.1 Tiers

Common, Uncommon, Rare, Epic, Exotic, Relic (colours and spectacle in `02` §2.11). Blueprints use Common, Rare, Epic and Exotic only. Relics are unique world items (`18`). Colour-blind setting adds a shape to each tier's frame: circle, triangle, square, diamond, star, crown.

## 11.2 Item catalogue

Ids are `ITM-<group>-<n>`. Size is width×height in grid cells. Value is the sell value at the vendor (`16` §16.2); flea prices are player-set.

**Weapons and melee**

| Id | Item | Size | kg | Tier | Value |
|---|---|---|---|---|---|
| ITM-GUN-001 | P9 pistol | 2×1 | 1.2 | Uncommon | 3,000 |
| ITM-GUN-002 | Wasp SMG | 3×2 | 2.8 | Rare | 9,000 |
| ITM-GUN-003 | Brace pump shotgun | 4×2 | 3.4 | Rare | 8,000 |
| ITM-GUN-004 | Kestrel assault rifle | 5×2 | 3.6 | Epic | 18,000 |
| ITM-GUN-005 | Longhorn hunting rifle | 5×2 | 4.2 | Epic | 20,000 |
| ITM-MEL-001 | Pipe | 1×3 | 1.5 | Common | 300 |
| ITM-MEL-002 | Crowbar | 1×3 | 2.0 | Uncommon | 900 |
| ITM-MEL-003 | Fire Axe | 1×4 | 3.0 | Rare | 2,500 |

**Ammo and attachments**

| Id | Item | Size | kg | Tier | Stack | Value per full stack |
|---|---|---|---|---|---|---|
| ITM-AMO-001 | Light ammo | 1×1 | 0.6 per 60 | Common | 60 | 600 |
| ITM-AMO-002 | Medium ammo | 1×1 | 0.9 per 60 | Uncommon | 60 | 1,200 |
| ITM-AMO-003 | Heavy ammo | 1×1 | 0.6 per 20 | Rare | 20 | 1,600 |
| ITM-AMO-004 | Shells | 1×1 | 0.8 per 24 | Uncommon | 24 | 900 |
| ITM-ATT-001 | Red Dot Sight | 1×1 | 0.2 | Uncommon | 1 | 1,500 |
| ITM-ATT-002 | 4× Scope | 2×1 | 0.5 | Rare | 1 | 4,000 |
| ITM-ATT-003 | Suppressor | 2×1 | 0.4 | Rare | 1 | 5,000 |
| ITM-ATT-004 | Extended Mag | 1×1 | 0.3 | Uncommon | 1 | 2,000 |
| ITM-ATT-005 | Foregrip | 1×1 | 0.2 | Uncommon | 1 | 1,500 |

**Gear**

| Id | Item | Size | kg | Tier | Value |
|---|---|---|---|---|---|
| ITM-ARM-001 | Light Vest | 3×3 | 4 | Rare | 6,000 |
| ITM-ARM-002 | Heavy Vest | 3×3 | 9 | Epic | 14,000 |
| ITM-ARM-003 | Helmet | 2×2 | 2 | Rare | 4,000 |
| ITM-PCK-001 | Satchel (4×4 grid) | 3×3 | 0.5 | Uncommon | 1,500 |
| ITM-PCK-002 | Field Pack (5×6 grid) | 4×4 | 1.2 | Rare | 5,000 |
| ITM-PCK-003 | Tactical Bag (6×8 grid) | 5×5 | 2.0 | Epic | 12,000 |
| ITM-GER-001 | Flashlight | 1×2 | 0.4 | Common | 400 |
| ITM-GER-002 | Battery | 1×1 | 0.1 | Common | 100 |
| ITM-GER-003 | Infrared Thermometer (3 uses) | 1×1 | 0.2 | Rare | 3,000 |
| ITM-GER-004 | Blood Scanner (1 use) | 1×2 | 0.6 | Epic | 9,000 |
| ITM-GER-005 | Door Wedge | 1×1 | 0.2 | Uncommon | 500 |
| ITM-GER-006 | Planks (stack 3) | 1×3 | 1.5 per 3 | Common | 150 |
| ITM-GER-007 | Fuel Can | 2×2 | 4.0 | Uncommon | 1,200 |
| ITM-GER-008 | Boombox (plays a vinyl, `18` §18.7) | 2×1 | 1.5 | Rare | 2,500 |
| ITM-GER-009 | Name Tag (engraving, `18` §18.4) | 1×1 | 0.0 | Rare | 2,000 |

**Keycards and codes**

| Id | Item | Size | Tier | Value |
|---|---|---|---|---|
| ITM-KEY-001…005 | Keycard: Food Court, Electronics, Department Store, Pharmacy, Security (single use) | 1×1 | Rare | 2,500 |
| ITM-KEY-010 | Safe code note (raid-only; shows this raid's Med Safe code for its wing; vanishes on extract) | 1×1 | Uncommon | 0 |

**Medical** (effects in `05` §5.7)

| Id | Item | Size | kg | Tier | Value |
|---|---|---|---|---|---|
| ITM-MED-001 | Bandage | 1×1 | 0.1 | Common | 200 |
| ITM-MED-002 | Gauze Pack | 1×1 | 0.1 | Uncommon | 500 |
| ITM-MED-003 | Painkillers | 1×1 | 0.1 | Uncommon | 600 |
| ITM-MED-004 | Medkit | 2×2 | 1.0 | Rare | 3,000 |
| ITM-MED-005 | Splint | 1×2 | 0.3 | Uncommon | 800 |
| ITM-MED-006 | Surgical Kit | 2×1 | 0.8 | Epic | 7,000 |
| ITM-MED-007 | Infection Suppressant | 1×1 | 0.1 | Rare | 4,000 |
| ITM-MED-008 | Antidote Syringe | 1×1 | 0.1 | Exotic | 15,000 |
| ITM-MED-009 | Adrenaline Shot | 1×1 | 0.1 | Rare | 2,500 |

**Throwables** (effects in `07` §7.12)

| Id | Item | Size | kg | Tier | Value |
|---|---|---|---|---|---|
| ITM-THR-001 | Bottle | 1×1 | 0.4 | Common | 20 |
| ITM-THR-002 | Brick | 1×1 | 1.5 | Common | 10 |
| ITM-THR-003 | Noise Decoy | 1×1 | 0.4 | Uncommon | 900 |
| ITM-THR-004 | Molotov | 1×1 | 0.6 | crafted only | 700 |
| ITM-THR-005 | UV Stun Flare | 1×2 | 0.5 | crafted only | 1,500 |
| ITM-THR-006 | Smoke Can | 1×1 | 0.4 | Uncommon | 1,000 |

**Crafting materials** (recipes in `12`)

| Id | Item | Size | kg | Tier | Value |
|---|---|---|---|---|---|
| ITM-MAT-001 | Rag | 1×1 | 0.1 | Common | 30 |
| ITM-MAT-002 | Alcohol | 1×1 | 0.5 | Common | 80 |
| ITM-MAT-003 | Tape | 1×1 | 0.1 | Common | 60 |
| ITM-MAT-004 | Wire | 1×1 | 0.1 | Common | 60 |
| ITM-MAT-005 | Radio | 1×1 | 0.4 | Uncommon | 400 |
| ITM-MAT-006 | Chemical Flask | 1×1 | 0.3 | Uncommon | 500 |
| ITM-MAT-007 | Syringe | 1×1 | 0.05 | Uncommon | 300 |
| ITM-MAT-008 | Scrap | 1×1 | 0.5 | Common | 100 |
| ITM-MAT-009 | Mechanical Parts | 1×1 | 0.6 | Uncommon | 600 |
| ITM-MAT-010 | Electronic Parts | 1×1 | 0.3 | Rare | 1,800 |
| ITM-MAT-011 | Precision Parts | 1×1 | 0.3 | Epic | 5,000 |
| ITM-MAT-012 | Exotic Alloy | 1×1 | 0.5 | Exotic | 14,000 |
| ITM-MAT-013 | Cloth | 1×1 | 0.1 | Common | 50 |

**Valuables** (sell or display)

| Id | Item | Size | kg | Tier | Value | Displayable |
|---|---|---|---|---|---|---|
| ITM-VAL-001 | Smartphone | 1×1 | 0.2 | Common | 300 | no |
| ITM-VAL-002 | Wristwatch | 1×1 | 0.1 | Uncommon | 1,200 | no |
| ITM-VAL-003 | Perfume Bottle | 1×1 | 0.3 | Uncommon | 900 | no |
| ITM-VAL-004 | Cash Bundle | 1×1 | 0.1 | Uncommon | 1,500 | no |
| ITM-VAL-005 | Gold Chain | 1×1 | 0.1 | Rare | 4,000 | no |
| ITM-VAL-006 | Jewellery Box | 2×1 | 0.6 | Rare | 3,500 | yes |
| ITM-VAL-007 | Designer Handbag | 2×2 | 0.8 | Rare | 3,000 | yes |
| ITM-VAL-008 | Game Console | 2×2 | 2.5 | Epic | 8,000 | yes |
| ITM-VAL-009 | Vintage Camera | 1×1 | 0.6 | Epic | 6,500 | yes |
| ITM-VAL-010 | Golden Mall Statue | 2×3 | 6.0 | Exotic | 30,000 | yes (pedestal) |
| ITM-VAL-011 | Classified Security Keycard (artifact, opens nothing) | 1×1 | 0.1 | Exotic | 25,000 | yes (case) |
| ITM-VAL-012 | Supermutant Trophy (drops where a Supermutant dies; one per kill) | 2×2 | 3.0 | Epic | 10,000 | yes (wall mount) |

**Blueprints** (`12` §12.3): `ITM-BP-<category>-<n>`, 1×1, 0 kg, tier Common/Rare/Epic/Exotic, value Common 2,000 / Rare 6,000 / Epic 15,000 / Exotic 40,000.

**Relics** (`18`): named gear and vinyls (`ITM-VIN-<press#>`), tier Relic.

**Items defined in other files** (listed here so the catalogue is complete):

| Id | Item | Size | kg | Tier | Value | Defined in |
|---|---|---|---|---|---|---|
| ITM-GUN-006 | Nightjar (suppressed AR, craft-only / 2% Weapon crate Exotic roll) | 5×2 | 3.4 | Exotic | 45,000 | `12` §12.2 |
| ITM-GUN-007 | Revenant (magnum revolver) | 2×1 | 1.6 | Exotic | 40,000 | `12` §12.2 |
| ITM-ARM-004 | Bastion Plate | 3×3 | 7.0 | Exotic | 38,000 | `12` §12.2 |
| ITM-ATT-006 | Thermal Sight | 2×1 | 0.5 | Exotic | 35,000 | `12` §12.2 |
| ITM-MED-010 | Improvised Suppressant (crafted) | 1×1 | 0.1 | Rare | 1,500 | `12` §12.1 |
| ITM-TAG-001 | Dogtag (Bounty Hunters only; not tradeable or sellable) | 1×1 | 0.05 | Epic | 0 | `17` §17.1 |
| ITM-VIN-000 | Blank Vinyl (presses one vinyl for free; Stockroom crates and Display cases only, 1% of Exotic rolls) | 2×2 | 0.3 | Exotic | 0 | `18` §18.5 |
| ITM-VIN | Vinyl (a Relic; each has its own relicId) | 2×2 | 0.3 | Relic | — | `18` §18.5 |
| ITM-DEC-001 | Neon arcade cabinet (furniture FUR-014; Display case and Stockroom crate tables) | 2×2 | 12.0 | Epic | 12,000 | `15` §15.9 |
| ITM-DEC-002 | Mall bench (FUR-026) | 3×2 | 10.0 | Rare | 5,000 | `15` §15.9 |
| ITM-DEC-003 | Shopping trolley (FUR-027) | 2×2 | 6.0 | Uncommon | 1,500 | `15` §15.9 |
| ITM-DEC-004 | Golden escalator sign (FUR-028) | 3×1 | 4.0 | Exotic | 25,000 | `15` §15.9 |

- Decor loot (ITM-DEC) goes to the stash and, when used from the stash ("Install"), becomes the furniture item in your collection. It can also be sold or traded before installing.

## 11.3 Containers

Every container is a model tagged `Container` with attributes `Class`, `Slots`, `Wing`. Positions are in the map (`23` §23.7). About 220 containers in Sunshine Valley Mall.

| Class | Model ids | Slots | Open hold | Tier weights C/U/R/E/X | Category bias |
|---|---|---|---|---|---|
| Trash bin / rubble | `MDL-CON-001/002` | 2–3 | 1.2 | 70/25/5/0/0 | materials, throwables |
| Shelf / rack | `MDL-CON-003/004` | 3–5 | 1.2 | 60/30/9/1/0 | any except guns |
| Till / register | `MDL-CON-005` | 2–4 | 1.2 | 40/40/17/3/0 | valuables, keycards |
| Locker / staff bag | `MDL-CON-006/007` | 3–5 | 1.2 | 50/32/14/4/0 | gear, meds, ammo |
| Display case | `MDL-CON-008` | 2–3 | 1.2 (or break the glass) | 30/35/25/9/1 | valuables, attachments |
| Med cabinet | `MDL-CON-009` | 3–5 | 1.2 | 45/35/17/3/0 | meds only |
| Med Safe | `MDL-CON-010` | 4 | keycard or code + 2.0 | 0/30/45/20/5 | meds; may hold the Antidote |
| Weapon crate | `MDL-CON-011` | 3–4 | 1.2 | 20/40/28/10/2 | guns, ammo, attachments, armour |
| Stockroom crate | `MDL-CON-012` | 4–6 | 1.2 (room needs keycard) | 10/30/35/20/5 | any |
| Toolbox | `MDL-CON-013` | 3–4 | 1.2 | 50/35/13/2/0 | materials, melee |
| Corpse / backpack | (player or Sprinter) | its contents | 0.6 per slot | — | — |

- **Blueprint chance per container roll:** 4% (Weapon crate 8%, Stockroom crate 15%, Med Safe 0%). Blueprint tier weights: Common 50, Rare 30, Epic 15, Exotic 5. A container never holds more than one blueprint.
- **Wing bias:** Electronics +100% electronic parts, consoles, radios; Pharmacy meds; Department Store valuables and packs; Food Court materials and alcohol; Security Office weapons, keycards; Cinema valuables, batteries; Maintenance materials, fuel, planks.
- **World items** (`18` §18.3): at Loading, the server claims up to 6 lost Relics from the world pool and places each in a random Display case, Stockroom crate or Locker, replacing its top slot.

## 11.4 Opening and the reveal

1. **Hold Context** on the container (1.2 s, `ANIM-ACT-012` search clip by height: low, mid, high `ANIM-ACT-013/014`). Noise 8 per second while searching. Moving more than 1.5 studs cancels.
2. The **container panel** opens beside your inventory (`UI-INV-010`): its grid shows its items as **face-down slots** (dark tiles at the true item sizes).
3. Slots reveal one at a time, top-left to bottom-right. Each takes its tier's reveal time (Common 0.3 to Relic 2.6 s, `02` §2.10).
4. **Anticipation:** during a slot's reveal, the tile edge glows in the **true** tier colour from the start, growing brighter, with a rising sound pitched by tier (`SFX-LOOT-010…015`). Then the icon flips in with the tier's reveal sound (`SFX-LOOT-001…006`). Epic and above add a short shimmer (`VFX-UI-001`); Exotic adds a 0.3 s camera push; Relic adds the Relic theme (`MUS-UI-010`), a red-gold frame and the item's story card (`18` §18.6).
5. **Grab anytime:** you can drag or quick-take (double-click, mobile double-tap) any revealed item while the rest reveal. The panel can be closed at any time. Unrevealed slots stay unrevealed, and continue from where they stopped if you reopen it.
6. Once fully revealed, a container stays revealed for everyone. Other players opening it see the remaining items at once (no reveal), with only a 0.6 s open.
7. **Honesty rule:** the hint colour always matches the real item. No fake near-misses, no sounds that tease a higher tier.

## 11.5 Raid inventory layout

Opened with Tab (gamepad View/Back, mobile backpack button). The game doesn't pause. The character crouches into a rummaging pose (`ANIM-ACT-015`) only while a container panel is open; opening your own inventory alone has no animation and doesn't stop movement (walk speed max).

| Area | Size | Notes |
|---|---|---|
| Equip slots | Primary, Secondary, Melee, Armour, Helmet, Backpack, Flashlight | drag gear in; weapons and armour show on the body |
| Pockets | 4 × 1×1 | |
| Safe Pocket | 1 × 1×1 | any 1×1 item; kept on death |
| Blueprint Slot | 1 × 1×1 | blueprints only; kept on death. Blueprints picked up auto-fill it if empty. |
| Quick slots | 4 | links to items in pockets or backpack (meds, throwables, scanner, battery); used with 4–7 on PC, the quick wheel on gamepad, the quick bar on mobile |
| Backpack grid | per pack (`02` §2.10) | |

- **Grid rules:** items occupy their size. Rotate while dragging with R (gamepad X, mobile rotate button). Stacks merge on drop. Shift-click (mobile: long-press > Split) splits a stack.
- **Item actions** (right-click, gamepad A-hold, mobile long-press): Use, Equip, Inspect (shows tier, value, description, and the Sleeper-only Taint option, `09` §9.6), Drop, Split, Attach (attachments), Unload (guns), Hand Over (opens a trade-free give to a player within 3; they must accept).
- **Dropping** places a world item at your feet (the item's model from `27`, or the generic bag `MDL-ITM-094` for small items).
- **Weight** is the sum of carried items (equipped, pockets, backpack, quick slots, Safe Pocket). The HUD weight bar shows encumbrance (`21` §21.4). Effects in `02` §2.3.

## 11.6 Loot rolling

- At `Loading`, each container rolls its slot count, then rolls each slot: tier by the class's tier weights (adjusted by catalyst, `19` §19.7), then category by the class and wing bias, then the item uniformly from that tier and category. Then the blueprint roll.
- Fixed placements: Antidotes (`09` §9.7), keycards (one of each type per raid, placed in Tills, Lockers and Security Office drawers), Fuel Cans (3 per raid, near generators but not next to them), Safe code notes (one per wing with Med Safes).
- **Balance target:** an average full-search haul for a solo player who extracts is about 6,000 MC (`02` §2.12). Measured in S17 with bots and tuned by the tier weights only.

## 11.7 Picking up from the world

- World items (dropped, placed) show a small glint when within 6 (`VFX-ITM-001`; tier colour for Rare and above). Hold Context 0.4 s to pick up into the first free slot (pickup clip `ANIM-ACT-010/011`). If there's no room: `STR.INV.FULL`.

## 11.8 Extraction to stash

On extract every carried item goes to the stash (`03` §3.8). Raid-only items (safe code notes) vanish. Overflow goes to the Overflow Crate.

## 11.9 Corpses and dropped backpacks

- A dead player's corpse holds everything they carried except the Safe Pocket and Blueprint Slot (those go home with the player). A Sprinter's or mutant's drop holds the backpack contents plus equipped gear.
- Searching a corpse: hold Context 1.2 s, then slots reveal at 0.6 s each regardless of tier (`02` §2.10). The searcher is in the rummaging pose and vulnerable.
- Corpses and drops persist for the whole raid.
- **Insurance** (`16` §16.4) only returns items that were never extracted by another player.
