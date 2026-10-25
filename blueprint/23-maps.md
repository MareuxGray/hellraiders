# 23 · Maps: Sunshine Valley Mall and High-Rise Tower

Owner of: the mall's dimensions, floors, wings, shops, gates, exits, terminals, generators, benches, safes, stockrooms, vertical routes, traversal tags, spawn points, container distribution, glass, alarms, traps, lighting and art direction; and the tower's physical layout. Every placed thing is tagged (CollectionService) and checked by `/audit map` (`22` §22.7).

Coordinates are in studs. Origin = centre of the mall at Ground floor level. **North = −Z**, **East = +X**. Positions are the centre of the thing unless stated.

---

## 23.1 Mall overview

- **Fiction:** Sunshine Valley Mall, a 1990s American mall, three storeys around a skylit galleria, quarantined after the outbreak. Pastel tiles, fake palms, brass rails, dead fountains, water-stained ceilings, abandoned army checkpoints, blood smears, overturned trolleys, police tape, campsite debris where survivors held out.
- **Footprint:** 560 × 360 (X −280…280, Z −180…180). Building only; the car parks outside are a backdrop (not walkable; fences and burnt cars).
- **Streaming:** `StreamingEnabled`, `StreamingTargetRadius 256`, `ModelStreamingMode` atomic for containers, doors and shutters. Part budget: under 60,000 parts; target 25 MB server memory for the map.

## 23.2 Floors

| Floor | Floor Y | Ceiling height | Volume tag | Contents |
|---|---|---|---|---|
| Basement | −14 | 14 | `Floor.Basement` | Entry gates A–D, Basement Garage (east), Maintenance tunnels (west and north), Generator Service, Garage booth terminal |
| Ground | 0 | 14 | `Floor.Ground` | Food Court (west), Pharmacy (south-centre), Department Store ground (east), galleria shops |
| First | 14 | 14 | `Floor.First` | Electronics (north-centre), Department Store first, galleria shops |
| Second | 28 | 14 | `Floor.Second` | Cinema (west), Security Office (north-east), Department Store second, galleria shops |
| Roof | 42 | open | `Floor.Roof` | Rooftop Helipad cage, main stair head, Department Store service stair head, HVAC, skylights |

- Floor-to-floor is 14, which is the top of the floor-edge drop range (`04` §4.6): every galleria edge without a rail can be dropped safely with the landing roll.
- **Galleria:** an open void through Ground to Second, X −140…140, Z −30…30, with railings (guardrails, `Traverse.Rail`) on First and Second, two bridges on each upper floor (X −60 and X 60, width 12), skylights above, a dry fountain at Ground (X 0, Z 0, radius 14), and 4 escalator pairs (§23.6).
- **Service corridors:** a 6-wide corridor runs behind every shop row on every floor (north row behind Z −90, south row behind Z 90), connected to stairs, service elevators and Maintenance. Every shop has a back service door into it (`06` §6.2). Corridors are unlit, concrete, pipes overhead. The Janitor favours them.
- **Structural walls:** exterior walls, stair cores, elevator shafts and the galleria columns (every 20 along Z ±30). Tagged `Structural`. Everything else between shops is `Destructible` (`06` §6.6).

## 23.3 Wings and shops

| Wing | Floor(s) | Bounds (X, Z) | Notes | Power |
|---|---|---|---|---|
| **Food Court** | Ground | X −280…−150, Z −140…140 | Central seating pit (Y −2), 10 food kiosks, a pharmacy kiosk (Orientation Run Antidote), the Food Court terminal kiosk (X −215, Z 0), kitchen back rooms, the west service elevator. Orientation Run area. | North |
| **Pharmacy** | Ground | X −60…20, Z 60…140 | Front counter, aisles, back dispensary with 3 Med Safes, a Pharmacy stockroom | North (Food Court group by wiring) |
| **Department Store** ("Hartwell's") | Ground–Second | X 150…280, Z −140…140 | Three open floors joined by an internal escalator pair and the east service stair to the roof. Mannequins, perfume counters (glass), furniture floor (Second). Stockroom on Ground. | North |
| **Electronics** | First | X −40…140, Z −160…−60 | Electronics superstore "VoltMart" plus 3 small phone and game shops. Displays (glass), stockroom. | East |
| **Cinema** ("Sunshine 6") | Second | X −280…−150, Z −140…140 | Lobby, concession, 6 screens (pitch dark, sloped seating), projection booths with a ladder. No skylights. Darkest wing. | East |
| **Security Office** | Second | X 60…150, Z −160…−90 | CCTV room (monitors show static unless Generator Service runs), armoury (stockroom, Security keycard), holding cells, 1 Med Safe, the Security terminal (X 105, Z −125), the shutter control panel | Service |
| **Maintenance tunnels** | Basement + service corridors | Basement X −280…40, Z −180…−100 and the west band X −280…−200 | Boiler room, Generator Service, 4 field workbenches, fuel storage, ladders up to service corridors | Service |
| **Basement Garage** | Basement | X 40…280, Z −100…180 | Car park with burnt cars, two car ramps (east to outside, sealed; north-east up to Ground loading dock), the Garage bay evac area (§23.5), Garage booth terminal (X 90, Z 150) | Service (bay lights only) |
| **Galleria shops** | Ground, First, Second | north row Z −90…−30, south row Z 30…90, between X −140 and 140 (where not a wing) | 48 shops in total (§23.3.1) | North (Ground), East (First), Service (Second) |

### 23.3.1 Shops

48 shops, each 20 wide (X) × 30 deep (Z) on average, with a roll-down shutter (`Shutter`), a front glass storefront (Large) and a back service door. Named in `src/shared/MallShops.luau` with invented brand names (no real brands). Shop types (with counts) set the container mix and props:

| Type | Count | Typical containers |
|---|---|---|
| Apparel | 10 | shelves/racks, tills, lockers |
| Shoes | 4 | shelves, tills |
| Toys and games | 4 | shelves, tills, display cases |
| Books and music | 4 | shelves, tills (vinyl crates as decor) |
| Jewellery | 3 | display cases (glass), tills, safe-like lockers |
| Sporting goods | 3 | racks, weapon crate (1 per shop), toolbox |
| Hardware | 2 | toolboxes, shelves, materials |
| Phone and gadgets | 4 (3 inside Electronics) | display cases, shelves |
| Pharmacy kiosk / optician | 2 | med cabinets |
| Café / sweets | 6 | tills, shelves (alcohol, food materials) |
| Salon / services | 3 | lockers, cabinets |
| Arcade "Pixel Palace" | 1 (First, south row) | tills, display cases, the arcade cabinet decor loot |
| Pawn and gold | 1 | display cases, till |
| Army checkpoint (former shop) | 1 (Ground, south row) | weapon crates ×2, lockers, ammo |

- **Alarm-marked shops (12):** Jewellery ×3, Electronics VoltMart, Phone ×2, Pawn and gold, Sporting goods ×2, Toys ×1, Apparel ×2. Each raid arms 6 of them (`06` §6.8).

## 23.4 Gates and spawns

| Gate | Position (Basement) | Freight lift model | Faces |
|---|---|---|---|
| Gate A | X −250, Z −160 (north-west) | `MDL-RAID-001` | into Maintenance |
| Gate B | X 250, Z −160 (north-east) | `MDL-RAID-001` | into the Garage north end |
| Gate C | X −250, Z 160 (south-west) | `MDL-RAID-001` | into the south-west fire stair lobby |
| Gate D | X 250, Z 160 (south-east) | `MDL-RAID-001` | into the Garage south end |

- Each gate opens into a small lobby with one route up (stairs or ramp) so squads fan out.
- **Zombie spawn points:** 60 Walker points and 12 Crawler points tagged `Spawn.Walker` / `Spawn.Crawler` with attribute `Wing`. Distribution:

| Wing | Walker | Crawler |
|---|---|---|
| Food Court | 9 | 2 |
| Pharmacy | 4 | 1 |
| Department Store | 10 | 2 |
| Electronics | 7 | 1 |
| Cinema | 6 | 3 |
| Security Office | 3 | 0 |
| Maintenance | 5 | 2 |
| Garage | 6 | 1 |
| Galleria (all floors) | 10 | 0 |

- **Service doors for reinforcements** (`08` §8.6): 24 tagged `Spawn.ServiceDoor` (3 per wing).
- **The Janitor's entry doors:** 4 tagged `Spawn.Janitor` in Maintenance.

## 23.5 Evac areas

| Exit | Area volume | Zone volume | Gates of the area |
|---|---|---|---|
| Rooftop Helipad | X 60…100, Y 42…60, Z −20…20 (40 × 40 cage) | Landing circle centre X 80, Z 0, radius 10 | North stair gate (from the main stair head at X 80, Z −40), South stair gate (from the Department Store service stair head via a roof walkway, X 80, Z 40) |
| Basement Garage | X 200…250, Y −14…0, Z 20…50 (50 × 30 bay) | Freight platform X 217…233, Z 29…41 (16 × 12) | East ramp blast shutter (X 250, Z 35), Service corridor blast shutter (X 200, Z 35) |

- Area and zone volumes are invisible parts tagged `Evac.Area` / `Evac.Zone` with attribute `Exit`. The lockable gates are `Evac.Gate` (`10` §10.6).

## 23.6 Fixed points

| Thing | Count | Positions (floor: X, Z) |
|---|---|---|
| Security terminals | 3 | Second: 105, −125 (Security Office) · Ground: −215, 0 (Food Court kiosk) · Basement: 90, 150 (Garage booth) |
| Generators | 3 | **North:** Ground service corridor, −170, −150 · **East:** Basement east service room, 30, −150 · **Service:** Basement boiler room, −120, −140 |
| Field workbenches | 8 | Maintenance ×4 (Basement: −240, −120 · −160, −170 · −60, −150 · 0, −130) · Hardware shop (Ground, south row, 100, 60) · Sporting goods (First, south row, −100, 60) · Cinema projection booth (Second, −250, −60) · Garage workshop (Basement, 140, 100) |
| Med Safes | 4 | Pharmacy dispensary ×3 (Ground: −30, 130 · −10, 130 · 10, 130) · Security Office (Second: 130, −150) |
| Safe code notes | 2 | one in the Pharmacy wing, one in the Security Office, at one of 4 marked spots each (random per raid) |
| Locked stockrooms | 5 | Food Court (Ground, −265, −120) · Electronics (First, 120, −150) · Department Store (Ground, 265, 120) · Pharmacy (Ground, −50, 135) · Security armoury (Second, 140, −100) |
| Service elevators | 2 | West: Food Court service, −270, 0, Basement–Second · East: Department Store service, 275, 0, Basement–Second |
| Escalator pairs | 4 | Galleria west (X −120) G↔1 and 1↔2; galleria east (X 120) G↔1 and 1↔2; plus the Department Store internal pair (X 215). Broken runs (impassable, tagged `Escalator.Broken`): galleria west 1↔2 up, Department Store G↔1 down |
| Stairs | 4 | Main stair tower (X 80, Z −40), Basement–Roof · SW fire stair (X −250, Z 160), Basement–Second · SE fire stair (X 250, Z 160), Basement–Second · Department Store service stair (X 270, Z 120), Ground–Roof |
| Ladders | 6 | Maintenance shaft to Ground service corridor (−200, −160) · Cinema projection booth (Second, −250, −60) · Electronics stockroom loft (First, 125, −155) · Garage mezzanine (Basement, 160, 170) · Food Court kitchen roof hatch to First service corridor (−240, −130) · Roof access hatch above Security (Second → Roof, 120, −140) |
| Floor-edge drops (rail-less lips) | 8 | Galleria First: (−90, −30) · (40, 30) · (100, −30) · (−20, 30); Galleria Second: (−110, 30) · (0, −30) · (70, 30) · (130, −30) |
| Climbable ledges (`Traverse.Ledge`, top 4.5–7.5) | 16 | 2 per wing: loading-dock lips, raised stage edges, stockroom mezzanines; exact spots set in the S2 grey-box and listed by `/audit map` |
| Climbable boxes (`Traverse.Box`, crates, counters, planters, cars) | 60+ | every shop counter and planter is tagged; plus 20 crate stacks (stockrooms, loading dock, Garage), at least 2 stacks per wing forming a route to a mezzanine or window (`MDL-ENV-197`) |
| Crawl spaces (`CrawlSpace`, ceiling under 2.5) | 12 | 1–2 per wing: under collapsed ceiling slabs (`MDL-ENV-198`), broken vent runs between a shop and its service corridor, under parked cars in the Garage. Each links two places and is a shortcut or an escape, never the only route |
| Climb-through windows | 24 | interior shop windows between shops and service corridors (16) and Department Store exterior ledge windows on First/Second (8) |
| Trap points (signs/bottle strings) | 20 | 2–3 per wing at chokepoints (doorways, corridor bends), marked `Trap` |
| Barricade-able door frames | 40 | service doors and interior doors marked `Barricadable` |

## 23.7 Containers by wing (224)

| Wing | Bins/rubble | Shelf/rack | Till | Locker/bag | Display | Med cab | Med Safe | Weapon crate | Stockroom crate | Toolbox | Total |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Food Court | 6 | 4 | 6 | 2 | 1 | 1 | 0 | 0 | 3 | 1 | 24 |
| Pharmacy | 1 | 3 | 1 | 1 | 0 | 6 | 3 | 0 | 2 | 0 | 17 |
| Department Store | 2 | 6 | 4 | 2 | 4 | 0 | 0 | 0 | 3 | 1 | 22 |
| Electronics | 1 | 3 | 2 | 1 | 4 | 0 | 0 | 0 | 3 | 1 | 15 |
| Cinema | 3 | 1 | 2 | 2 | 1 | 1 | 0 | 0 | 0 | 1 | 11 |
| Security Office | 1 | 1 | 0 | 4 | 0 | 1 | 1 | 3 | 2 | 0 | 13 |
| Maintenance | 3 | 2 | 0 | 2 | 0 | 1 | 0 | 0 | 0 | 5 | 13 |
| Garage | 4 | 1 | 1 | 2 | 0 | 0 | 0 | 1 | 0 | 4 | 13 |
| **Wings total** | 21 | 21 | 16 | 16 | 10 | 10 | 4 | 4 | 13 | 13 | **128** |

- **Galleria shops:** 2 containers per shop × 48 = **96**, chosen by shop type (§23.3.1); the Army checkpoint has 2 weapon crates and each Sporting goods shop 1. Wing tag `Galleria` (no wing bias).
- **Total: 224.** Audit tolerance 215–235.
- Stockroom crates sit inside the 5 locked stockrooms (2–3 each). Every container has attributes `Class`, `Slots`, `Wing` (`11` §11.3).

## 23.8 Lighting and art direction

- `Lighting.Technology = Future`. Ambient very low (`Ambient 10,10,14`, `OutdoorAmbient 20,20,28`), `Brightness 0.8`, `ClockTime 0.5` (night) with moonlight through skylights (decorative). `Atmosphere` density 0.35, haze 1.5, blue-grey.
- **Emergency lights** (dim red, radius 4, flicker) every 30 studs in corridors and shops: `MDL-ENV-023`.
- **Powered lights** per wing, enabled by its generator (`06` §6.4): ceiling panels `MDL-ENV-020`, shop spots `MDL-ENV-021`, galleria pendants `MDL-ENV-022`. All shootable.
- **Fog and dust:** `ParticleEmitter` dust motes in light shafts (`VFX-ENV-020`).
- **Palette:** faded pastel (mint, salmon, lemon tiles), brass, sun-bleached signage; blood and grime overlay decals (`TEX-ENV-001…040`).
- **Sound zones** (reverb and ambience, `24` §24.3): galleria (large hall), shops (small room), corridors (concrete), Cinema (dead room), Garage (parking structure), Roof (outdoor wind).
- **Decor kit:** `MDL-ENV-100…180` (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, directory boards). Mall directory boards ("You are here", `MDL-ENV-110`) on every floor at the escalators: the game's only map.

## 23.9 High-Rise Tower (lobby model)

- One physical model in the Tower place. Footprint 120 × 120, origin at the ground floor centre. Floors stacked by **6 studs per "storey" visually** but only the playable levels are built (`14` §14.3): Ground (Y 0), Low Block floors 2–5 (Y 40, 52, 64, 76), Mid Block 10–15 (Y 136…196, every 12), Penthouse 30–33 (Y 376…412, every 12), Roof (Y 430). Non-built floors are solid concrete between.
- **Ground floor (the Flea atrium):**

| Area | Position (X, Z) | Contents |
|---|---|---|
| Atrium centre | 0, 0 | Dry fountain; Most Wanted Wall above it on the north face (3 storeys tall, X −20…20, Z −40) |
| Flea stalls and listing terminals | ring around the fountain, radius 22 | 8 terminals `MDL-TWR-050`, 12 decor stalls |
| Appraisal Terminal | 18, 18 | `MDL-TWR-051` |
| Contract Terminals | 6 around the wall base (X −18…18, Z −36) | `MDL-TWR-061` |
| Contract Board | −30, −30 | daily contracts `MDL-TWR-062` |
| Concierge Desk | 0, 40 (south, facing the entrance) | NPC Marla |
| Quartermaster | −45, 10 | NPC Okafor, counter with cage |
| Pawnbroker | −45, −15 | NPC Lenny |
| Second-Hand Sal | −45, 35 | furniture stall, NPC Sal |
| Mail Room | 45, 30 | NPC Pip, Repossession window |
| The Drain (bar) | 45, −20 | NPC June, public jukebox, back room Pressing Booth (`MDL-TWR-070`) |
| Security checkpoint | 0, 55 | turrets, guards, metal detector arch (decor) |
| Transit Gates | 0, −55 (north) | 4 freight elevator doors (`MDL-TWR-080`), deploy hall |
| Main lift lobby | 30, −45 | 4 lift doors, floor picker |
| Tower Standing board | 30, −35 | `MDL-TWR-030` |

- **Residential floors:** each has the lift lobby, corridors with flat doors (`MDL-TWR-020`) numbered `{floor}{letter}` (e.g. 3C, 12A, 31B), and floor props by block (`14` §14.3).
- **Roof (Black Market):** helipad (decor), lounge, Vex's wheel counter (`MDL-TWR-040`), Sully's catalyst stall, The Lab (Dr. Halloran), burning barrel, viewpoint rail looking at a matte painting of the mall in the distance (`MDL-TWR-090` skyline backdrop).
- **Flat interior bays:** 64 bays at Y −500, laid out in an 8 × 8 grid, 100 × 100 each (`15` §15.1).
- **Arrival place:** a small dark freight-lift interior (`MDL-ARR-001`) where routing happens behind a 2–4 s "Connecting to the tower" screen.
