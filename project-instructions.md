# Project instructions: claude-setup

This project maintains my personal Claude setup: the instructions that apply to all
my work, for both claude.ai and Claude Code.

Source of truth is the GitHub repository tiavelum/claude-setup, cloned on my Mac to
~/vc/claude-setup. It holds user-instructions.md (my personal instructions), install.sh
(links ~/.claude/CLAUDE.md to that file) and the README. Read the README before working
in the repository and follow it.

Goal: one text that both surfaces use. user-instructions.md is the master. Claude Code
reads it through ~/.claude/CLAUDE.md; for claude.ai I paste it into the personal
preferences field.

Working rules:
- Write every rule so it works in both claude.ai and Claude Code. Where a rule means
  something different on each surface (memory, for example), say how it applies on each.
- Only general rules belong here. Anything specific to one project goes into that
  project's repository (project-instructions.md).
- Keep the file short and concrete; every rule should be checkable. Point out rules that
  are vague, contradict each other or no longer apply.
- When a change to user-instructions.md is committed, remind me to paste the new text
  into the claude.ai preferences field.
- Check claims about Claude Code behaviour (CLAUDE.md loading, imports, memory) against
  the current documentation at code.claude.com, and say when something is unverified.
- Show me the proposed wording before committing, unless I ask you to commit directly.
