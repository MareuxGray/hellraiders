"""HellRaiders master asset list.

Single source for blueprint/27-assets.md and the per-step "Asset requests" in 26.
Run: python3 tools/build_assets.py   (regenerates 27 and the 26 asset lists)
Each entry: id, kind, description, step (first step that needs it), placeholder size (MDL only, studs W x H x D).
"""

ASSETS = []


def A(aid, desc, step, size=None):
    ASSETS.append({"id": aid, "desc": desc, "step": step, "size": size})


def R(prefix, start, descs, step, size=None):
    """Range: prefix like 'ANIM-MOV', start number, list of descriptions (one per id)."""
    for i, d in enumerate(descs):
        A(f"{prefix}-{start + i:03d}", d, step, size)


def N(prefix, start, count, fmt, step, size=None):
    """Numbered range with a format string using {n} (1-based index)."""
    for i in range(count):
        A(f"{prefix}-{start + i:03d}", fmt.format(n=i + 1), step, size)


# ---------------------------------------------------------------- ANIMATIONS
R("ANIM-MOV", 1, [
    "Idle (relaxed ready stance, weapon low)", "Walk (in place)", "Run / sprint (in place)",
    "Crouch idle", "Crouch walk", "Strafe left", "Strafe right", "Walk back",
    "Aimed walk forward", "Aimed walk back", "Walk start", "Walk stop", "Run start", "Run stop",
    "Overweight walk (hunched)", "Injured limp (leg fracture)", "Downed crawl (one arm dragging)",
    "Idle bored 1 (check watch glance)", "Idle bored 2 (adjust straps)", "Idle bored 3 (look over shoulder)",
    "Turn in place 90°", "Turn in place 180°",
], "S1")
R("ANIM-MOV", 23, ["Prone down (crouch to belly, 0.6 s)", "Prone up (belly to crouch, 0.7 s)",
    "Prone idle (weapon slung on back)", "Prone crawl loop (elbows and knees, in place)"], "S5")
A("ANIM-MOV-016", "Injured limp (leg fracture)", "S7")
A("ANIM-MOV-017", "Downed crawl (one arm dragging)", "S7")
R("ANIM-ACT", 1, [
    "Roll (lunge dodge, in place)", "Slide (hips dip, in place)", "Get up from ragdoll, face down",
    "Soft landing", "Hard landing (0.4 s recovery)", "Get up from ragdoll, face up",
], "S1")
R("ANIM-ACT", 10, ["Pick up from floor (empty hands)", "Pick up from floor (rifle held)",
                   "Search container, low", "Search container, mid", "Search container, high",
                   "Rummage loop (crouched, container panel open)"], "S4")
A("ANIM-ACT-020", "Raise left wrist to read watch (upper body, hold loop)", "S3")
A("ANIM-ACT-030", "Fuel and start generator (pour, yank cord) loop", "S9")
A("ANIM-ACT-031", "Type at security terminal loop", "S12")
A("ANIM-ACT-040", "Kneel and assemble (inventory crafting) loop", "S14")
A("ANIM-ACT-050", "Crouch and snap dogtag from corpse", "F6")
A("ANIM-ACT-055", "Place boombox on ground", "F7")
R("ANIM-ACT", 60, ["Ladder climb loop (up/down by playback)", "Ladder mount bottom / dismount top",
                   "Hang idle on rail (AM hold pose)"], "S5")
R("ANIM-ACT", 70, ["Operate shutter control (hold)", "Open / close door (push)", "Nail barricade loop",
                   "Kick wedge under door", "Crowbar pry loop", "Swipe keycard", "Enter keypad code",
                   "Disarm alarm loop", "Door slam while running (upper body)"], "S9")
R("ANIM-WPN", 1, ["Draw pistol", "Holster pistol", "Draw long gun (from back)", "Holster long gun",
                  "Draw melee (from hip)", "Holster melee"], "S6")
R("ANIM-WPN", 10, ["Reload P9", "Reload Wasp", "Reload Brace (shell insert loop)", "Reload Kestrel",
                   "Reload Longhorn (per round)", "Reload Nightjar", "Reload Revenant (speedloader)"], "S6")
R("ANIM-WPN", 20, ["Pistol hold idle", "Pistol aim", "Rifle hold idle", "Rifle aim",
                   "Shotgun hold idle", "Shotgun aim"], "S6")
R("ANIM-WPN", 30, ["Fire kick additive (pistol)", "Fire kick additive (rifle)", "Fire kick additive (shotgun)",
                   "Brace pump action", "Longhorn bolt cycle", "Attach / detach attachment (inspect pose)"], "S6")
R("ANIM-MEL", 1, ["Blunt light 1", "Blunt light 2", "Blunt light 3", "Blunt heavy (overhead)",
                  "Axe light 1", "Axe light 2", "Axe light 3", "Axe heavy (overhead)",
                  "Fist jab", "Fist hook"], "S6")
A("ANIM-MEL-011", "Shove (two-hand push)", "S6")
A("ANIM-MEL-020", "Stealth takedown, attacker (paired)", "S8")
A("ANIM-MEL-021", "Stealth takedown, Walker victim (paired)", "S8")
R("ANIM-THR", 1, ["Throw wind-up hold (overarm)", "Throw release"], "S6")
R("ANIM-HIT", 1, ["Hit reaction head", "Hit reaction torso", "Hit reaction left side", "Hit reaction right side"], "S6")
R("ANIM-MED", 1, ["Bandage / gauze wrap", "Take pills", "Medkit use (kneel)", "Apply splint",
                  "Surgical kit (kneel, long)", "Self-inject syringe", "Revive (both sides, kneel and compress)"], "S7")
R("ANIM-STR", 1, ["Struggle pinned standing (victim, paired with ANIM-ZOM-006)",
                  "Struggle on floor (victim, Crawler/Downed)", "Bitten (victim, paired with ANIM-ZOM-008)",
                  "Struggle success shove-off"], "S10")
A("ANIM-INF-001", "Sleeper twitch (small, upper body)", "S10")
A("ANIM-INF-010", "Scan someone (point device, hold)", "S10")
R("ANIM-ZOM", 1, ["Walker idle groan sway", "Walker notice (stop, face, head tilt)", "Walker chase run",
                  "Lunge wind-up (arms rise)", "Lunge leap", "Grapple loop (paired)", "Shoved off stagger",
                  "Bite (paired)", "Hit reaction / stagger", "Death start (into ragdoll)"], "S8")
A("ANIM-ZOM-006", "Grapple loop (paired with ANIM-STR-001)", "S10")
A("ANIM-ZOM-008", "Bite (paired with ANIM-STR-003)", "S10")
R("ANIM-ZOM", 20, ["Crawler crawl loop", "Crawler ankle grab"], "S8")
R("ANIM-ZOM", 30, ["Sprinter run (fast, erratic)", "Sprinter swipe"], "S10")
R("ANIM-JAN", 1, ["Janitor walk pushing mop cart", "Janitor hunt walk (cart abandoned)", "Janitor stop and listen",
                  "Janitor grab wind-up (silent)", "Janitor UV stun (cover face)", "Janitor grab and slam (paired)",
                  "Janitor bash shutter / barricade loop", "Janitor idle mopping"], "S11")
R("ANIM-MUT", 1, ["Stalker idle (crouched)", "Stalker run", "Stalker sprint (quadruped)", "Stalker claw",
                  "Stalker pounce", "Stalker climb loop", "Stalker hit reaction", "Stalker roar"], "S10")
R("ANIM-MUT", 10, ["Supermutant idle", "Supermutant run", "Supermutant slam", "Supermutant charge start",
                   "Supermutant charge loop", "Supermutant screech", "Supermutant wall run", "Supermutant ceiling drop",
                   "Supermutant transformation (2.5 s)", "Supermutant revive kneel (frozen 10 s pose)",
                   "Supermutant death"], "S13")
N("ANIM-NPC", 1, 20, "Tower ambient NPC loop {n} (see 14 §14.14: smoking, arguing, mugging scene parts, cards, TV fixing, guard patrol, bartender, vendors)", "F1")
R("ANIM-TWR", 1, ["Blueprint wheel spin (Vex pulls lever)"], "F8")
A("ANIM-TWR-010", "Record press operation (June)", "F7")
R("ANIM-TWR", 20, ["Sit (chairs, sofas, bar stools)", "Rest on bed (lie down)"], "F2")
A("ANIM-FLT-010", "Engrave at workbench", "F7")
R("ANIM-EMO", 1, ["Wave (upper body)", "Hands Up (holster, both hands raised)", "Point (upper body)", "Thumbs Up"], "S15")
N("ANIM-EMO", 5, 8, "Paid emote {n} (shop, 19 §19.5)", "F11")

# ---------------------------------------------------------------- MODELS
A("MDL-ARR-001", "Arrival freight-lift interior (dark, flickering light)", "S3", "16x12x16")
N("MDL-CHR", 1, 12, "Survivor face {n}", "S14", "1x1x1")
N("MDL-CHR", 13, 16, "Survivor hair style {n}", "S14", "1x1x1")
N("MDL-CHR", 29, 8, "Survivor skin tone {n} (texture set)", "S14", "1x1x1")
N("MDL-CHR", 37, 3, "Survivor build {n} (slim, medium, heavy R15 body)", "S1", "2x5x1")
A("MDL-CHR-090", "Test Raider bot body (orange)", "S15", "2x5x1")
R("MDL-CON", 1, ["Trash bin", "Rubble pile", "Store shelf", "Clothes rack", "Till / register", "Staff locker",
                 "Staff bag", "Display case (glass)", "Med cabinet", "Med Safe (metal, keypad + card slot)",
                 "Weapon crate (army green)", "Stockroom crate", "Toolbox"], "S4", "3x4x2")
A("MDL-CON-020", "High-Roller supply crate with parachute", "F9", "4x4x4")
A("MDL-ENV-010", "Roll-down shop shutter (3 states, animated)", "S2", "20x12x1")
R("MDL-ENV", 20, ["Ceiling light panel (shootable)", "Shop spotlight (shootable)", "Galleria pendant light (shootable)",
                  "Emergency light (dim red)"], "S2", "2x1x2")
A("MDL-ENV-030", "Generator (diesel, panel with amber lamp)", "S9", "6x5x4")
A("MDL-ENV-040", "Floor glass shards decal + trigger", "S9", "6x0.2x6")
A("MDL-ENV-050", "Destructible wall chunk set (pre-fractured plasterboard)", "S13", "20x14x1")
A("MDL-ENV-060", "Store alarm box (door frame, red light)", "S9", "1x1x0.5")
A("MDL-ENV-061", "Hanging sign trap", "S9", "4x2x0.2")
A("MDL-ENV-062", "Bottle string trap", "S9", "6x1x0.2")
A("MDL-ENV-070", "Security terminal (CRT, keyboard, green screen)", "S2", "3x5x2")
A("MDL-ENV-071", "Evac route wall sign (lights up with arrow)", "S12", "4x2x0.3")
A("MDL-ENV-080", "Field workbench", "S2", "6x4x3")
A("MDL-ENV-090", "Ceiling PA speaker", "S2", "1x1x1")
N("MDL-ENV", 100, 81, "Mall decor kit piece {n} (benches, planters, fake palms, trolleys, signs, kiosks, mannequins, barricades, army checkpoint, campsite, police tape, burnt cars, fountains, escalators, stairs, doors, storefront frames, railings)", "S2", "4x4x4")
A("MDL-ENV-110", "Mall directory board 'You are here' (per floor)", "S2", "4x7x1")
A("MDL-ENV-181", "Service door (shop back door)", "S2", "4x8x0.5")
A("MDL-ENV-182", "Security door (heavy)", "S2", "6x8x0.6")
A("MDL-ENV-183", "Interior door", "S2", "4x8x0.4")
A("MDL-ENV-184", "Service elevator car and doors", "S9", "8x10x8")
A("MDL-ENV-185", "Escalator (animated steps)", "S2", "6x14x30")
A("MDL-ENV-186", "Ladder", "S5", "2x14x0.5")
A("MDL-ENV-187", "Storefront glass pane (Large)", "S2", "20x12x0.3")
A("MDL-ENV-188", "Window glass pane (Medium)", "S2", "6x6x0.2")
A("MDL-ENV-189", "Barricade planks (nailed)", "S9", "4x8x0.5")
A("MDL-ENV-197", "Stacked shipping crates (climbable stack, 2 high, each 3.5 tall)", "S5", "6x7x6")
A("MDL-ENV-198", "Collapsed ceiling slab (crawl space, 2.3 clearance)", "S5", "12x4x10")
A("MDL-ENV-190", "Door wedge (placed)", "S9", "1x0.3x1")
A("MDL-ENV-191", "Skylight panel (galleria roof)", "S2", "20x1x20")
A("MDL-ENV-192", "Dry fountain (galleria centre)", "S2", "28x4x28")
A("MDL-ENV-193", "Keypad (Med Safe / stockroom)", "S9", "1x1.5x0.3")
A("MDL-ENV-194", "Shutter control box", "S9", "1x1.5x0.4")
A("MDL-ENV-195", "Security Office shutter control panel", "S9", "4x3x1")
A("MDL-ENV-196", "Outdoor backdrop (car parks, fences, burnt cars, city lights)", "S2", "800x40x800")
R("MDL-FLT", 1, ["Bunk Studio interior template", "Executive Suite interior template", "Skyline Penthouse interior template"], "S16", "40x14x30")
A("MDL-FLT-002", "Executive Suite interior template", "F2", "40x14x26")
A("MDL-FLT-003", "Skyline Penthouse interior template (with terrace)", "F2", "70x14x40")
R("MDL-FLT", 10, ["Workbench (flat)", "Stash chest", "Survivor terminal", "Flat terminal (laptop on desk)",
                  "Memorial wall", "Trophy shelf", "Bed (bunk)", "Overflow crate"], "S16", "4x4x3")
A("MDL-FLT-011", "Stash chest (also tower test stash in S4)", "S4", "4x3x2")
R("MDL-FLT", 20, ["Weapon wall mount", "Trophy pedestal with spotlight", "Glass display case (6 slots)", "Mutant trophy wall mount"], "F2", "3x4x1")
A("MDL-FLT-090", "Door banner: weekly Tower Standing top 10", "F10", "3x5x0.1")
N("MDL-FLT", 91, 9, "Door banner (shop) {n}", "F11", "3x5x0.1")
R("MDL-FUR", 1, [
    "Army cot", "Old sofa", "Leather sofa", "Armchair", "Coffee table", "Dining table + 4 chairs", "Crate table",
    "Bookshelf", "Floor lamp", "Workbench lamp", "String lights", "Neon sign OPEN", "Neon sign skull",
    "Neon arcade cabinet", "CRT TV", "Flat-screen TV", "Potted plants (3 kinds)", "Dead plant", "Rug (5 patterns)",
    "Posters (10 designs)", "Graffiti decals (8)", "Gun safe (decor)", "Punching bag", "Fish tank", "Mannequin",
    "Mall bench", "Shopping trolley", "Golden escalator sign", "Coffee Bar", "Upgraded Armory Bench",
    "Vintage Jukebox", "Security Terminal Desk", "Radio Set", "Penthouse bar", "Grand piano", "Hot tub",
], "F2", "4x4x4")
R("MDL-GUN", 1, ["P9 pistol", "Wasp SMG", "Brace pump shotgun", "Kestrel assault rifle", "Longhorn hunting rifle"], "S6", "4x1x0.5")
R("MDL-GUN", 6, ["Nightjar (Exotic suppressed AR)", "Revenant (Exotic magnum revolver)"], "F8", "4x1x0.5")
R("MDL-WPN", 10, ["Pipe", "Crowbar", "Fire axe"], "S6", "3x0.5x0.5")
R("MDL-WPN", 20, ["Red Dot Sight", "4x Scope", "Suppressor", "Extended Mag", "Foregrip"], "S6", "1x0.5x0.5")
A("MDL-WPN-025", "Thermal Sight", "F8", "1x0.5x0.5")
R("MDL-WPN", 30, ["Muzzle flash mesh (pistol/rifle)", "Shell casing", "Tracer streak"], "S6", "1x1x1")
R("MDL-THR", 1, ["Bottle", "Brick", "Noise Decoy (radio taped to wire)", "Molotov", "UV Stun Flare", "Smoke Can"], "S6", "1x1x1")
R("MDL-ARM", 1, ["Light Vest", "Heavy Vest", "Helmet"], "S6", "2x2x1")
A("MDL-ARM-004", "Bastion Plate (Exotic)", "F8", "2x2x1")
R("MDL-PCK", 1, ["Satchel", "Field Pack", "Tactical Bag"], "S4", "2x2x1")
R("MDL-ITM", 1, ["Light ammo box", "Medium ammo box", "Heavy ammo box", "Shells box"], "S4", "1x1x1")
R("MDL-ITM", 10, ["Bandage", "Gauze Pack", "Painkillers", "Medkit", "Splint", "Surgical Kit",
                  "Infection Suppressant", "Antidote Syringe (glowing green)", "Adrenaline Shot",
                  "Improvised Suppressant"], "S4", "1x1x1")
R("MDL-ITM", 20, ["Rag", "Alcohol", "Tape", "Wire", "Radio", "Chemical Flask", "Syringe", "Scrap",
                  "Mechanical Parts", "Electronic Parts", "Precision Parts", "Exotic Alloy", "Cloth"], "S4", "1x1x1")
R("MDL-ITM", 40, ["Smartphone", "Wristwatch", "Perfume Bottle", "Cash Bundle", "Gold Chain", "Jewellery Box",
                  "Designer Handbag", "Game Console", "Vintage Camera", "Golden Mall Statue",
                  "Classified Security Keycard", "Supermutant Trophy (head)"], "S4", "1x1x1")
A("MDL-ITM-051", "Supermutant Trophy (head)", "S13", "2x2x2")
R("MDL-ITM", 60, ["Flashlight", "Battery", "Door Wedge", "Planks (stack)", "Fuel Can", "Boombox", "Name Tag"], "S4", "1x1x1")
A("MDL-ITM-065", "Boombox (world and held)", "F7", "2x1x1")
A("MDL-ITM-066", "Name Tag (engraving plate)", "F7", "1x1x0.1")
A("MDL-ITM-070", "Infrared Thermometer", "S10", "1x1x0.5")
A("MDL-ITM-071", "Blood Scanner (light shows result)", "S10", "1x2x0.5")
R("MDL-ITM", 80, ["Keycard Food Court", "Keycard Electronics", "Keycard Department Store", "Keycard Pharmacy", "Keycard Security"], "S9", "1x1x0.1")
A("MDL-ITM-090", "Safe code sticky note (shows code)", "S9", "1x1x0.1")
A("MDL-ITM-091", "Dogtag", "F6", "1x1x0.1")
A("MDL-ITM-092", "Blank Vinyl", "F7", "2x2x0.1")
A("MDL-ITM-093", "Vinyl record with sleeve (sleeve art from UI-VIN)", "F7", "2x2x0.1")
A("MDL-ITM-094", "Dropped item bag (small items)", "S4", "1x1x1")
A("MDL-ITM-095", "Blueprint (rolled paper, tier-coloured tube)", "S4", "1x1x1")
A("MDL-JAN-001", "The Janitor (huge, hazmat-patched overalls, gas mask) with mop cart", "S11", "4x8x3")
A("MDL-MUT-001", "Stalker Mutant overlay (built on the survivor: veins, claws, jaw)", "S10", "2x5x1")
A("MDL-MUT-010", "Supermutant Brute", "S13", "6x11x4")
R("MDL-MUT", 11, ["Supermutant Banshee", "Supermutant Creeper", "Supermutant Juggernaut"], "F9", "6x11x4")
R("MDL-MUT", 20, ["Stalker skin Rotten", "Supermutant roar set (visual mouth variant)", "Stalker skin Ashen",
                  "Supermutant skin Chitin", "Mutation VFX holder Black Bloom", "Supermutant skin Leviathan"], "F10", "6x11x4")
R("MDL-NPC", 1, ["Concierge Marla", "Quartermaster Okafor", "Pawnbroker Lenny", "Bartender June",
                 "Contract Officer Reyes", "Mail Clerk Pip", "Second-Hand Sal"], "F1", "2x5x1")
A("MDL-NPC-002", "Quartermaster Okafor", "S16", "2x5x1")
A("MDL-NPC-003", "Pawnbroker Lenny", "S16", "2x5x1")
A("MDL-NPC-004", "Bartender June", "F7", "2x5x1")
A("MDL-NPC-005", "Contract Officer Reyes", "F6", "2x5x1")
A("MDL-NPC-006", "Mail Clerk Pip", "F4", "2x5x1")
A("MDL-NPC-007", "Second-Hand Sal", "F2", "2x5x1")
A("MDL-NPC-010", "Vex (Black Market broker)", "F8", "2x5x1")
A("MDL-NPC-011", "Sully (catalyst dealer)", "F9", "2x5x1")
A("MDL-NPC-012", "Dr. Halloran (The Lab)", "F9", "2x5x1")
A("MDL-NPC-020", "Tower guard (armoured)", "F1", "2x5x1")
N("MDL-NPC", 30, 12, "Ambient resident {n}", "F1", "2x5x1")
N("MDL-OUT", 1, 20, "Survivor outfit set {n} (19 §19.5)", "F11", "2x5x1")
N("MDL-CHM", 1, 12, "Gun charm {n}", "F11", "0.5x0.5x0.5")
A("MDL-PLR-010", "Wristwatch with SurfaceGui face", "S3", "0.3x0.1x0.3")
A("MDL-PLR-011", "Armband (left arm, colour set client-side)", "S15", "0.6x0.4x0.6")
A("MDL-RAID-001", "Freight lift interior (entry gates)", "S2", "16x12x16")
A("MDL-RAID-010", "Evac helicopter", "S12", "40x14x12")
A("MDL-RAID-011", "Garage freight lift platform and doors", "S12", "16x12x12")
A("MDL-RAID-012", "Rooftop helipad cage with two lockable gates", "S2", "40x10x40")
A("MDL-RAID-013", "Garage bay blast shutters (two)", "S2", "20x12x1")
N("MDL-TRO", 1, 12, "Achievement trophy {n} (see 13 §13.9 table)", "F10", "1x2x1")
A("MDL-TWR-001", "Tower freight-elevator loading scene (Arrival → Tower)", "S3", "16x12x16")
A("MDL-TWR-010", "Tower ground floor shell (atrium, fountain, columns)", "S16", "120x40x120")
A("MDL-TWR-011", "Quartermaster counter with cage", "S16", "10x6x4")
A("MDL-TWR-012", "Pawnbroker counter", "S16", "8x6x4")
A("MDL-TWR-013", "Security checkpoint (turrets, arch)", "F1", "20x10x6")
A("MDL-TWR-014", "Concierge desk", "F1", "10x4x4")
A("MDL-TWR-015", "Mail Room counter and pigeonholes", "F4", "10x8x4")
A("MDL-TWR-016", "The Drain bar interior", "F7", "30x14x20")
A("MDL-TWR-017", "Sal's furniture stall", "F2", "10x8x6")
A("MDL-TWR-018", "Residential corridor kit: Low Block (graffiti, laundry, buzzing lights)", "F1", "60x12x8")
A("MDL-TWR-019", "Residential corridor kit: Mid Block", "F1", "60x12x8")
A("MDL-TWR-020", "Flat door with number plate and banner slot", "S16", "4x8x0.5")
A("MDL-TWR-021", "Residential corridor kit: Penthouse level", "F1", "60x12x8")
A("MDL-TWR-022", "Lift lobby (every level) and lift doors", "F1", "20x12x12")
A("MDL-TWR-023", "Roof Black Market (lounge, helipad decor, barrel)", "F8", "120x10x120")
A("MDL-TWR-024", "Stairwell decor (with mugging scene space)", "F1", "12x24x12")
A("MDL-TWR-030", "Tower Standing board", "F1", "8x6x1")
A("MDL-TWR-040", "Blueprint wheel (big physical wheel)", "F8", "8x10x2")
A("MDL-TWR-041", "Catalyst stall (Sully)", "F9", "8x8x6")
A("MDL-TWR-042", "The Lab (Dr. Halloran, tanks with mutant variants)", "F9", "20x12x16")
A("MDL-TWR-050", "Flea listing terminal", "F4", "2x5x2")
A("MDL-TWR-051", "Appraisal terminal", "F4", "2x5x2")
A("MDL-TWR-052", "Flea decor stall", "F4", "8x8x6")
A("MDL-TWR-060", "Most Wanted LED wall (3 storeys)", "F6", "40x36x2")
A("MDL-TWR-061", "Contract terminal", "F6", "2x5x2")
A("MDL-TWR-062", "Contract Board (daily contracts)", "F10", "8x6x1")
A("MDL-TWR-070", "Record press (Pressing Booth)", "F7", "6x6x4")
A("MDL-TWR-071", "Public jukebox (The Drain)", "F7", "3x6x2")
A("MDL-TWR-080", "Transit Gates freight elevator doors (4) and deploy hall", "S3", "40x14x20")
A("MDL-TWR-090", "Skyline backdrop (mall in the distance, fires, searchlights)", "F1", "1000x200x10")
R("MDL-ZOM", 1, ["Walker body variant 1", "Walker body variant 2", "Walker body variant 3", "Crawler body (legless / broken)"], "S8", "2x5x1")
A("MDL-ZOM-005", "Sprinter overlay (built on dead Sleeper's survivor)", "S10", "2x5x1")

# ---------------------------------------------------------------- TEXTURES
N("TEX-ENV", 1, 40, "Mall surface / grime / blood / signage texture {n}", "S2")
N("TEX-ZOM", 1, 12, "Zombie outfit tint texture {n}", "S8")
A("TEX-INF-001", "Sleeper visible veins (under flashlight, symptom)", "S10")
A("TEX-ITM-030", "Tainted item dark veins overlay (under flashlight)", "S10")
N("TEX-FIN", 1, 24, "Weapon finish {n} (19 §19.5)", "F11")
N("TEX-STK", 1, 30, "Weapon sticker {n} (19 §19.5)", "F11")
N("TEX-WAL", 1, 12, "Wallpaper {n}", "F2")
N("TEX-FLR", 1, 8, "Flooring {n}", "F2")

# ---------------------------------------------------------------- VFX
R("VFX-ENV", 1, ["Glass shatter shards burst"], "S9")
A("VFX-ENV-005", "Plaster dust burst (destructible wall)", "S13")
R("VFX-ENV", 10, ["Red Alert strobe and emergency-light pulse", "Evac zone floor glow (amber → green)", "Helicopter rotor wash dust"], "S12")
A("VFX-ENV-020", "Dust motes in light shafts", "S2")
A("VFX-ENV-021", "Fire (barrels, molotov pool)", "S6")
A("VFX-ENV-022", "Sparks (shot light, generator start)", "S9")
A("VFX-HIT-001", "Blood hit spurt", "S6")
R("VFX-WPN", 1, ["Muzzle flash", "Bullet impact concrete", "Bullet impact metal", "Bullet impact wood", "Bullet impact glass", "Smoke Can cloud", "UV flare light and sparks"], "S6")
A("VFX-ITM-001", "World item glint (tier colour for Rare+)", "S4")
A("VFX-UI-001", "Reveal shimmer (Epic+)", "S4")
A("VFX-PLR-003", "Blood trail decal", "S7")
R("VFX-MUT", 1, ["Mutant noise ping ring", "Flashlight beacon glow (mutant view)", "Ghost thermal silhouettes", "Mutant night-vision tint"], "S10")
A("VFX-MUT-010", "Sleeper corpse mutation (Sprinter)", "S10")
A("VFX-MUT-011", "Supermutant transformation burst", "S13")
A("VFX-MUT-012", "Second Wind explosive roar shockwave", "S13")
A("VFX-MUT-013", "Screech outline (Supermutant view)", "S13")
A("VFX-MUT-020", "Mutation VFX Black Bloom (Mutant Track)", "F10")
A("VFX-TWR-001", "Moving boxes scene (Move-in)", "F3")
A("VFX-CAT-001", "Red smoke (supply drop marker)", "F9")
A("VFX-CAT-002", "Blood Moon sky tint through skylights", "F9")
N("VFX-DTH", 1, 6, "Death effect {n} (19 §19.5)", "F11")
N("VFX-MFX", 1, 6, "Mutation effect {n} (19 §19.5)", "F11")
N("VFX-FLR", 1, 6, "Extraction flare {n} (19 §19.5)", "F11")

# ---------------------------------------------------------------- UI
R("UI-FRM", 1, ["Panel 9-slice", "Header bar", "Button", "Tab"], "S1")
A("UI-ADM-001", "Admin menu panel", "S1")
N("UI-MOB", 1, 24, "Mobile button icon {n} (Action, Context, Aim, Fire, Reload, Crouch, Sprint, Light, Watch, Breath, Swap, Throw, Backpack, Comms, Ping, Radio, Weapon wheel, Quick bar slots, Shove, Claw, Pounce, Slam, Charge, Screech)", "S1")
A("UI-SET-001", "Settings: General", "S16")
A("UI-SET-010", "Settings: Controls (rebinding)", "S16")
A("UI-SET-020", "Settings: Layout (mobile buttons)", "S16")
A("UI-ARR-001", "Arrival screen (Go home / Visit friend / notices)", "S3")
R("UI-HUD", 1, ["Weapon panel", "Quick bar"], "S6")
A("UI-HUD-002", "Quick bar", "S4")
A("UI-HUD-010", "Squad list", "S15")
R("UI-HUD", 20, ["Vitals (health bar + body silhouette)", "Status icons set", "Stamina arc", "Weight bar", "Downed bar", "Damage direction arc"], "S7")
A("UI-HUD-022", "Stamina arc", "S1")
A("UI-HUD-023", "Weight bar", "S4")
A("UI-HUD-030", "Context prompt (icon, word, hold ring)", "S4")
R("UI-HUD", 40, ["Evac marker", "Evac countdown", "Terminal progress ring"], "S12")
A("UI-HUD-050", "Toast (level up, contract, achievement)", "S14")
A("UI-HUD-060", "Wanted tag (own screen)", "F6")
A("UI-HUD-061", "Bodyguard VIP radio (client health + marker)", "F6")
A("UI-HUD-070", "Catalyst icon (live odds)", "F9")
R("UI-HUD", 80, ["Ping: location", "Ping: item", "Ping: enemy", "Ping: player", "Squad tag", "Downed tag + edge arrow"], "S15")
A("UI-HUD-090", "Subtitles", "S12")
R("UI-HUD", 100, ["Tower: MC and level badge", "Tower: Shop button", "Tower: Pass button", "Tower: Invite button", "Tower: Party button", "Tower: Settings button"], "S16")
A("UI-HUD-110", "First-time hint panel", "S16")
A("UI-ICO-001", "Mall Cash icon", "S16")
N("UI-ICO", 2, 30, "Generic line icon {n} (status, actions, tiers, tabs)", "S4")
A("UI-VFX-001", "Low-health / fear vignette image", "S7")
R("UI-INV", 1, ["Inventory screen"], "S4")
A("UI-INV-010", "Container panel", "S4")
A("UI-INV-020", "Craft tab", "S14")
A("UI-RES-001", "Haul tally screen", "S4")
A("UI-RES-010", "Death screen", "S7")
A("UI-RES-020", "Raid summary", "S3")
A("UI-STR-001", "Struggle bar", "S10")
A("UI-INF-001", "Sleeper veins screen overlay (3 stages)", "S10")
A("UI-INF-010", "Scanner result readout", "S10")
A("UI-GHO-001", "Ghost tools bar", "S10")
A("UI-MUT-001", "Supermutant kit HUD", "S13")
A("UI-MUT-002", "Stalker kit HUD", "S10")
A("UI-MUT-010", "Second Wind prompt", "S13")
A("UI-SUR-001", "Survivor Draft (3 cards)", "S14")
R("UI-DEP", 1, ["Deploy panel", "Raid found", "Searching"], "S15")
A("UI-DEP-010", "Insurance panel", "F5")
R("UI-COM", 1, ["Quick-line wheel", "Speech bubble"], "S15")
A("UI-COM-010", "Emote wheel", "S15")
A("UI-TWR-001", "Lift floor picker", "F1")
A("UI-TWR-010", "Concierge panel (vacancies, Move-in, waitlist, upgrades, visits)", "F1")
A("UI-TWR-020", "Party panel", "S15")
A("UI-TWR-030", "Nameplate (display name, title badge, frame)", "F1")
A("UI-FLT-001", "Stash panel", "S16")
A("UI-FLT-010", "Workbench panel", "S16")
A("UI-FLT-020", "Flat terminal", "S16")
A("UI-FLT-030", "Build catalogue", "F2")
A("UI-FLT-040", "Gunsmith (finishes, stickers, charms)", "F11")
A("UI-COL-001", "Collection Book", "F10")
A("UI-VEN-001", "Vendor buy/sell", "S16")
R("UI-FLEA", 1, ["Flea browse", "Flea barter", "Appraisal"], "F4")
A("UI-MAIL-001", "Mail", "F4")
A("UI-MAIL-010", "Repossession", "F5")
R("UI-BNT", 1, ["Most Wanted wall SurfaceGui", "Target viewport card"], "F6")
A("UI-BNT-010", "Claim panel", "F6")
A("UI-BNT-020", "Dossier", "F6")
A("UI-BNT-030", "Escort contracts", "F6")
A("UI-BNT-040", "Hire Board", "F6")
A("UI-REL-001", "Engrave panel", "F7")
A("UI-REL-010", "Pressing Booth panel", "F7")
A("UI-REL-020", "Relic history card", "F7")
N("UI-VIN", 1, 12, "Vinyl sleeve design {n}", "F7")
A("UI-WHL-001", "Blueprint Wheel and Fixed Trade-up panel", "F8")
A("UI-CAT-001", "Catalyst dealer panel", "F9")
A("UI-LAB-001", "Supermutant variants panel", "F9")
R("UI-SHOP", 1, ["Shop"], "F11")
A("UI-SHOP-010", "Cosmetic 3D preview", "F11")
A("UI-SHOP-020", "Odds table panel", "F8")
A("UI-PASS-001", "Evac Pass page", "F11")
A("UI-PASS-010", "Restricted crate choice", "F11")
N("UI-NPF", 1, 6, "Nameplate frame {n}", "F10")
N("UI-ACH", 1, 40, "Achievement icon ACH-{n:03d}", "F10")
N("UI-FUR", 1, 56, "Furniture / wallpaper / flooring catalogue icon {n}", "F2")
N("UI-COS", 1, 130, "Cosmetic icon {n} (finishes, stickers, charms, outfits, death fx, mutation fx, voice packs, flares, emotes, banners)", "F11")
# item icons: one per catalogue item, same order as the MDL-ITM / MDL-GUN groups
ITEM_ICONS = [
    "P9", "Wasp", "Brace", "Kestrel", "Longhorn", "Nightjar", "Revenant", "Pipe", "Crowbar", "Fire Axe",
    "Light ammo", "Medium ammo", "Heavy ammo", "Shells", "Red Dot", "4x Scope", "Suppressor", "Extended Mag",
    "Foregrip", "Thermal Sight", "Light Vest", "Heavy Vest", "Helmet", "Bastion Plate", "Satchel", "Field Pack",
    "Tactical Bag", "Flashlight", "Battery", "Infrared Thermometer", "Blood Scanner", "Door Wedge", "Planks",
    "Fuel Can", "Boombox", "Name Tag", "Keycard Food Court", "Keycard Electronics", "Keycard Department Store",
    "Keycard Pharmacy", "Keycard Security", "Safe code note", "Bandage", "Gauze", "Painkillers", "Medkit",
    "Splint", "Surgical Kit", "Suppressant", "Antidote", "Adrenaline", "Improvised Suppressant", "Bottle",
    "Brick", "Noise Decoy", "Molotov", "UV Stun Flare", "Smoke Can", "Rag", "Alcohol", "Tape", "Wire", "Radio",
    "Chemical Flask", "Syringe", "Scrap", "Mechanical Parts", "Electronic Parts", "Precision Parts",
    "Exotic Alloy", "Cloth", "Smartphone", "Wristwatch", "Perfume", "Cash Bundle", "Gold Chain",
    "Jewellery Box", "Handbag", "Game Console", "Vintage Camera", "Golden Mall Statue", "Classified Keycard",
    "Supermutant Trophy", "Blueprint (Guns)", "Blueprint (Armour)", "Blueprint (Attachments)", "Dogtag",
    "Blank Vinyl", "Vinyl", "Arcade cabinet (decor)", "Mall bench (decor)", "Trolley (decor)",
    "Golden escalator sign (decor)",
]
for i, name in enumerate(ITEM_ICONS):
    A(f"UI-ITM-{i + 1:03d}", f"Item icon: {name}", "S4")

# ---------------------------------------------------------------- SOUND (24)
def S(aid, desc, step):
    A(aid, desc, step)


R("SFX-PLR", 10, ["Heartbeat loop (fear)", "Breathing calm", "Breathing heavy", "Breathing laboured", "Gasp (hold breath ends)"], "S1")
R("SFX-PLR", 21, ["Crouch rustle", "Roll", "Slide scrape loop", "Mantle / vault grunt", "Landing light", "Landing heavy"], "S1")
A("SFX-PLR-024", "Mantle / vault grunt + hands on rail", "S5")
R("SFX-PLR", 27, ["Bone crack", "Pain grunt 1", "Pain grunt 2", "Pain grunt 3", "Body fall thump", "Downed crawl drag loop", "Death exhale"], "S7")
R("SFX-PLR", 34, ["Ladder climb loop", "Window climb scrape"], "S5")
R("SFX-PLR", 40, ["Prone drop / rise (cloth and gear thud)", "Prone crawl drag loop (elbows, gear rattle)",
    "Ledge climb-up (hands slap, boots scrabble, strain grunt)"], "S5")
A("SFX-PLR-036", "Inventory rummage loop", "S4")
A("SFX-PLR-037", "Equip backpack / armour", "S4")
A("SFX-PLR-038", "Low-health ringing", "S7")
N("SFX-PLR", 50, 6, "Footstep tile {n} (walk 1–3, sprint 4–6)", "S1")
N("SFX-PLR", 56, 6, "Footstep concrete {n} (walk 1–3, sprint 4–6)", "S1")
R("SFX-PLR", 62, ["Footstep carpet", "Footstep metal", "Footstep glass shards crunch 1", "Footstep glass shards crunch 2", "Footstep water", "Footstep grate"], "S2")
R("SFX-WPN", 1, ["P9 close", "P9 distant", "Wasp close", "Wasp distant", "Brace close", "Brace distant", "Brace pump",
                 "Kestrel close", "Kestrel distant", "Longhorn close", "Longhorn distant", "Longhorn bolt",
                 "Nightjar close", "Nightjar distant", "Revenant close", "Revenant distant", "Suppressed shot",
                 "Gunshot tail galleria", "Gunshot tail corridor", "Gunshot tail outdoor",
                 "Reload pistol", "Reload SMG", "Reload shotgun shell", "Reload AR", "Reload rifle", "Reload revolver",
                 "Weapon swap / draw", "Holster", "Aim in", "Dry fire click", "Shell casings", "Attach / detach"], "S6")
R("SFX-WPN", 40, ["Flesh impact thud", "Headshot crack", "Armour impact ping", "Impact concrete", "Impact metal",
                  "Impact glass", "Impact wood", "Impact tile", "Bullet whiz-by"], "S6")
R("SFX-MEL", 1, ["Swing light pipe", "Swing light crowbar", "Swing light axe", "Swing heavy pipe", "Swing heavy crowbar",
                 "Swing heavy axe", "Hit flesh pipe", "Hit flesh crowbar", "Hit flesh axe", "Hit wall / prop",
                 "Fist punch", "Shove"], "S6")
A("SFX-MEL-013", "Stealth takedown crunch", "S8")
A("SFX-MEL-014", "Barricade plank break", "S9")
R("SFX-THR", 1, ["Throw whoosh", "Bottle smash", "Brick thud", "Noise Decoy loop", "Molotov smash", "Fire loop",
                 "UV flare ignite", "UV flare fizz loop", "Smoke Can hiss loop"], "S6")
R("SFX-ENV", 1, ["Glass break small", "Glass break medium", "Glass break large", "Shards settling", "Destructible wall break"], "S9")
A("SFX-ENV-005", "Destructible wall break (plaster crash)", "S13")
R("SFX-ENV", 10, ["Shutter rattle", "Shutter slam", "Shutter bash loop", "Door open", "Door close", "Door slam",
                  "Security door open", "Barricade nailing loop", "Wedge kick-in", "Crowbar pry loop", "Store alarm loop",
                  "Trap sign clatter", "Trap bottle jangle", "Alarm disarm beep", "Keycard accept", "Keycard reject",
                  "Keypad beep", "Keypad open", "Keypad wrong", "Med Safe unlock", "Crowbar pop",
                  "Generator start", "Generator hum loop", "Power-on clunk and buzz", "Light shot out",
                  "Escalator loop", "Elevator ding", "Elevator motor loop", "Elevator doors", "Fuel pour"], "S9")
R("SFX-ENV", 40, ["Open bin lid", "Open locker", "Open crate", "Open till drawer", "Open cabinet", "Item pick up", "Item drop"], "S4")
A("SFX-ENV-047", "Emergency light buzz", "S2")
A("SFX-ENV-048", "Fire crackle", "S6")
R("SFX-ZOM", 1, ["Walker groan 1", "Walker groan 2", "Walker groan 3", "Walker groan 4", "Walker groan 5", "Walker groan 6"], "S8")
R("SFX-ZOM", 10, ["Alert screech", "Chase breathing loop", "Shuffle footsteps loop"], "S8")
R("SFX-ZOM", 20, ["Lunge wind-up", "Lunge leap", "Grapple loop", "Shoved off", "Bite", "Pound on shutter loop"], "S8")
A("SFX-ZOM-022", "Grapple loop (snarl, struggle)", "S10")
A("SFX-ZOM-024", "Bite", "S10")
R("SFX-ZOM", 30, ["Zombie hit reaction", "Zombie death"], "S8")
R("SFX-ZOM", 40, ["Crawler crawl", "Crawler ankle grab"], "S8")
R("SFX-ZOM", 50, ["Sprinter run", "Sprinter swipe", "Sprinter shriek"], "S10")
A("SFX-ZOM-060", "Horde surge roar (Red Alert)", "S12")
A("SFX-JAN-001", "PA crackle (Janitor enters)", "S11")
R("SFX-JAN", 10, ["Mop cart squeal loop", "Heavy breathing loop", "Wet inhale (grab tell)", "Grab and slam", "Stunned howl", "Heavy boots loop"], "S11")
R("SFX-MUT", 1, ["Sleeper corpse mutating", "Stalker mutation scream"], "S10")
R("SFX-MUT", 3, ["Supermutant transformation roar", "Supermutant death", "Second Wind revive roar"], "S13")
R("SFX-MUT", 10, ["Stalker roar 1", "Stalker roar 2", "Stalker roar 3", "Stalker roar 4", "Stalker claw", "Stalker pounce", "Stalker climb skitter"], "S10")
R("SFX-MUT", 20, ["Supermutant slam 1", "Supermutant slam 2", "Charge start", "Charge loop", "Charge impact", "Screech",
                  "Footsteps 1", "Footsteps 2", "Wall-run skitter", "Ceiling drop", "Hit reaction 1", "Hit reaction 2",
                  "Breathing loop"], "S13")
R("SFX-MUT", 33, ["Banshee screech", "Creeper skitter", "Juggernaut steps"], "F9")
A("SFX-MUT-040", "Mutant Track roar Grave Howl", "F10")
R("SFX-INF", 1, ["Sleeper cough 1", "Sleeper cough 2", "Sleeper cough 3", "Sleeper cough 4"], "S10")
R("SFX-INF", 10, ["Sleeper faint heartbeat", "Bitten sting", "Turning rising tone", "Cure exhale", "Scanner beep", "Scanner infected", "Thermometer beep"], "S10")
R("SFX-MED", 1, ["Bandage wrap", "Pill bottle", "Medkit open", "Splint strap", "Surgical kit", "Syringe inject", "Revive effort"], "S7")
R("SFX-RAID", 1, ["Freight lift descent", "Lift doors open"], "S3")
R("SFX-RAID", 4, ["Terminals online chime", "Terminal activation beeps", "Terminal activated klaxon"], "S12")
R("SFX-RAID", 10, ["Red Alert siren loop", "Evac open horn"], "S12")
R("SFX-RAID", 20, ["Helicopter rotor", "Garage freight lift"], "S12")
R("SFX-RAID", 30, ["Departure abort buzz", "Lockdown slam", "Reopen unlock"], "S13")
A("SFX-RAID-033", "Early depart confirm", "S12")
A("SFX-RAID-040", "Sealed boom", "S12")
A("SFX-RAD-001", "Radio static intro", "F6")
R("SFX-COM", 1, ["Squad radio key up", "Squad radio release"], "S15")
A("SFX-COM-005", "Ping", "S15")
A("SFX-COM-010", "VIP radio crackle", "F6")
R("SFX-BNT", 1, ["Wall hum loop", "New #1 sting"], "F6")
R("SFX-BNT", 10, ["Dogtag snap", "Claim register"], "F6")
A("SFX-BNT-020", "Hunter proximity ticking", "F6")
A("SFX-BNT-030", "Vigilante sting", "F6")
A("SFX-REL-001", "Relic found ping", "F7")
A("SFX-REL-010", "Engraving", "F7")
R("SFX-REL", 20, ["Record press", "Needle drop", "Boombox click"], "F7")
R("SFX-CRF", 1, ["Tape rip", "Metal clank", "Liquid pour", "Wire twist", "Wood saw"], "S14")
R("SFX-LOOT", 1, ["Reveal Common", "Reveal Uncommon", "Reveal Rare", "Reveal Epic", "Reveal Exotic", "Reveal Relic"], "S4")
R("SFX-LOOT", 10, ["Rising tone Common", "Rising tone Uncommon", "Rising tone Rare", "Rising tone Epic", "Rising tone Exotic", "Rising tone Relic"], "S4")
A("SFX-LOOT-020", "Face-down slot shuffle", "S4")
R("SFX-UI", 1, ["Panel open", "Panel close", "Hover", "Press", "Error"], "S1")
R("SFX-UI", 10, ["Item pick (drag)", "Item place", "Item rotate"], "S4")
R("SFX-UI", 20, ["Value tick", "Haul total slam"], "S4")
R("SFX-UI", 30, ["Blueprint learned", "Collection entry"], "S14")
A("SFX-UI-031", "Collection Book entry", "F10")
R("SFX-UI", 40, ["Level up", "Contract complete", "Achievement"], "S14")
A("SFX-UI-041", "Contract complete", "F10")
A("SFX-UI-042", "Achievement", "F10")
R("SFX-UI", 50, ["Raid found", "Ready check"], "S15")
A("SFX-UI-060", "Purchase complete", "S16")
R("SFX-UI", 61, ["Wheel success", "Wheel consolation", "Wheel destroyed"], "F8")
A("SFX-UI-070", "Mail arrived", "F4")
A("SFX-UI-080", "Draft card flip", "S14")
R("SFX-TWR", 1, ["Arrival loading scene", "Internal lift ride", "Transit Gate doors closing"], "S3")
A("SFX-TWR-002", "Internal lift ride", "F1")
A("SFX-TWR-003", "Transit Gate doors closing (raid found)", "S15")
A("SFX-TWR-010", "Wheel ratchet", "F8")
N("SFX-TWR", 20, 18, "Tower ambience {n} (24 §24.3: crowd, haggling, TVs, arguments, babies, dogs, wind, barrel)", "F1")
R("SFX-TWR", 40, ["Power flicker", "Turret servo"], "F1")
R("SFX-FLT", 1, ["Flat door", "Knock", "Build place", "Build pick", "Build invalid", "Stash chest open", "Workbench loop", "Craft done ding", "Moving boxes"], "S16")
R("SFX-FLT", 2, ["Knock", "Build place", "Build pick", "Build invalid"], "F2")
A("SFX-FLT-009", "Moving boxes", "F3")
N("SFX-AMB", 1, 8, "Raid ambience {n} (24 §24.3)", "S2")

R("MUS-RAID", 1, ["Raid ambient drone", "Tension 1 pulse", "Tension 2 percussion"], "S8")
A("MUS-RAID-001", "Raid ambient drone", "S3")
A("MUS-RAID-004", "Janitor motif", "S11")
A("MUS-RAID-005", "Sleeper motif (own client)", "S10")
A("MUS-RAID-010", "Red Alert theme", "S12")
R("MUS-RAID", 20, ["Lockdown theme", "Reopen sting + loop"], "S13")
R("MUS-RAID", 30, ["Extraction sting", "Death sting"], "S12")
A("MUS-RAID-031", "Death sting", "S7")
A("MUS-RAID-040", "Blood Moon bed", "F9")
R("MUS-RAID", 50, ["Mutant hunt theme", "Ghost bed"], "S10")
A("MUS-RAID-060", "Orientation bed", "S14")
A("MUS-RAID-070", "Powered-wing ceiling muzak (tinny)", "S9")
R("MUS-TWR", 1, ["Tower ground floor bed", "Transit Gates tension bed", "Roof Black Market bed", "Arrival connecting loop", "The Drain ambient track"], "F1")
A("MUS-TWR-001", "Tower ground floor bed", "S16")
A("MUS-TWR-002", "Transit Gates tension bed", "S15")
A("MUS-TWR-004", "Arrival connecting loop", "S3")
A("MUS-TWR-005", "The Drain ambient track", "F7")
N("MUS-FLT", 1, 5, "Flat ambient track {n}", "F2")
N("MUS-FLT", 10, 3, "Tower radio channel {n}", "F2")
R("MUS-UI", 1, ["Haul tally loop", "Death screen loop", "Survivor Draft loop"], "S4")
A("MUS-UI-002", "Death screen loop", "S7")
A("MUS-UI-003", "Survivor Draft loop", "S14")
A("MUS-UI-010", "Relic theme", "F7")
A("MUS-UI-011", "Wheel spin loop", "F8")
A("MUS-UI-020", "Title sting (Arrival)", "S3")
VINYL_MOODS = ["Mall Muzak", "Synth Night", "Grunge Garage", "Lo-fi Rooftop", "Doom Choir"]
for i in range(40):
    A(f"MUS-VIN-{i + 1:03d}", f"Vinyl track {i + 1} ({VINYL_MOODS[i // 8]})", "F7")
A("MUS-SEA-001", "Season 1 theme (pass page, trailer)", "P1")

R("VO-PA", 1, ["PA: facility under quarantine", "PA: terminals online", "PA: automatic evac in 60 s", "PA: automatic evac triggered"], "S12")
A("VO-PA-001", "PA: facility under quarantine (Deploy)", "S3")
R("VO-PA", 10, ["PA: evac to Rooftop Helipad", "PA: evac to Basement Garage", "PA: evac window open", "PA: departing in 10 s"], "S12")
R("VO-PA", 20, ["PA: contamination detected", "PA: evacuation resumed"], "S13")
N("VO-PA", 30, 16, "Tower Management announcement {n}", "F1")
R("VO-RAD", 10, ["Bounty sighting Food Court", "Bounty sighting Pharmacy", "Bounty sighting Department Store",
                 "Bounty sighting Electronics", "Bounty sighting Cinema", "Bounty sighting Security Office",
                 "Bounty sighting Maintenance / Garage"], "F6")
A("VO-RAD-020", "Radio sign-off", "F6")
QL = ["Friendly!", "Don't shoot!", "Follow me", "Help!", "Danger!", "Thanks", "Over here", "Wait"]
for li, line in enumerate(QL):
    for t in range(6):
        voice = "A" if t < 3 else "B"
        A(f"VO-QL-{li * 6 + t + 1:03d}", f"Quick line '{line}' voice {voice} take {t % 3 + 1}", "S15")
N("VO-VOX", 1, 64, "Voice pack line {n} (4 packs x 8 lines x 2 takes)", "F11")
NPC_VO = [("Marla", 1, 10, "F1"), ("Okafor", 11, 10, "S16"), ("Lenny", 21, 10, "S16"), ("June", 31, 6, "F7"),
          ("Reyes", 37, 10, "F6"), ("Pip", 47, 4, "F4"), ("Vex", 51, 10, "F8"), ("Sully", 61, 6, "F9"),
          ("Dr. Halloran", 67, 6, "F9"), ("Sal", 73, 6, "F2")]
for name, start, count, step in NPC_VO:
    for i in range(count):
        A(f"VO-NPC-{start + i:03d}", f"NPC {name} line {i + 1}", step)
R("VO-TUT", 1, ["Orientation: move", "Orientation: search", "Orientation: crouch", "Orientation: throw",
                "Orientation: struggle", "Orientation: bitten", "Orientation: terminal", "Orientation: extract"], "S14")

# ---------------------------------------------------------------- STORE (P1, 28 §28.6)
A("UI-STO-001", "Store icon 512x512 (infected survivor face, flashlight, mall sign)", "P1")
R("UI-STO", 10, ["Thumbnail: the Lockdown", "Thumbnail: the Sleeper reveal", "Thumbnail: the struggle",
                 "Thumbnail: Red Alert sprint", "Thumbnail: the tower at night"], "P1")
