#!/usr/bin/env sh
# HellRaiders pre-commit (25 §25.1): lint, format check, blueprint checks, headless tests.
# Install as a git hook with:  cp tools/precommit.sh .git/hooks/pre-commit
set -e
cd "$(dirname "$0")/.."
echo "== selene"
selene src tests
echo "== stylua --check"
stylua --check src tests
echo "== check scripts (repo mode)"
python -X utf8 tools/check_assets.py src blueprint
python -X utf8 tools/check_numbers.py --config src/shared/Config.luau
python -X utf8 tools/check_strings.py --strings src/shared/Strings.luau --src src
echo "== lune tests"
lune run tests/lune/run
echo "precommit OK"
