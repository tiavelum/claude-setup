#!/usr/bin/env bash
# Link ~/.claude/CLAUDE.md to user-instructions.md in this repository,
# so Claude Code reads the user instructions in every session, and set
# attribution.commit to false in ~/.claude/settings.json, so Claude Code
# adds no co-author line to commits.
# Written for a Mac; nothing in it is Mac-specific.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$repo_dir/user-instructions.md"
target="$HOME/.claude/CLAUDE.md"
settings="$HOME/.claude/settings.json"

backup_name() {
  echo "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

link_instructions() {
  if [[ -L "$target" && "$(readlink "$target")" == "$source_file" ]]; then
    echo "Already linked: $target -> $source_file"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    local backup
    backup="$(backup_name "$target")"
    mv "$target" "$backup"
    echo "Existing file moved to $backup"
  fi

  ln -s "$source_file" "$target"
  echo "Linked: $target -> $source_file"
}

set_attribution() {
  if [[ ! -e "$settings" ]]; then
    printf '{\n  "attribution": {\n    "commit": false\n  }\n}\n' >"$settings"
    echo "Created $settings with attribution.commit false"
    return
  fi

  if ! command -v python3 >/dev/null 2>&1; then
    echo "python3 not found: set \"attribution\": {\"commit\": false} in $settings by hand" >&2
    return
  fi

  python3 - "$settings" "$(backup_name "$settings")" <<'PY'
import json
import shutil
import sys

path, backup = sys.argv[1], sys.argv[2]
with open(path, encoding="utf-8") as f:
    data = json.load(f)
attribution = data.get("attribution")
if not isinstance(attribution, dict):
    attribution = {}
if attribution.get("commit") is False:
    print(f"Already set: attribution.commit false in {path}")
    sys.exit(0)
shutil.copy2(path, backup)
attribution["commit"] = False
data["attribution"] = attribution
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
print(f"Set attribution.commit false in {path}; previous file kept as {backup}")
PY
}

if [[ ! -f "$source_file" ]]; then
  echo "Missing $source_file" >&2
  exit 1
fi

mkdir -p "$HOME/.claude"
link_instructions
set_attribution
