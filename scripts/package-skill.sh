#!/usr/bin/env bash
# Packages skills/<skill>/ into <dir>/<skill>.zip, the form the Claude app's
# skill upload expects: one ZIP holding the folder named after the skill.
set -euo pipefail

usage() {
  echo "usage: $0 <skill> [<dir>]" >&2
  echo "Writes <dir>/<skill>.zip, by default in ~/Downloads." >&2
}

if [[ $# -lt 1 || $# -gt 2 || $1 == -* ]]; then
  usage
  exit 2
fi

skill=$1
dir=${2:-$HOME/Downloads}
skills=$(cd "$(dirname "${BASH_SOURCE[0]}")/../skills" && pwd)

if [[ $skill == */* || ! -f "$skills/$skill/SKILL.md" ]]; then
  echo "$0: no skill $skill in $skills; the skills are:" >&2
  for found in "$skills"/*/SKILL.md; do
    basename "$(dirname "$found")" >&2
  done
  exit 2
fi

if [[ ! -d $dir ]]; then
  echo "$0: no folder $dir" >&2
  exit 2
fi

zip_file="$(cd "$dir" && pwd)/$skill.zip"
# zip adds to an existing archive, so a ZIP of an older version would keep
# files the skill no longer has.
rm -f "$zip_file"
(cd "$skills" && zip -q -r "$zip_file" "$skill" -x '*.DS_Store')

echo "$zip_file"
echo "Upload it in the Claude app under Customize > Skills: +, Create skill, Upload a skill."
