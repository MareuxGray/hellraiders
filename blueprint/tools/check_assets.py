#!/usr/bin/env python3
"""Checks that every asset id mentioned in the blueprint (or, after S0, in src/) exists in tools/assets_master.py.
Usage: python3 tools/check_assets.py [folder-to-scan ...]   (default: the blueprint folder's *.md)
Prints ERRORS <n>.
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
from assets_master import ASSETS  # noqa: E402

KINDS = "MDL|ANIM|SFX|MUS|VO|UI|VFX|TEX"
PAT = re.compile(rf"\b({KINDS})-([A-Z]+)-(\d{{3}})((?:…|\.\.\.|/)(\d{{3}}))?")


def expand(m):
    kind, group, a, _, b = m.groups()
    a = int(a)
    if b is None:
        return [f"{kind}-{group}-{a:03d}"]
    b = int(b)
    sep = m.group(4)[0]
    if sep == "/":
        return [f"{kind}-{group}-{a:03d}", f"{kind}-{group}-{b:03d}"]
    return [f"{kind}-{group}-{i:03d}" for i in range(a, b + 1)]


def files(targets):
    for t in targets:
        if os.path.isfile(t):
            yield t
            continue
        for d, _, fs in os.walk(t):
            for f in fs:
                if f.endswith((".md", ".luau", ".lua")) and f != "27-assets.md":
                    yield os.path.join(d, f)


def main():
    known = {a["id"] for a in ASSETS}
    targets = sys.argv[1:] or [ROOT]
    errors = 0
    seen = set()
    for path in files(targets):
        if "/tools/" in path:
            continue
        for ln, line in enumerate(open(path, encoding="utf-8"), 1):
            for m in PAT.finditer(line):
                for aid in expand(m):
                    seen.add(aid)
                    if aid not in known:
                        errors += 1
                        print(f"MISSING {aid}  ({os.path.relpath(path, ROOT)}:{ln})")
    print(f"ids referenced {len(seen)}, in master {len(known)}")
    print(f"ERRORS {errors}")


if __name__ == "__main__":
    main()
