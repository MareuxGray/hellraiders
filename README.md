# HellRaiders

Roblox extraction horror game. The build spec is in `blueprint/` (start at `blueprint/00-index.md`).

## State

**S0 · Project setup** is in. Read [`Handoff.md`](Handoff.md) for what exists, every placeholder, and how to test it.
Open questions for Mareux are in [`docs/questions.md`](docs/questions.md). The step checklist is
[`tests/checklists/S0.md`](tests/checklists/S0.md).

## Quick start

```bash
aftman install && wally install
lune run tests/lune/run
rojo serve default.project.json
```

Then connect the Rojo plugin in Studio and press Play. The output shows the service start order and the
`PLACEHOLDERS …` summary. Full checks: `tools/precommit.sh`.
