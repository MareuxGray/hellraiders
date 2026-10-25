#!/usr/bin/env python3
"""HellRaiders number checks.

Blueprint mode (default): checks the blueprint's own maths and prints the odds tables that go into Strings
(19 §19.2). Repo mode (after S0): also checks that every `Key = value` in 02's Config key column appears in
src/shared/Config.luau.

Usage: python3 tools/check_numbers.py [--config path/to/Config.luau]
Prints ERRORS <n>.
"""
import itertools
import os
import re
import sys
from fractions import Fraction
from functools import lru_cache

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
errors = 0


def err(msg):
    global errors
    errors += 1
    print("ERROR", msg)


def read(name):
    for base in (ROOT, os.path.join(ROOT, "blueprint")):
        p = os.path.join(base, name)
        if os.path.exists(p):
            return open(p, encoding="utf-8").read()
    raise SystemExit(f"missing {name}")


def table_rows(text, header_start):
    """Rows (list of cells) of the first markdown table whose header row starts with header_start."""
    lines = text.splitlines()
    for i, l in enumerate(lines):
        if l.startswith("| " + header_start):
            rows = []
            for r in lines[i + 2:]:
                if not r.startswith("|"):
                    break
                rows.append([c.strip() for c in r.strip("|").split("|")])
            return rows
    err(f"table '{header_start}' not found")
    return []


# ------------------------------------------------------------------ survivors
@lru_cache(None)
def gen_dist(n_attrs, points, cap_extra):
    """Distribution of the final extra points of attribute 0 when `points` are added one at a time,
    uniformly among attributes whose extra < cap_extra. Returns {extra: Fraction}."""
    out = {}

    @lru_cache(None)
    def rec(state, left):
        if left == 0:
            return {state[0]: Fraction(1)}
        elig = [i for i, v in enumerate(state) if v < cap_extra]
        res = {}
        for i in elig:
            s = list(state)
            s[i] += 1
            for k, p in rec(tuple(s), left - 1).items():
                res[k] = res.get(k, 0) + p / len(elig)
        return res

    out = rec(tuple([0] * n_attrs), points)
    return out


def survivors():
    print("\n== Survivor generation (13 §13.2): chance of each value for one attribute")
    d = gen_dist(5, 10, 4)
    if sum(d.values()) != 1:
        err("survivor distribution doesn't sum to 1")
    for extra in range(5):
        print(f"  {3 + extra}: {float(d.get(extra, 0)) * 100:.2f}%")
    print("== Lock & Reroll: other four attributes, by locked value")
    for v in range(3, 8):
        pts = 25 - v - 12
        if pts < 0 or pts > 16:
            err(f"lock value {v} impossible")
            continue
        dd = gen_dist(4, pts, 4)
        row = ", ".join(f"{3 + e}: {float(dd.get(e, 0)) * 100:.1f}%" for e in range(5))
        print(f"  locked {v}: {row}")


# ------------------------------------------------------------------ wheel, crates, catalysts
def odds():
    t12 = read("12-crafting-blueprints-wheel.md")
    print("\n== Blueprint Wheel (12 §12.5)")
    for r in table_rows(t12, "Jump"):
        nums = [int(x.rstrip("%")) for x in r[1:4]]
        print(f"  {r[0]}: success {nums[0]}%, downgrade {nums[1]}%, destroyed {nums[2]}%")
        if sum(nums) != 100:
            err(f"wheel row {r[0]} sums to {sum(nums)}")
    t19 = read("19-shop-monetisation.md")
    m = re.search(r"Common (\d+)%, Rare (\d+)%, Epic (\d+)%, Exotic (\d+)%", t19)
    if m:
        s = sum(int(x) for x in m.groups())
        print(f"== Evac Pass Blueprint Crate: {m.group(0)}")
        if s != 100:
            err(f"crate odds sum {s}")
    else:
        err("crate odds not found in 19")
    m = re.search(r"weights 0/0/40/45/15", t19)
    if not m:
        err("supply crate weights not found in 19 §19.7")


# ------------------------------------------------------------------ loot tables
def loot():
    t11 = read("11-loot-containers-inventory.md")
    print("\n== Container tier weights (11 §11.3)")
    for r in table_rows(t11, "Class"):
        w = r[4]
        if w in ("—", ""):
            continue
        nums = [int(x) for x in w.split("/")]
        if sum(nums) != 100:
            err(f"container {r[0]} weights sum {sum(nums)}")
    m = re.search(r"Blueprint tier weights: Common (\d+), Rare (\d+), Epic (\d+), Exotic (\d+)", t11)
    if not m or sum(int(x) for x in m.groups()) != 100:
        err("blueprint tier weights don't sum to 100")
    t23 = read("23-maps.md")
    total = 0
    for r in table_rows(t23, "Wing | Bins"):
        if r[0].startswith("**"):
            if int(r[-1].strip("*")) != total:
                err(f"23 §23.7 wings total {r[-1]} != {total}")
            continue
        cells = [int(x) for x in r[1:11]]
        if sum(cells) != int(r[11]):
            err(f"23 §23.7 row {r[0]} sums {sum(cells)} != {r[11]}")
        total += int(r[11])
    grand = total + 48 * 2
    print(f"  map containers: wings {total} + galleria 96 = {grand}")
    if not 215 <= grand <= 235:
        err("container total outside 215–235")


# ------------------------------------------------------------------ timing, tower, progression
def misc():
    t02 = read("02-shared-values.md")
    print("\n== Raid timing")
    total = 1020 + 120 + 45 + 90 + 30
    print(f"  failsafe + countdown + open + lockdown + reopen = {total}")
    if total != 1305 or "1305" not in t02:
        err("raid max length isn't 1305 in 02")
    print("== Tower slots")
    if 32 + 24 + 8 != 64 or "Bunk=32, Executive=24, Penthouse=8" not in t02:
        err("tower flats don't total 64")
    t14 = read("14-tower-residency-migration.md")
    if "4 corridors × 8 Bunk doors (32)" not in t14 or "6 corridors × 4 Executive doors (24)" not in t14 \
            or "4 corridors × 2 Penthouse doors (8)" not in t14:
        err("14 tower layout doors don't match 32/24/8")
    print("== Level curve (13 §13.4)")
    xp = sum(400 + 120 * (n - 1) for n in range(1, 100))
    print(f"  total XP to level 100: {xp:,}")
    t13 = read("13-survivors-progression.md")
    if f"{xp:,}" not in t13:
        err(f"13 §13.4 should state the level-100 total as {xp:,}")
    print("== Economy anchors")
    print(f"  Executive Suite 250,000 / target haul 6,000 = {250000 / 6000:.1f} raids")
    t10 = read("10-evac-extraction-lockdown.md")
    for needle in ("120 s", "45 s", "90 s", "30 s"):
        if needle not in t10:
            err(f"10 missing {needle}")


# ------------------------------------------------------------------ config mirror (repo mode)
def config_mirror(path):
    t02 = read("02-shared-values.md")
    pairs = re.findall(r"`([A-Za-z][\w.]*)\s*=\s*([^`]+)`", t02)
    cfg = open(path, encoding="utf-8").read()
    flat = re.sub(r"\s+", "", cfg)
    print(f"\n== Config mirror: {len(pairs)} keys from 02")
    for key, val in pairs:
        leaf = key.split(".")[-1]
        needle = re.sub(r"\s+", "", f"{leaf}={val}")
        if needle not in flat:
            err(f"Config.luau missing {key} = {val}")


def main():
    survivors()
    odds()
    loot()
    misc()
    if "--config" in sys.argv:
        config_mirror(sys.argv[sys.argv.index("--config") + 1])
    print(f"\nERRORS {errors}")


if __name__ == "__main__":
    main()
