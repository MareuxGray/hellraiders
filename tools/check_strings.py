#!/usr/bin/env python3
"""HellRaiders string checks.

Blueprint mode (default): every STR.* key mentioned in the blueprint exists in 21 §21.10.
Repo mode: python3 tools/check_strings.py --strings src/shared/Strings.luau [--src src]
  also checks every key in 21 §21.10 exists in Strings.luau, and every STR.* used in src exists there.
Keys ending in .* (families such as STR.NPC.*) are skipped.
Prints ERRORS <n>.
"""
import os
import re
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")  # Windows consoles default to cp1252

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
KEY = re.compile(r"STR\.[A-Z_]+(?:\.[A-Z_0-9]+)+")


def bp_files():
    for base in (ROOT, os.path.join(ROOT, "blueprint")):
        if os.path.exists(os.path.join(base, "21-hud-ui-controls-strings.md")):
            return base, sorted(f for f in os.listdir(base) if f.endswith(".md"))
    raise SystemExit("blueprint not found")


def main():
    errors = 0
    base, files = bp_files()
    t21 = open(os.path.join(base, "21-hud-ui-controls-strings.md"), encoding="utf-8").read()
    sec = t21[t21.index("## 21.10"):]
    defined = set(re.findall(r"^\| (STR\.[A-Z_.0-9]+) \|", sec, flags=re.M))
    used = {}
    for f in files:
        for ln, line in enumerate(open(os.path.join(base, f), encoding="utf-8"), 1):
            for k in KEY.findall(line):
                used.setdefault(k, f"{f}:{ln}")
    for k, where in sorted(used.items()):
        if k not in defined:
            errors += 1
            print(f"MISSING {k} ({where})")
    if "--strings" in sys.argv:
        sp = sys.argv[sys.argv.index("--strings") + 1]
        luau = open(sp, encoding="utf-8").read()
        have = set(re.findall(r'\["(STR\.[A-Z_.0-9]+)"\]', luau))
        for k in sorted(defined - have):
            errors += 1
            print(f"NOT IN Strings.luau {k}")
        if "--src" in sys.argv:
            src = sys.argv[sys.argv.index("--src") + 1]
            for d, _, fs in os.walk(src):
                for f in fs:
                    if f.endswith((".luau", ".lua")):
                        for k in KEY.findall(open(os.path.join(d, f), encoding="utf-8").read()):
                            if k not in have:
                                errors += 1
                                print(f"USED BUT MISSING {k} ({f})")
    print(f"strings defined {len(defined)}, referenced {len(used)}")
    print(f"ERRORS {errors}")


if __name__ == "__main__":
    main()
