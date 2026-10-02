# claude-setup

Andi's personal instructions for Claude, kept as one text that claude.ai and Claude
Code both use, and the pattern every project repository follows.

## How it fits together

```
user-instructions.md  ──symlink──▶  ~/.claude/CLAUDE.md   (Claude Code on the Mac)
        │
        └──── pasted by hand ───▶  claude.ai Settings > Profile > personal preferences
```

`user-instructions.md` is the master. Claude Code reads it from the local clone
through the symlink, so it sees whatever version that clone holds: an edit made in
`~/vc/claude-setup` applies at the next session, while a change committed elsewhere
(on GitHub, or by a session through the GitHub connector) applies only after the
clone has been pulled. claude.ai has no way to read a file, so after each change the
text is pasted into the personal preferences field by hand.

## Surfaces

The setup knows two surfaces, told apart by what a session reads at startup rather
than by the app it runs in: claude.ai reads the account settings (preferences, project
instructions field), Claude Code reads `CLAUDE.md` files. The desktop app hosts both.

| Where Claude runs | Surface | Personal instructions arrive |
|---|---|---|
| Chat on claude.ai, the mobile app, and the desktop app's Chat mode | claude.ai | Yes, through the preferences field |
| Claude Code on the Mac: terminal, IDE, the desktop app's Code tab | Claude Code | Yes, through the symlink |
| Cowork on the Mac | Claude Code | No, see Known limits |
| Claude Code in the cloud: claude.ai/code, cloud sessions started from the desktop or mobile app, routines | Claude Code | No, see Known limits |

Project instructions reach claude.ai through the project's instructions field, and
Claude Code through the repository's `CLAUDE.md` wherever a session works in the
repository, including cloud sessions, which clone it.

## Design principles

- Instruction files (`user-instructions.md`, `project-instructions.md`, `CLAUDE.md`)
  hold directives only. Explanations, like this one, live in the README.
- Rules in `user-instructions.md` and `project-instructions.md` hold unchanged on both
  surfaces. Content only Claude Code can use goes into `CLAUDE.md`, below the import.
- Every rule is short and checkable, and states the behaviour wanted rather than how a
  Claude product works. A product change then does not break it.
- The setup is made reliable by structure: which file holds what, the import and the
  symlink, not by prose describing how Claude works.

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
| `project-instructions.md` | Rules for working on this repository; master of the claude.ai project's instructions field |
| `CLAUDE.md` | Imports `project-instructions.md` and adds rules for Claude Code sessions in this repository |

## The files

`user-instructions.md` applies to all of Andi's work, on every surface. Rules for a
single project never go here; they live in that project's `project-instructions.md`.
The file is plain text: one rule per paragraph, separated by blank lines, and no
tables, `#` headings, bullets or angle brackets. The claude.ai preferences field takes
only text, and this way the raw file and the rendered GitHub page copy as the same
text.

`project-instructions.md` and `CLAUDE.md` here govern how Claude works on this
repository, following the same pattern every project repository uses (see
"Setting up a project repository").

## Changing the instructions

1. Edit `user-instructions.md` and commit, keeping it plain text as described above.
2. If the change was committed anywhere but the local clone, pull it on the Mac:
   `git -C ~/vc/claude-setup pull`. Until then, Claude Code keeps reading the old
   version.
3. Replace the whole claude.ai personal preferences field with the new text. Changes
   there apply to new conversations only.

## Setting up a project repository

A repository that is also a claude.ai project gets two files:

| File | Read by | Holds |
|---|---|---|
| `project-instructions.md` | Claude Code through the import; claude.ai pasted into the project's instructions field | The project's rules, valid on both surfaces. This is the master. |
| `CLAUDE.md` | Claude Code only | The import on its first line, then only what needs Claude Code: build and test commands, file paths |

Start `CLAUDE.md` from this template:

```markdown
@project-instructions.md

## Claude Code only

- Build: ...
- Test: ...
```

- Import with `@`. A sentence telling Claude to read the file loads it only if Claude
  decides to open it.
- `/init` on a repository that already has a `CLAUDE.md` suggests improvements instead
  of overwriting it. Put Code-only suggestions below the import and move anything that
  holds on both surfaces into `project-instructions.md`.
- After changing `project-instructions.md`, paste it into the claude.ai project's
  instructions field.
- Reference material lives in the repository. Claude Code reads it on demand; in
  claude.ai, add it to the project's knowledge.

## How memory maps onto the surfaces

| Layer | claude.ai | Claude Code |
|---|---|---|
| General | Account memory | `user-instructions.md`, through `~/.claude/CLAUDE.md` |
| Project | The project's memory | `project-instructions.md` and `CLAUDE.md`, plus auto memory |

The memory rules in `user-instructions.md` cover what Claude writes deliberately.
Claude Code's auto memory writes its own notes to
`~/.claude/projects/<project>/memory/`, outside this repository.

## Known limits

- In Cowork sessions on the desktop, Claude Code skips a `~/.claude/CLAUDE.md` that is
  a symlink, so those sessions do not see these instructions. The terminal and the Code
  tab of the desktop app are not affected.
- Claude Code cloud sessions start from a fresh clone of the repository and do not read
  `~/.claude/CLAUDE.md`, which exists only on the Mac. They see a repository's project
  instructions but not these personal instructions.
