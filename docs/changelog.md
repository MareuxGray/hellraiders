# Changelog

One entry per passed step (26 §26.1 rule 10). Newest first.

## S0 · Project setup — 25 October 2026

- Rojo 7 project with three places (`places/Arrival|Tower|Mall.project.json`) sharing `src/shared`, plus a
  `default.project.json` (Mall) for day-to-day Studio work.
- Toolchain: `aftman.toml` (Rojo 7.7.1, Wally 0.3.2, Selene 0.32.0, StyLua 2.6.0, Lune 0.10.3), `wally.toml`
  (Promise, Signal, Janitor, TestEZ; ProfileStore deferred, Q-010), `selene.toml` + `testez.yml`, `stylua.toml`,
  `tools/precommit.sh`.
- `tools/` and `data/` copied from the blueprint. Tools patched for Windows (UTF-8 console output, path separators).
  New `tools/gen_shared.py` generates `AssetRegistry/Data_*.luau` and `Names.luau`.
- `src/shared`: Config (every number from 02 and the owning files), Strings (185 keys + NPC placeholders),
  AssetRegistry (1,951 ids, placeholder resolver), Items, LootTables, Recipes, Contracts, Achievements, Names,
  Epithets, Vinyls, MallShops, Cosmetics, Furniture, Products, Net, Util/Grid, Util/Rng, Util/Time, Util/Tween.
- `src/server`: Bootstrap with place gating; 33 services (+ 7 AI children) as init/start stubs.
- `src/client`: Bootstrap; 20 controllers plus Hud and Ui folders as init/start stubs.
- Tests: Studio runner `tests/run.server.luau` (TestEZ), headless runner `tests/lune/run.luau`, 7 spec files.
- Docs: `Handoff.md`, `docs/questions.md` (13 open questions), `tests/checklists/S0.md`.
