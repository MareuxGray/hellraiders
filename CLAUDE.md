# CLAUDE.md

This repo is the Roblox game **HellRaiders**: an extraction horror game where a squad raids an infected mall and one of them might secretly be infected. Between raids, players live in a run-down tower with flats and a player-run Flea market.

## Source of truth
- **`blueprint/00-index.md`** is the start point. The blueprint (`blueprint/01`–`28`) is the full spec of the game. If something isn't in it, it isn't in the game. Never invent behaviour, numbers, text or assets.
- `blueprint/design-review.md` is the baseline the blueprint was built from. Where it and the blueprint differ, the blueprint wins.
- **`blueprint/26-build-roadmap.md`** is the order of work. Build one step at a time: **S0 → S17** (the two-player Alpha), then **F1 → F13**, then P1 and L1–L4. Never start a step until the previous step's acceptance list is ticked in `tests/checklists/{step}.md`.
- Which file wins: shared values → `02`. Gameplay → the system's owning file. Anything paid → `19`. Code structure → `25`. On-screen text → `21` §21.10. Map positions → `23`. Asset ids → `27`, which is generated from `blueprint/tools/assets_master.py`.

## Working rules
- Read every file a step lists, fully, before writing code. Follow the rules in `26` §26.1.
- Every number comes from `src/shared/Config.luau`, copied from the blueprint. Every string comes from `src/shared/Strings.luau`. Every asset goes through `AssetRegistry`.
- The server decides everything listed in `25` §25.9. Clients send intentions and show results.
- Use placeholders until the real asset exists: an asset id of 0 returns the placeholder and logs `PLACEHOLDER` (`25` §25.3). At the start of each step, send Mareux that step's Asset requests (`26`). Never block on an asset.
- Asset ids: edit `blueprint/tools/assets_master.py`, never `27` by hand, then run `python3 blueprint/tools/build_assets.py`.
- After changing anything the tools read, run `check_assets.py`, `check_numbers.py` and `check_strings.py` (in `blueprint/tools/`). All three must print `ERRORS 0`. In S0, `tools/` and `data/` are copied to the repo root as the roadmap describes; `blueprint/` stays the reference copy.
- Commit after each passed step as "S{n}: {step name}" (or F{n}, P1, L{n}) and tag `s{n}-done`.
- If the blueprint is unclear or contradicts itself, write the question in `docs/questions.md` and ask Mareux. Don't guess.

## Locked decisions (don't reopen)
- Matchmaking is by party size only: Solo, Duo, Trio, Fill. Never matchmake by aggression or behaviour.
- Keep every ToS-safe monetisation item, with odds shown before purchase and PolicyService fallbacks. Keep the 10 s Supermutant revive (Second Wind) and Mutate Now.
- Raid hiding uses shutters and barricades, not a safe room. Betrayal stays hidden. Bounties are anonymous.
- Flats never show bathrooms and no one can lie on a bed (`15` §15.10), so the game keeps its 13+ label.
