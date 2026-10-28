#!/usr/bin/env bash
# Link ~/.claude/CLAUDE.md to user-instructions.md in this repository,
# so Claude Code reads the user instructions in every session, link each
# agent type in agents/ into ~/.claude/agents/, so every session can start
# it in every repository, and remove an attribution.commit of false from
# ~/.claude/settings.json, so Claude Code adds its co-author line to commits.
# Written for a Mac; nothing in it is Mac-specific.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$repo_dir/user-instructions.md"
target="$HOME/.claude/CLAUDE.md"
agents_dir="$HOME/.claude/agents"
settings="$HOME/.claude/settings.json"

backup_name() {
  echo "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

link_file() {
  local source="$1" link="$2"

  if [[ -L "$link" && "$(readlink "$link")" == "$source" ]]; then
    echo "Already linked: $link -> $source"
    return
  fi

  if [[ -e "$link" || -L "$link" ]]; then
    local backup
    backup="$(backup_name "$link")"
    mv "$link" "$backup"
    echo "Existing file moved to $backup"
  fi

  ln -s "$source" "$link"
  echo "Linked: $link -> $source"
}

link_agents() {
  mkdir -p "$agents_dir"
  local agent
  for agent in "$repo_dir"/agents/*.md; do
    [[ -e "$agent" && "$(basename "$agent")" != README.md ]] || continue
    link_file "$agent" "$agents_dir/$(basename "$agent")"
  done
}

clear_attribution() {
  if [[ ! -e "$settings" ]]; then
    echo "Already clear: no $settings"
    return
  fi

  if ! command -v python3 >/dev/null 2>&1; then
    echo "python3 not found: remove \"commit\": false under \"attribution\" in $settings by hand, if it is there" >&2
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
if not isinstance(attribution, dict) or attribution.get("commit") is not False:
    print(f"Already clear: no attribution.commit false in {path}")
    sys.exit(0)
shutil.copy2(path, backup)
del attribution["commit"]
if not attribution:
    del data["attribution"]
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
print(f"Removed attribution.commit false from {path}; previous file kept as {backup}")
PY
}

if [[ ! -f "$source_file" ]]; then
  echo "Missing $source_file" >&2
  exit 1
fi

mkdir -p "$HOME/.claude"
link_file "$source_file" "$target"
link_agents
clear_attribution
