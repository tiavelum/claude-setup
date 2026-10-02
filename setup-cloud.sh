#!/usr/bin/env bash
# Install the personal instructions as ~/.claude/CLAUDE.md in a Claude Code cloud VM.
# Run by the cloud environment's setup script; see README, "For cloud sessions".
set -euo pipefail

url="https://raw.githubusercontent.com/tiavelum/claude-setup/main/user-instructions.md"

mkdir -p "$HOME/.claude"
curl -fsSL "$url" -o "$HOME/.claude/CLAUDE.md"
echo "Installed $HOME/.claude/CLAUDE.md from $url"
