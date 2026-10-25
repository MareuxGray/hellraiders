# 15 · Flats, the hideout and customisation

Owner of: flat tiers and interiors, fixed fixtures, the furniture placement system, functional perks, displays and trophies, visiting a flat, the overflow crate, moving furniture between flats, and the furniture catalogue. Prices are in `19` §19.5. Residency is in `14`.

---

## 15.1 How flats exist in the world

- Each flat door in a corridor (`MDL-TWR-020` door, with a number plate and optional door banner) is a portal. Using it (Context, 0.6 s, door sound `SFX-FLT-001`) moves the player into that flat's **interior**, built at an off-map interior bay under the tower (one bay per resident present in the instance, 64 bays reserved). The bay is unloaded when the owner and all visitors leave.
- Windows inside each interior show the mall view backdrop matched to the flat's floor height.
- The interior is built from the template for the occupied tier, then the owner's placed furniture is spawned from profile data.

## 15.2 Tiers

| | Bunk Studio | Executive Suite | Skyline Penthouse |
|---|---|---|---|
| Floors | 2–5 | 10–15 | 30–33 |
| Template | `MDL-FLT-001` one room 20×16, bunk, sink, exposed pipes, emergency light | `MDL-FLT-002` living room + sleeping alcove 40×26, city view | `MDL-FLT-003` three rooms + terrace 70×40, floor-to-ceiling glass, ambient lighting controls |
| Stash grid (by entitlement) | 10×15 | 15×20 | 20×30 + Ammo Locker 10×10 |
| Weapon wall mounts (base) | 1 | 3 | 6 |
| Trophy pedestals | 0 | 1 | 3 |
| Glass display case | — | — | 1 (6 items) |
| Furniture item cap | 25 | 60 | 120 |
| Workbench queue slots | 1 | 2 | 3 |
| Wallpaper and flooring | 1 surface set | 2 room sets | 3 room sets + terrace |
| Rent | 1,500 MC/week (first 2 weeks free) | none | none |
| Price | starter | 250,000 MC (level 20) or 399 R$ | 1,499 R$ |

## 15.3 Fixed fixtures (every tier, can't be removed, can be moved within the room)

| Fixture | Model | Use |
|---|---|---|
| Stash Chest | `MDL-FLT-011` | opens the stash grid (`UI-FLT-001`) |
| Workbench | `MDL-FLT-010` | learn blueprints, craft, repair (`12` §12.3) |
| Survivor Terminal | `MDL-FLT-012` | Survivor Draft, reroll, Rebalance, stats (`13`) |
| Flat Terminal (laptop) | `MDL-FLT-013` | rent, upgrades, door settings, contracts, collection book, mail, catalogue orders, achievements |
| Memorial Wall | `MDL-FLT-014` | plaques for retired survivors (`13` §13.7) |
| Trophy Shelf | `MDL-FLT-015` | achievement trophies (auto-placed) |
| Bed | `MDL-FLT-016` | decor only: you can sit on its edge (normal sit), nobody can lie on it (§15.10) |
| Overflow Crate | `MDL-FLT-017` | appears only when raid overflow exists (§15.6) |
| Exit door | part of template | back to the corridor |

## 15.4 Functional perks (furniture that does something)

Each works only in the flat you occupy, and only while your rent is paid (Bunk). One of each counts.

| Furniture | Perk | Source |
|---|---|---|
| Coffee Bar | **Well Rested:** for the first 120 s of your next raid, stamina regen +15% | MC 20,000 or R$ 99 |
| Upgraded Armory Bench | +5 weapon wall mounts | MC 35,000 or R$ 149 |
| Vintage Jukebox | play vinyls you own for everyone in the flat (`18` §18.7) and change the flat's ambient track (5 tracks, `MUS-FLT-001…005`) | MC 15,000 or R$ 99 |
| Security Terminal Desk | Flea tax −2% (applied after other modifiers, floor 3%) and insurance mail time −15% | MC 30,000 or R$ 149 |
| Radio Set | plays the tower radio station in the flat (3 channels of ambient music `MUS-FLT-010…012`) | MC 3,000 |

## 15.5 Displays and trophies

- **Weapon wall mounts** (`MDL-FLT-020`): place any gun from the stash; it shows on the wall with attachments, finish and name tag. The item stays yours (it's moved out of the stash grid while displayed; take it down any time).
- **Trophy pedestals** (`MDL-FLT-021`): displayable valuables (`11` §11.2) and Relics, lit by a spotlight.
- **Glass display case** (`MDL-FLT-022`, Penthouse): up to 6 small displayables or Relics.
- **Mutant trophy mounts** (`MDL-FLT-023`): Supermutant Trophies (`11` §11.2) as wall-mounted heads. Count against wall mounts.
- **Achievement trophies** (`MDL-TRO-001…012`) appear on the Trophy Shelf automatically.
- Displayed items can't be lost (they're not in raids). Displayed Relics show their world history card when inspected (`18` §18.6).

## 15.6 Overflow Crate

- If extracted items don't fit the stash, they go to the Overflow Crate (grid 10×10, then unlimited list view). Items in it can be moved to the stash or sold. They're kept 7 days, then sold automatically to the Pawnbroker at the vendor price (MC credited, mail notice). A warning shows on the deploy screen while it has items.

## 15.7 Furniture placement (build mode)

- Open from the Flat Terminal or press `Build` (PC B is weapon holster in raids; in flats B opens build mode; gamepad Y; mobile build button in the flat HUD). Only the owner can build.
- **Catalogue panel** (`UI-FLT-030`) lists owned furniture (owned items have counts) with tabs: Seating, Tables, Storage (decor only), Lighting, Wall, Floor, Electronics, Plants, Functional, Trophies, Wallpaper, Flooring.
- **Placing:** the item follows the cursor/centre on surfaces. Grid snap 0.5 studs (toggle off for free placement), rotate 15° steps (R / gamepad bumpers / mobile rotate), wall items snap to walls, ceiling lights to ceilings. Red ghost = invalid (overlap, blocking a fixture's front 3 studs, outside the room, over the cap). Confirm places it.
- **Edit:** select a placed item to move, rotate, store (back to inventory) or recolour (items with a colour slot accept 12 preset colours).
- Wallpaper and flooring apply per room surface set.
- **Data:** each placed item is `{itemId, x, y, z, rotY, colour, room}` in local flat coordinates, saved on exit and every 60 s while building.
- **Moving flats (upgrade or Move-in):** items are placed at the same coordinates if they fit the new template's room; anything that doesn't fit, or over the new cap, goes to **Furniture Storage** (unlimited, in the catalogue panel's Owned tab). Displays over the new mount count go back to the stash.

## 15.8 Visiting a flat

- Visitors (invited, party members, or friends when the door is set to "Friends can enter") walk around, sit, use the jukebox if the owner allows (toggle), and **inspect** displays (Context on a display shows the item card with tier, name tag and Relic history).
- Visitors can't open the stash, workbench or terminals, or move furniture.
- Door settings on the Flat Terminal: Closed (knock only), Friends can enter, Party only (default).
- Party members spawn in the leader's flat (`14` §14.12).

## 15.10 Private-space rules (Roblox maturity compliance)

Roblox restricts social hangouts that show bedrooms or bathrooms to ID-verified 17+ players. HellRaiders is a raid game with a 13+ (Moderate) label, so flats are kept as stash-and-workshop rooms, never bedroom or bathroom scenes:
- No bathrooms, toilets, showers or baths in any template or catalogue item. The Bunk's sink is a utility sink by the workbench.
- Beds are decor in a sleeping alcove; no lying-down animation, emote or seat on any bed, sofa or rug. No emote in the game lies down (`20` §20.5), and new emotes that do are never added.
- Lights can't be dimmed below 40% while a visitor is inside (`Flat.MinLightWithVisitors = 0.4`, in `02`).
- Flats are never a reason to visit: no flat-only social rewards, no "hang out" prompts. Visiting exists for parties gearing up and showing trophies.
- The maturity questionnaire answers are in `25` §25.11 and must be redone if any of this changes.

## 15.9 Furniture catalogue (launch)

All furniture is cosmetic unless marked Functional. Sold by **Second-Hand Sal** (ground-floor furniture stall, NPC `MDL-NPC-007`, `VO-NPC-073…078`) and through the Flat Terminal catalogue (delivered instantly). Robux-only items are marked. Some decor drops in raids (marked Loot).

| Id | Item | Size (studs, footprint) | Price | Notes |
|---|---|---|---|---|
| FUR-001 | Army cot | 3×7 | 1,000 MC | |
| FUR-002 | Old sofa | 7×3 | 4,000 MC | 3 colours |
| FUR-003 | Leather sofa | 8×3.5 | 25,000 MC or 99 R$ | 12 colours |
| FUR-004 | Armchair | 3×3 | 3,000 MC | |
| FUR-005 | Coffee table | 4×2.5 | 2,000 MC | |
| FUR-006 | Dining table + 4 chairs | 6×4 | 6,000 MC | |
| FUR-007 | Crate table | 3×3 | 500 MC | |
| FUR-008 | Bookshelf | 4×1.5 | 3,500 MC | |
| FUR-009 | Floor lamp | 1×1 | 1,500 MC | light |
| FUR-010 | Workbench lamp | wall | 800 MC | light |
| FUR-011 | String lights | wall | 2,000 MC or 25 R$ | light, 6 colours |
| FUR-012 | Neon sign "OPEN" | wall | 49 R$ | light |
| FUR-013 | Neon sign skull | wall | 79 R$ | light |
| FUR-014 | Neon arcade cabinet | 2×2 | Loot (Epic) | plays an attract loop |
| FUR-015 | CRT TV | 2×1.5 | 2,500 MC | plays static/news loop |
| FUR-016 | Flat-screen TV | wall | 12,000 MC | plays the mall CCTV feed loop |
| FUR-017 | Potted plant (3 kinds) | 1×1 | 1,200 MC | |
| FUR-018 | Dead plant | 1×1 | 100 MC | |
| FUR-019 | Rug (5 patterns) | 6×4 | 2,000 MC | |
| FUR-020 | Poster (10 designs, mall-era bands and films, all invented) | wall | 300 MC | |
| FUR-021 | Graffiti wall decal (8) | wall | 25 R$ | |
| FUR-022 | Gun safe (decor) | 2×2 | 8,000 MC | |
| FUR-023 | Punching bag | 2×2 | 6,000 MC | |
| FUR-024 | Fish tank | 4×1.5 | 18,000 MC | animated fish |
| FUR-025 | Mannequin (displays an outfit cosmetic you own) | 1×1 | 10,000 MC | |
| FUR-026 | Mall bench (looted) | 6×2 | Loot (Rare) | |
| FUR-027 | Shopping trolley (looted) | 2×3 | Loot (Uncommon) | |
| FUR-028 | Golden escalator sign | wall | Loot (Exotic) | |
| FUR-029 | Coffee Bar | 4×2 | 20,000 MC or 99 R$ | Functional |
| FUR-030 | Upgraded Armory Bench | 6×2 | 35,000 MC or 149 R$ | Functional |
| FUR-031 | Vintage Jukebox | 2×2 | 15,000 MC or 99 R$ | Functional |
| FUR-032 | Security Terminal Desk | 4×2 | 30,000 MC or 149 R$ | Functional |
| FUR-033 | Radio Set | 1×1 | 3,000 MC | Functional |
| FUR-034 | Penthouse bar | 8×2 | 199 R$ | |
| FUR-035 | Grand piano (decor, plays 3 tunes) | 6×5 | 299 R$ | |
| FUR-036 | Hot tub (terrace only) | 8×8 | 399 R$ | Penthouse |
| WAL-001…012 | Wallpapers (12) | surface | 1,000–6,000 MC; 4 are 49 R$ | |
| FLR-001…008 | Floorings (8) | surface | 1,000–6,000 MC; 2 are 49 R$ | |

Models `MDL-FUR-001…036`, wallpapers `TEX-WAL-001…012`, floors `TEX-FLR-001…008`, catalogue icons `UI-FUR-001…056`.

The looted decor items (FUR-014, 026, 027, 028) are added to the loot catalogue as `ITM-DEC-001…004` (size by footprint, Display case and Stockroom crate tables; `11` §11.2).
