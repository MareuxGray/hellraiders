# Handoff · S0 foundation

This is the S0 "Project setup" step of `blueprint/26-build-roadmap.md`: the skeleton every later step builds on.
Nothing here is gameplay. It is the data, the contracts, the tooling and the tests that make S1 onward possible.
Read `CLAUDE.md` and `blueprint/00-index.md` first; this file only says what S0 shipped, what is a placeholder,
and how to test and continue.

## 1. What is here

| Area | Files | State |
|---|---|---|
| Toolchain | `aftman.toml`, `wally.toml`, `selene.toml`, `testez.yml`, `stylua.toml`, `tools/precommit.sh` | Done. Rokit reads `aftman.toml` too. |
| Rojo | `places/Arrival|Tower|Mall.project.json`, `default.project.json` (Mall) | Done. All four build. |
| Blueprint tools | `tools/*.py` (copied from `blueprint/tools`), `data/*.txt` | Done, patched for Windows (§6). |
| Generated data | `src/shared/AssetRegistry/Data_*.luau`, `src/shared/Names.luau` via `tools/gen_shared.py` | Done. Never edit by hand. |
| Shared modules | `Config`, `Strings`, `AssetRegistry`, `Items`, `LootTables`, `Recipes`, `Contracts`, `Achievements`, `Epithets`, `Vinyls`, `MallShops`, `Cosmetics`, `Furniture`, `Products`, `Net`, `Util/Grid`, `Util/Rng`, `Util/Time`, `Util/Tween` | Done, with the placeholders in §3. |
| Server | `Bootstrap.server.luau` (place gating, init/start order, PLACEHOLDERS line); 33 services + 7 `AI/*` children | Stubs: empty `init()`/`start()`. Real code arrives per step. |
| Client | `Bootstrap.client.luau`; 20 controllers, `Hud/`, `Ui/` | Stubs. |
| Tests | `tests/run.server.luau` (Studio, TestEZ), `tests/lune/run.luau` (headless), `tests/unit/*.spec.luau` | 69 tests pass headlessly. |
| Docs | `docs/questions.md` (13 open), `docs/changelog.md`, `tests/checklists/S0.md` | Done. |
| Not done | Universe and PlaceIds (needs Mareux's account), live Rojo sync into Studio, Studio start-up check | See §4. |

## 2. Test it straight away

From the repo root, in this order. Every command must end clean.

```bash
aftman install
```

```bash
wally install
```

```bash
lune run tests/lune/run
```

```bash
selene src tests
```

```bash
stylua --check src tests
```

```bash
python -X utf8 tools/check_assets.py src blueprint
```

```bash
python -X utf8 tools/check_numbers.py --config src/shared/Config.luau
```

```bash
python -X utf8 tools/check_strings.py --strings src/shared/Strings.luau --src src
```

```bash
rojo build places/Mall.project.json -o build/Mall.rbxl
```

`tools/precommit.sh` runs all of these. Install it as a hook with `cp tools/precommit.sh .git/hooks/pre-commit`.

**In Studio:** `rojo serve places/Mall.project.json` (or `default.project.json`) and connect the Rojo plugin, or open
`build/Mall.rbxl`. Press Play. Expected output:

```
HellRaiders server · place Mall (Studio) · PlaceId 0 · JobId …
  start Data
  start Analytics
  …
HellRaiders server · 31 services up in … ms
PLACEHOLDERS MDL 442 ANIM 191 SFX 341 MUS 75 VO 232 UI 493 VFX 49 TEX 128
HellRaiders client · place Mall
  start Input
  …
```

To boot the same place as Arrival or Tower before the PlaceIds exist, set the Workspace attribute `HellRaidersPlace`
to `Arrival` or `Tower` and play again. To run the unit tests in Studio, set the Workspace attribute `RunTests` to
true, or run `require(game.ServerScriptService.Tests.run)()` from the command bar.

## 3. Placeholders to replace

Everything below is a deliberate stand-in. Each has the file, the key and where the real value comes from.

### Needs Mareux (cannot be done without the account or a decision)

| Placeholder | File / key | Fill with | Question |
|---|---|---|---|
| PlaceIds (Dev and Live) | `Config.Places.{Arrival,Tower,Mall}.{Dev,Live}` = 0 | The ids from the HellRaiders-Dev universe (S0 step 2) and, in P1, the live universe | Q-012 |
| Admin user ids, group id | `Config.Admin.UserIds = {}`, `Config.Admin.GroupId = 0` | Mareux's user id and testers; the owning group | Q-013 |
| Geolocation endpoint | `Config.Net.GeoUrl = ""` | Chosen in P1 (25 §25.4) | — |
| Developer product / pass ids | `Products.luau` every `productId = 0` | Creator Hub ids (dev in F11, live in P1) | — |
| Shop names (48) | `MallShops.luau` `[Apparel 1]` … | Invented brand names, none given in 23 | Q-003 |
| Epithets 6–40 | `Epithets.luau` `[Epithet n]` | The preset list (18 §18.4) | Q-004 |
| Cosmetic names and exact prices | `Cosmetics.luau` `[Finish n]` etc.; low-end prices | 19 §19.5 gives counts and ranges only | Q-005 |
| Wallpaper / flooring prices and Robux picks | `Furniture.Surfaces` | 15 §15.9 gives ranges only | Q-007 |
| Vinyl catalogue | `Vinyls.luau` titles, credits, licences | Licensed catalogue confirmed in P1 (18 §18.8) | — |
| NPC voice subtitles | `Strings.luau` `STR.NPC.<NAME>.<n>` = `[Name line n]` | Voice script written in P1 (21 §21.10) | — |
| Odds tables pasted into Strings | not yet present | `tools/check_numbers.py` output, F8/F11 (13 §13.3, 19 §19.2) | — |
| ProfileStore | `wally.toml` comment; `Services.Data` stub | Vendor the official module in S3 | Q-010 |

### Decided in code, flagged for review

| Placeholder | File / key | Note | Question |
|---|---|---|---|
| Revenant recoil and reload | `Config.Guns.Revenant` Kick/Horiz/Recover/Sway/Reload | Not in 02 or 12 | Q-002 |
| Thermal Sight fit list | `Config.Attachments.Thermal.Fits` | Not in 07 or 12 | Q-009 |
| Molotov / UV Stun Flare display tier | `Items.luau` Uncommon / Rare | 11 says "crafted only" | Q-008 |
| Stash expansion rows | `Config.Stash.ExpansionRows = 5` (02) vs `Config.Shop.Expansion.Rows = 3` (19) | Contradiction kept visible | Q-001 |
| Tenth door banner = weekly banner | `Cosmetics.luau` `COS-BAN-010` | 27 has 9 shop banner models + the weekly one | Q-006 |

### Every asset (1,951)

All asset ids are placeholders (`id = 0`). The game runs on grey boxes, default R15 clips and built-in click sounds
until each step's **Asset requests** (26) are delivered. To add a real id:

1. Add `"ANIM-MOV-001": 123456789` to `tools/asset_ids.json` (create the file; a flat `{ "<blueprint id>": <rbxassetid> }` map).
2. Run `python -X utf8 tools/gen_shared.py`.
3. Check it in game the same day (27 §27.2).

To add or move an asset: edit `blueprint/tools/assets_master.py`, run `python -X utf8 build_assets.py` from
`blueprint/`, copy `blueprint/tools/assets_master.py` to `tools/`, run `gen_shared.py`, then `check_assets.py`.

## 4. Open work before S1

1. **Create the universe** (S0 step 2, Mareux): group-owned HellRaiders-Dev with places Arrival (start place), Tower,
   Mall. Experience private. HTTP requests on, API access to Studio on, Allow third-party teleports off. Paste the
   three PlaceIds into `Config.Places.*.Dev`.
2. **Studio start-up check** (S0 accept 4): open each place, Play, confirm the log in §2 and no errors. Tick
   `tests/checklists/S0.md`.
3. **Live Rojo sync** (S0 accept 1): `rojo serve` into Studio once, confirm the tree matches the project.
4. Commit as `S0: Project setup`, tag `s0-done` (26 §26.1 rule 10).

## 5. How S1 continues

- Read 04, 05 §5.1–5.5, 21 §21.1–21.2, 22 §22.1–22.4, 25 §25.10 in full.
- Port `CameraRig`, `Gait`, `Body`, `Actions`, `MoveSpeed`, `Session.claim` and Stats v2 from the existing Studio
  place into the stub files of the same names (`src/client/Controllers/*.luau`, `src/server/Services/Session.luau`,
  `src/shared/Stats/`). Replace every hard-coded number with a `Config` key and every asset id with an
  `AssetRegistry` id. Keep their tests (Stats 48, Graph 31) under `tests/unit/`.
- Each stub's header comment names its owning blueprint file and step. The `init()`/`start()` contract is fixed:
  `init` wires signals and never yields; `start` may yield. Bootstrap already orders services per place.
- Post the S1 Asset requests to Mareux first (`AssetRegistry.assetRequestText("S1")` prints the 86 rows).

## 6. Decisions and deviations made in S0

- **Tool patches** (`tools/*.py`): UTF-8 console output on Windows and OS-agnostic path checks; `build_assets.py`
  writes UTF-8 with LF. Behaviour is unchanged. The blueprint copies in `blueprint/tools/` are untouched.
- **`-X utf8` on every `python` call** in docs and `precommit.sh`, because the blueprint text contains `→` and `§`.
- **AssetRegistry data is split per kind** (8 files) so no ModuleScript approaches Roblox's script size limit.
  `size` is stored as `{ w, h, d }` and turned into a `Vector3` by `AssetRegistry.model()` at runtime.
- **ProfileStore not installed** (Q-010). The Wally mirrors are unofficial.
- **`Strings.get` on a missing key returns `[KEY]` and warns once** so a typo is visible in a playtest, never silent.
- **`Net.Admin` is a `RemoteFunction`** (22 §22.1 "one remote", "server checks admin status on every call").
  `UiQuery` and `ShopQuery` are the only other RemoteFunctions, both client → server.
- **Rng is a pure 32-bit generator**, not `Random.new`, so the struggle needle and loot rolls replay identically on
  client, server and in Lune.
- **Lune test runner** (`tests/lune/run.luau`) mirrors the Rojo tree as a fake DataModel; modules that touch Roblox
  APIs guard with `typeof(Instance) ~= "nil"`. Keep that guard in new shared modules so they stay testable.
- **Place gating in Studio**: unknown PlaceId boots as `Config.Places.StudioDefault` ("Mall"); Workspace attribute
  `HellRaidersPlace` overrides it. Remove nothing here when the PlaceIds arrive; it still serves test places.
