# claude-setup

Andi's personal instructions for Claude, kept as one text that both claude.ai and
Claude Code use.

## How it fits together

```
user-instructions.md  ──symlink──▶  ~/.claude/CLAUDE.md   (Claude Code, every session)
        │
        └──── pasted by hand ───▶  claude.ai Settings > Profile > personal preferences
```

`user-instructions.md` is the master. Claude Code picks up every change immediately
through the symlink. claude.ai has no way to read a file, so after each change the
text is pasted into the personal preferences field by hand.

The file holds only general rules. Rules for a single project live in that project's
repository as `project-instructions.md`, imported by its `CLAUDE.md` and pasted into
the claude.ai project's instructions field. This repository follows the same pattern
for its own work.

## Install on a Mac

```bash
git clone git@github.com:tiavelum/claude-setup.git ~/vc/claude-setup
bash ~/vc/claude-setup/install.sh
```

`install.sh` links `~/.claude/CLAUDE.md` to `user-instructions.md`. An existing
`~/.claude/CLAUDE.md` is first moved to `~/.claude/CLAUDE.md.backup-<timestamp>`;
check it and carry anything worth keeping into `user-instructions.md`. Running the
script again is safe.

To confirm it worked, run `/context` in a Claude Code session and look for
`~/.claude/CLAUDE.md` under Memory files.

## Contents

| File | Purpose |
|---|---|
| `user-instructions.md` | The personal instructions, master copy for both surfaces |
| `install.sh` | Links `~/.claude/CLAUDE.md` to `user-instructions.md` |
| `project-instructions.md` | How Claude works on this repository; master of the claude.ai project's instructions field |
| `CLAUDE.md` | Imports `project-instructions.md` for Claude Code sessions in this repository |

## Changing the instructions

1. Edit `user-instructions.md` and commit.
2. Paste the full new text into the claude.ai personal preferences field. Changes
   there apply to new conversations only.

## Known limits

- In Cowork sessions on the desktop, Claude Code skips a `~/.claude/CLAUDE.md` that
  is a symlink, so those sessions do not see these instructions. The terminal and
  the Code tab of the desktop app are not affected.
- Claude Code's auto memory stays on and writes its own notes to
  `~/.claude/projects/<project>/memory/`, outside this repository. The memory rules in
  `user-instructions.md` cover only what Claude writes deliberately.
