# 25 · Technical architecture, data, networking, performance, analytics and security

Owner of: the repo and tooling, code layout, services and controllers, the AssetRegistry, remotes, teleporting, the player profile schema and every DataStore and MemoryStore structure, budgets, analytics and logs, anti-exploit and anti-alt rules, porting the existing place, and moderation hooks. If code structure differs anywhere, this file wins.

---

## 25.1 Repo and tooling

- New private repo **MareuxGray/hellraiders**, Rojo 7 project, Git. Toolchain via `aftman.toml`: Rojo, Wally, Selene, StyLua.
- **Wally packages:** `ProfileStore` (session-locked profiles), `Promise`, `Signal`, `Janitor` (cleanup), `TestEZ`. Nothing else without asking Mareux.
- Places in the Rojo project: `places/Arrival.project.json`, `places/Tower.project.json`, `places/Mall.project.json`, all sharing `src/shared`.
- Universes: **HellRaiders-Dev** (all stages) and **HellRaiders** (live, from P1) (`22` §22.9).
- `selene` and `stylua --check` run before each commit (`tools/precommit.sh`).

## 25.2 Code layout

```
src/
  shared/                 -- ReplicatedStorage.Shared (all places)
    Config.luau           -- every number (from 02 and owning files)
    Strings.luau          -- every string (21 §21.10)
    AssetRegistry.luau    -- every asset id → asset or placeholder (§25.3)
    Items.luau            -- item catalogue (11 §11.2)
    LootTables.luau       -- container classes, tier weights (11 §11.3)
    Recipes.luau          -- crafting (12)
    Contracts.luau, Achievements.luau, Names.luau, Epithets.luau, Vinyls.luau, MallShops.luau, Cosmetics.luau, Furniture.luau, Products.luau
    Stats/                -- Defs, Graph, Compute, Config (ported, 05 §5.1)
    Net.luau              -- remote definitions (§25.4)
    Util/                 -- Grid (inventory maths), Rng (seeded), Time, Tween helpers
  server/                 -- ServerScriptService
    Bootstrap.server.luau -- requires services in order, by place
    Services/
      Data.luau           -- ProfileStore wrapper, save/release, receipts list (§25.5)
      Session.luau        -- join flow, claim/respawn rule (ported), teleports
      Stats.luau          -- 05
      Movement.luau       -- server checks for speed/teleport (§25.9)
      Ragdoll.luau        -- ported
      Combat.luau         -- 07: hit validation, rewind buffer
      Melee.luau, Throwables.luau (ported, extended)
      Inventory.luau      -- ported, extended: grid, slots, containers, corpses
      Loot.luau           -- rolling, reveal timing, world items claim
      Noise.luau          -- 06 noise events
      World.luau          -- shutters, doors, glass, generators, alarms, elevators, destructibles
      AI/                 -- Director (spawns, budget, LOD), Walker, Crawler, Sprinter, Janitor, Senses, Paths
      Infection.luau      -- 09: struggles, bites, Sleepers, symptoms, sabotage, cures
      Mutants.luau        -- 09: Stalker, Supermutant, Ghost tools
      RaidFlow.luau       -- 03 state machine, clock, results, Orientation
      Evac.luau           -- 10
      Crafting.luau       -- 12 in-raid and flat
      Wheel.luau          -- 12 wheel and trade-up
      Survivors.luau      -- 13 draft, rerolls, retirement
      Progression.luau    -- XP, levels, reputations, contracts, achievements, collection
      Tower.luau          -- 14 tower records, instances, annexes, routing
      Residency.luau      -- 14 transactions, waitlists, Move-in, relocation
      Flats.luau          -- 15 interiors, furniture, displays
      Economy.luau        -- 16 vendors, insurance, repossession, mail
      Flea.luau           -- 16
      Bounties.luau       -- 17
      Relics.luau         -- 18
      Shop.luau           -- 19 products, receipts, policy
      Matchmaker.luau     -- 20
      Social.luau         -- 20 voice routing, quick lines, pings, emotes, parties, referrals
      Admin.luau          -- 22
      Analytics.luau      -- §25.8
  client/                 -- StarterPlayerScripts
    Bootstrap.client.luau
    Controllers/
      CameraRig, Gait, Body, Actions, ProcPose, Traverse, RailPlanner, RemotePose, MoveSpeed (ported, 04)
      Input.luau          -- all bindings (21 §21.2), rebinding, device detection
      Aim.luau, Weapons.luau, MeleeClient.luau, ThrowClient.luau
      Hud/                -- one module per HUD element (21 §21.3)
      Ui/                 -- one module per screen (21 §21.5)
      Audio.luau          -- music layers, zones, occlusion (24)
      Fear.luau           -- post-processing and camera requests from fear/health
      Struggle.luau       -- QTE client (09 §9.2)
      Reveal.luau         -- container reveal client (11 §11.4)
      Build.luau          -- flat build mode (15 §15.7)
      AdminClient.luau    -- 22
  places/                 -- place-specific folders (map refs, lighting presets)
tests/
  run.server.luau, unit/*.spec.luau, checklists/S*.md, F*.md
tools/   check_numbers.py, check_assets.py, check_strings.py, precommit.sh
data/    names_first.txt, names_last.txt
```

- **Service contract:** each service exports `init()` (no yields, wire signals) and `start()` (may yield). Bootstrap calls all `init` then all `start`. Services talk through direct requires for calls and `Signal`s for events. No `_G`, no `shared`.
- **Place gating:** `Bootstrap` reads `Config.Places` with `game.PlaceId` (dev and live ids) and starts only the services for that place (Arrival: Data, Session, Tower routing; Tower: everything except raid services; Mall: raid services plus Data, Shop, Social, Relics, Bounties, Analytics).
- **Single-owner rule** (`04` §4.1) applies to all code.

## 25.3 AssetRegistry and placeholders

```lua
-- src/shared/AssetRegistry.luau
return {
  ["ANIM-MOV-001"] = { kind = "ANIM", id = 0, stage = "S1", desc = "Idle (rifle-ready relaxed stance)" },
  ...
}
```

- `id = 0` means placeholder. `AssetRegistry.get(assetId)` returns the real asset id, or a placeholder:
  - **ANIM:** a default Roblox R15 animation of similar type, or a 0.5 s neutral pose; logs `PLACEHOLDER`.
  - **SFX / VO:** a short generic beep or click by kind (`rbxassetid` of a Roblox library UI click), at the right volume and range; VO placeholders also show the subtitle text.
  - **MUS:** silence.
  - **MDL:** a grey box sized from `desc` bounds (`size = Vector3`) with attribute `Placeholder = true` and a BillboardGui label of the id (Studio only).
  - **UI:** a grey rounded square with the id text.
  - **VFX:** a simple white ParticleEmitter burst.
  - **TEX:** a flat colour.
- On server and client start, one line: `PLACEHOLDERS ANIM 140 SFX 210 ...`. First use of each placeholder: `PLACEHOLDER <id> <desc>` once.
- Every asset id in `27` exists here (checked by `tools/check_assets.py`). The **Asset requests** list for each stage (`26`) is the `27` rows with that stage.

## 25.4 Networking

- `Net.luau` creates all remotes in `ReplicatedStorage.Net` at server start: one `RemoteEvent` per channel and a few `RemoteFunction`s (only for UI queries that need a reply; never server → client).
- **Rate limits:** every client → server remote has a per-player token bucket in `Net` (default 20/s, burst 40; inventory moves 30/s; fire 15/s per weapon RPM; pose 25/s). Over the limit: drop and count; 3 strikes in 60 s → log `SecurityEvent`.
- **Validation:** every remote handler validates types and ranges first (`Net.check(schema, args)`), then ownership (the item/container/target belongs to or is reachable by the player: distance checks with 2 studs tolerance + ping compensation).
- Main channels: `Net.Input` (actions: context, sprint state, crouch, roll, slide), `Net.Fire`, `Net.Melee`, `Net.Throw`, `Net.Inventory`, `Net.Container`, `Net.StatsState` (server → owner), `Net.PoseState` (client → server → others, 20 Hz, under 1.5 KB/s per player, `04` §4.10), `Net.Noise` (server → clients in range for audio), `Net.Struggle`, `Net.Raid` (state, clock sync), `Net.Evac`, `Net.Infection` (owner only), `Net.Ui` (panel data), `Net.Shop`, `Net.Social`, `Net.Admin`.
- **Clock sync:** the raid clock is `workspace:GetServerTimeNow()` − `raidStartTime` (attribute).
- **Teleports:** `TeleportService:TeleportAsync` with `TeleportOptions` (reserved access code or server instance id). On `TeleportInitFailed`: retry 3× with 2 s backoff; then fall back per `03` §3.10. Teleport data is never trusted for anything but routing hints; the server reads truth from MemoryStore (`RaidPlan`) and profiles.
- **Region hint** (`20` §20.8): at Tower server start, `HttpService:GetAsync` to an IP geolocation endpoint in `Config.Net.GeoUrl` (Mareux picks the service in P1; HTTP requests enabled), mapped to `NA`, `EU`, `AS`, `OC`, `SA`; failure → `Global`.

## 25.5 Player data (ProfileStore)

- Store `PlayerData_v1`, key `Player_<userId>`. Session-locked. Loaded on join (Arrival, Tower, Mall), released before every teleport (`Data.releaseForTeleport(player)` awaits release before calling `TeleportAsync`), auto-saved every 60 s and on major events (raid results, purchases, Flea, residency).
- If a profile is locked by another server for more than 15 s, the joiner is kicked with `STR.UI.ERROR` and a rejoin button (ProfileStore's steal after timeout handles crashed servers).

**Profile schema (v1):**

```
{
  version = 1,
  createdAt, lastLogin, playtime,
  orientationDone = false,
  settings = { ... 21 §21.7 },
  mc = 5000,
  xp = 0, level = 1,
  rep = { merchant = 0, mutant = 0, vendor = 0, helper = 0 },
  survivor = { id, name, look = {face, hair, skin, build, voice}, attrs = {Endurance, Strength, Composure, Marksmanship, Stealth}, raids = 0, title = nil, createdAt } | nil,
  draftPending = false, draftOptions = {..3 survivors..},
  memorial = { {name, raids, bestHaul, cause, at} ... (50) },
  stash = { grid = {w, h}, items = { {uid, itemId, x, y, rot, qty, dur?, ammo?, attachments?, finish?, stickers?, charm?, relicId?, paidOrigin?} } },
  overflow = { items = {...}, since },
  equipped = { primary, secondary, melee, armour, helmet, backpack, flashlight, safePocket, blueprintSlot, pockets = {..4}, quick = {..4}, backpackItems = {...} },
  blueprintsKnown = { [modelId] = true },
  workbench = { queue = { {recipe, startAt, endAt} }, tray = {...} },
  collection = { [itemId] = firstAt },
  cosmetics = { owned = {[cosId] = true}, equipped = { outfit, deathFx, mutationFx, voicePack, flare, emotes = {..8}, nameplate, doorBanner }, gunLooks = { [gunModel] = {finish, stickers = {..3}, charm} } },
  mutant = { variantsOwned = {Brute = true}, variantActive = "Brute", trackUnlocked = {...} },
  residency = { towerId, tier, slot, entitlement = "Bunk"|"Executive"|"Penthouse", movedAt, waitlists = {...}, rentPaidUntil, autoPay = true, tickets = {move = 0, homecoming = 0} },
  flat = { furniture = { {itemId, x, y, z, rotY, colour, room} }, storage = {[furnId] = n}, walls = {...}, floors = {...}, displays = { mounts = {...}, pedestals = {...}, case = {...} }, door = "Party" },
  furnitureOwned = { [furnId] = n },
  stashExpansions = 0,
  contracts = { daily = {...}, weekly = {...}, starter = {...}, rerollUsedAt, lastReset },
  achievements = { [achId] = at }, stats = { ... 13 §13.10 },
  mail = { {id, kind, payload, at, claimed} },
  escrow = { listings = { [listingId] = item }, bounties = {...}, escorts = {...} },
  flea = { purchasesToday = {[itemId] = n}, day },
  insuranceCredits = 0, tokens = { mutate = 0, revive = 0, spin = {...}, reroll = 0, lock = 0, title = 0, catalyst = {...}, press = 0, repo = 0 },
  pendingRaid = { raidId, accessCode, until } | nil,
  wheel = { robuxFailStreak = 0 },
  pass = { season, xp, premium = false, claimed = {...}, haulBonus = false },
  vip = { lastStipend },
  referral = { referredBy, rewarded = false, monthCount, month },
  relics = { created = 0, lostIds = {...} },
  receipts = { purchaseId ... (500) },
  policy = { restricted = true, tradingAllowed = false, checkedAt },   -- cache, refreshed each session
  moderation = { flags = {...} },
}
```

- **Migrations:** `Data.migrate(profile)` runs on load: each version step is a function `vN → vN+1`. Never remove fields without a migration.
- **Raid inventory** lives in the profile's `equipped` during a raid. At raid start the server marks `pendingRaid`; at results it writes the outcome (extracted items to stash or overflow; deaths clear `equipped` except safe pocket and blueprint slot) and clears `pendingRaid` in one save.
- **Crash safety:** if a Mall server dies mid-raid, the next load sees `pendingRaid` past its `until` (raid max 1305 s + 300 s): the raid counts as a **disconnect death** with insurance applying normally, except the survivor is **not** retired and `equipped` is restored (server fault is never the player's loss). Logged as `RaidCrashEvent`.

## 25.6 Other stores

| Store | Type | Key | Purpose | Owner |
|---|---|---|---|---|
| `Towers` | DataStore | `Tower_<id>` | tower records (`14` §14.4) | Tower |
| `TowerIndex` | DataStore | `index` | list of towers by status, next id | Tower |
| `TowerWeekly` | OrderedDataStore | `<week>` / towerId | tower leaderboard | Tower |
| `Residency` | DataStore | `Tx_<txId>` | residency transactions (`14` §14.6) | Residency |
| `TowerLive` | MemoryStore SortedMap | towerId | live instances, player counts, annex lock | Tower |
| `Presence` | MemoryStore SortedMap | userId | where a player is (`14` §14.9), TTL 90 s | Social |
| `Reservations` | MemoryStore SortedMap | `towerId:slot` | 120 s slot holds | Residency |
| `Queue:<pool>` | MemoryStore SortedMap | ticketId | matchmaking (`20` §20.8) | Matchmaker |
| `MatchmakerLock` | MemoryStore SortedMap | `lock` | leader election | Matchmaker |
| `RaidPlan` | MemoryStore SortedMap | raidId | raid setup, TTL 10 min | Matchmaker |
| `Flea:<itemId>` | MemoryStore SortedMap | listingId | listings (`16` §16.3) | Flea |
| `FleaBarter` | MemoryStore SortedMap | barterId | barters | Flea |
| `FleaPayouts` | DataStore | sellerId | pending payouts | Flea |
| `FleaHistory` | DataStore | itemId | last 200 sales | Flea |
| `Bounties` | MemoryStore SortedMap | bountyId | live bounties (`17` §17.3) | Bounties |
| `BountyRecords` | DataStore | bountyId | durable bounty copy | Bounties |
| `Relics` | DataStore | relicId | Relic records (`18` §18.2) | Relics |
| `RelicPool` | MemoryStore SortedMap | relicId | lost Relics (`18` §18.3) | Relics |
| `VinylSerial` | DataStore | `serial` | global pressing counter (UpdateAsync increment) | Relics |
| `AuditLog` | DataStore | `<day>/<shard>` | economy, admin, security audit lines (§25.8), kept 90 days | Analytics |

- **MemoryStore budgets:** request units scale with players; keep reads batched (`GetRangeAsync` with limits), cache the Flea and bounty views per server for 30–60 s.
- **MessagingService topics:** `RaidFound:<jobId>`, `FleaSold:<userId>`, `Mail:<userId>`, `TowerUpdate:<towerId>`, `Relic:<userId>`, `Admin:Broadcast`. Messages are hints; truth is always read from stores.
- **DataStore error handling:** every call through `Data.retry(fn, tries = 5, backoff = 1, 2, 4, 8 s)`. Budget-aware: check `DataStoreService:GetRequestBudgetForRequestType` before batch work.

## 25.7 Performance budgets

| Budget | Target |
|---|---|
| Client FPS | 60 on mid PC, 30+ on a 3-year-old mid-range phone (iPhone 11 / Galaxy A52 class) in the busiest Red Alert |
| Client memory | under 1.6 GB on mobile |
| Server heartbeat (Mall) | 60 Hz with 12 players and 40 active AI; AI under 4 ms/frame (`08` §8.5) |
| Network per player | under 50 KB/s down average, 80 KB/s peak in Red Alert |
| Pose relay | under 1.5 KB/s per player (`04` §4.10) |
| Map | under 60,000 parts, streaming on (`23` §23.1) |
| Tower server | 50 players, 60 Hz; NPC ambient anims client-side only |
| Ragdolls | max 8 simulated at once per client; older ones freeze |
| Decals (blood trails, shards) | max 300; oldest removed first |

Measured with the micro-profiler and `/perf` in S8, S12, S17 and P1.

## 25.8 Analytics and logs

- **Roblox AnalyticsService:** `LogEconomyEvent` for every MC source and sink (with `flowType`, `currencyType = "MallCash"`, `itemSku`, `transactionType`), `LogProgressionEvent` for level-ups and contracts, `LogFunnelStepEvent` for onboarding funnels (§ below), `LogCustomEvent` for raid outcomes.
- **Funnels:** `Onboarding` (Arrival → Draft → Orientation start → Orientation extract → Tower first visit → First real deploy → First extract → Second session), `FirstPurchase`, `Residency` (Move-in started → reserved → paid → done).
- **Custom events:** `RaidResult` (mode, outcome, haul value, duration, cause of death, Sleeper y/n, Lockdown y/n), `StruggleResult`, `Lockdown`, `RelicFound`, `BountyClaim`, `CatalystRaid`.
- **Audit lines** (`AuditLog`, never sent to clients): `EconomyEvent`, `PaidRandomEvent` (product, odds version, outcome), `FleaEvent`, `BountyEvent`, `AdminEvent`, `SecurityEvent`, `RaidCrashEvent`. Each line `{t, userId, kind, data}`; written in batches every 30 s per server.

## 25.9 Security and anti-exploit

- **Server authority:** the server decides hits, damage, struggles (with client timing checked, `09` §9.2), loot, rolls, prices, MC, items, takedowns, revives, evac checks, and all purchases. Clients only send intentions.
- **Movement checks:** server samples each character's position at 10 Hz; flags speed above the allowed max (from `MoveSpeed` rules + 20% + ping) or vertical teleport without a traversal plan; 3 flags in 10 s → rubber-band to the last valid position; repeated → `SecurityEvent` and kick on the 3rd session.
- **Shooting:** rewind buffer 250 ms (`07` §7.2); max fire rate per gun; line-of-sight re-check on the server.
- **Inventory:** every move validated against the grid and ownership; duplicate item `uid`s rejected; item uids are server-generated GUIDs.
- **Anti-alt (bounties, referrals, Flea):** account age (from `Player.AccountAge`) thresholds; account link: Roblox gives games no device id, so the link signal is the server's own record of **shared parties, shared private servers and repeated hand-overs** between two accounts in 7 days as the link signal (`Config.AntiAlt.*`). Linked pairs can't claim each other's bounties or referral rewards and get flagged in the audit log.
- **Rate limits** on all remotes (§25.4).
- **Admin** commands checked server-side (`22` §22.1).

## 25.10 Porting the existing place

Ported in S1 (movement, camera, stats, actions), S4 (inventory), S5 (traversal relay), S6 (combat, throwables), S10 (ragdoll in combat contexts). For each module:
1. Copy the source into its `src/` location; keep names.
2. Replace hard-coded numbers with `Config` keys from `02`.
3. Replace asset ids with `AssetRegistry` ids.
4. Apply the rule changes the owning file lists (e.g. `04` §4.2 idle timers, `05` §5.1 five attributes).
5. Keep and run its existing tests (Stats 48, Graph 31). Add tests for changed behaviour.
6. Delete anything not used by the blueprint.
- `Session.claim` respawn rule (ported): one character per player at a time; respawn only through `Session` (tower: instant on join; raid: never, except the Orientation Run's checkpoint respawn).

## 25.11 Moderation and compliance hooks

- All player-visible text that isn't preset (display names) comes from Roblox and isn't re-entered. Chat uses `TextChatService` (filtered by Roblox).
- `PolicyService` checks (`19` §19.2) on every join; cached in the profile and refreshed each session.
- Voice: Roblox voice eligibility only; the game never forces voice on.
- **Maturity questionnaire answers** (fill on the Creator Hub in P1, redo whenever a listed item changes): realistic blood and violence: yes (Moderate); horror and frightening themes: yes; paid random items: yes (wheel, rerolls, crates, supply drop; odds shown); social hangout with private spaces (bedrooms or bathrooms): **no** (flats follow `15` §15.10); free-form user creation: no (presets only); gambling with real money: no; alcohol, drugs, romance: none. The expected label is Moderate (13+). If Roblox ever rates the experience 17+ because of the flats, remove the visit feature rather than accept the 17+ label (that decision is Mareux's).
- **Screen-time limits:** parental screen-time limits can end a session at any moment. Nothing depends on finishing a session: the profile auto-saves every 60 s and on major events (§25.5), and a mid-raid disconnect follows `03` §3.7.
- `Players.BanAsync`-based bans for exploiters (admin command `/ban <userId> <reason> <duration>` added in P1; logs `AdminEvent`).
- Data deletion requests (Right to Erasure): `tools/erase_user.lua` (Studio command bar script) removes `PlayerData_v1/Player_<id>`, anonymises their Relic history names to "a raider", removes their Flea listings and bounties. Built in P1.
