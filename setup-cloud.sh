#!/usr/bin/env bash
# Install the user instructions as ~/.claude/CLAUDE.md and the agent types of
# agents/ in ~/.claude/agents/ of a Claude Code cloud VM.
# Run by the cloud environment's setup script; see README, "Claude Code, cloud".
set -euo pipefail

base="https://raw.githubusercontent.com/tiavelum/claude-setup/main"
# raw.githubusercontent.com serves single files and no directory listing, so
# the names of the files in agents/ are listed here.
agents=(checker worker)

mkdir -p "$HOME/.claude/agents"
curl -fsSL "$base/user-instructions.md" -o "$HOME/.claude/CLAUDE.md"
echo "Installed $HOME/.claude/CLAUDE.md from $base/user-instructions.md"

for agent in "${agents[@]}"; do
  curl -fsSL "$base/agents/$agent.md" -o "$HOME/.claude/agents/$agent.md"
  echo "Installed $HOME/.claude/agents/$agent.md from $base/agents/$agent.md"
done
