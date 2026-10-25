#!/usr/bin/env python3
"""Builds 27-assets.md and the per-step Asset requests in 26-build-roadmap.md from tools/assets_master.py.
Run from the blueprint folder (or the repo root after S0 copies tools/): python3 tools/build_assets.py
"""
import os
import re
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")  # Windows consoles default to cp1252

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
from assets_master import ASSETS  # noqa: E402

STEPS = [f"S{i}" for i in range(18)] + [f"F{i}" for i in range(1, 14)] + ["P1"]
KIND_ORDER = ["MDL", "ANIM", "SFX", "MUS", "VO", "UI", "VFX", "TEX"]
KIND_NAME = {"MDL": "Models", "ANIM": "Animations", "SFX": "Sound effects", "MUS": "Music", "VO": "Voice",
             "UI": "UI images", "VFX": "Visual effects", "TEX": "Textures"}


def load():
    table = {}
    for a in ASSETS:  # last definition wins (lets a later line move one id to a later step)
        table[a["id"]] = a
    for a in table.values():
        a["kind"] = a["id"].split("-")[0]
        if a["step"] not in STEPS:
            raise SystemExit(f"bad step {a['step']} for {a['id']}")
    return table


def compress(ids):
    """['X-001','X-002','X-003','Y-010'] -> 'X-001…003, Y-010'"""
    out, run = [], []

    def flush():
        if not run:
            return
        if len(run) == 1:
            out.append(run[0])
        else:
            out.append(f"{run[0]}…{run[-1].rsplit('-', 1)[1]}")
        run.clear()

    for i in sorted(ids):
        if run:
            p_pre, p_n = run[-1].rsplit("-", 1)
            c_pre, c_n = i.rsplit("-", 1)
            if p_pre == c_pre and int(c_n) == int(p_n) + 1:
                run.append(i)
                continue
            flush()
        run.append(i)
    flush()
    return ", ".join(out)


def main():
    table = load()
    by_step = {s: [a for a in table.values() if a["step"] == s] for s in STEPS}

    # ---- 27
    lines = [
        "# 27 · Complete asset list",
        "",
        "Owner of: every model, animation, sound, music track, voice line, UI image, VFX and texture in the game, "
        "with its id, what it is, the step that first needs it, and its placeholder size (models). "
        "**Generated** from `tools/assets_master.py` by `tools/build_assets.py`; edit the master, never this file. "
        "Code uses assets only through `AssetRegistry` (`25` §25.3). Each step's Asset requests in `26` are the rows "
        "under that step here.",
        "",
        "## 27.1 Totals",
        "",
        "| Kind | Count |",
        "|---|---|",
    ]
    for k in KIND_ORDER:
        n = sum(1 for a in table.values() if a["kind"] == k)
        lines.append(f"| {KIND_NAME[k]} ({k}) | {n} |")
    lines.append(f"| **All** | **{len(table)}** |")
    lines += ["", "## 27.2 Delivery rules", "",
              "- Models: R15-compatible where a character; pivot at the base centre; real-world scale (1 stud ≈ 0.28 m); "
              "under 10k triangles for props, 20k for characters; PBR SurfaceAppearance where possible; uploaded by the group.",
              "- Animations: in place, R15, priorities per `04` §4.9, pass `ClipAnalyzer`.",
              "- Audio: normalised per `24` §24.1; loops cut on zero crossings; mono for 3D sounds, stereo for music and UI.",
              "- UI: PNG, power-of-two canvas, 2× resolution, transparent background; icons 128 px.",
              "- Each delivered id is written into `AssetRegistry` and checked in game the same day.", ""]
    for s in STEPS:
        rows = by_step[s]
        if not rows:
            continue
        lines += [f"## Step {s}", "", "| Id | Kind | What | Placeholder size |", "|---|---|---|---|"]
        for a in sorted(rows, key=lambda a: (KIND_ORDER.index(a["kind"]), a["id"])):
            lines.append(f"| {a['id']} | {a['kind']} | {a['desc']} | {a['size'] or '—'} |")
        lines.append("")
    with open(os.path.join(ROOT, "27-assets.md"), "w", encoding="utf-8", newline="
") as f:
        f.write("\n".join(lines))

    # ---- 26 injection
    p26 = os.path.join(ROOT, "26-build-roadmap.md")
    text = open(p26, encoding="utf-8").read()

    def block(step):
        rows = by_step.get(step, [])
        if not rows:
            return f"<!-- ASSETS {step} -->none.<!-- /ASSETS -->"
        parts = []
        for k in KIND_ORDER:
            ids = [a["id"] for a in rows if a["kind"] == k]
            if ids:
                parts.append(f"{KIND_NAME[k]} ({len(ids)}): {compress(ids)}")
        return (f"<!-- ASSETS {step} -->{len(rows)} assets, full rows in `27` Step {step}. "
                + "; ".join(parts) + ".<!-- /ASSETS -->")

    def repl(m):
        return block(m.group(1))

    text = re.sub(r"<!-- ASSETS (\w+) -->(?:.*?<!-- /ASSETS -->)?", repl, text, flags=re.S)
    open(p26, "w", encoding="utf-8", newline="
").write(text)
    print(f"assets {len(table)}; written 27-assets.md and updated 26")


if __name__ == "__main__":
    main()
