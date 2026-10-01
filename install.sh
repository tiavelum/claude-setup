#!/usr/bin/env bash
# Link ~/.claude/CLAUDE.md to user-instructions.md in this repository,
# so Claude Code reads the personal instructions in every session.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$repo_dir/user-instructions.md"
target="$HOME/.claude/CLAUDE.md"

if [[ ! -f "$source_file" ]]; then
  echo "Missing $source_file" >&2
  exit 1
fi

mkdir -p "$HOME/.claude"

if [[ -L "$target" && "$(readlink "$target")" == "$source_file" ]]; then
  echo "Already linked: $target -> $source_file"
  exit 0
fi

if [[ -e "$target" || -L "$target" ]]; then
  backup="$target.backup-$(date +%Y%m%d-%H%M%S)"
  mv "$target" "$backup"
  echo "Existing file moved to $backup"
fi

ln -s "$source_file" "$target"
echo "Linked: $target -> $source_file"
