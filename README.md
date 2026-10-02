# claude-setup

Personal instructions for Claude: one text for claude.ai and Claude Code, plus the
pattern every project repository follows.

**Keep this repository public.** Cloud sessions download `user-instructions.md` and
`setup-cloud.sh` from it without credentials, so nothing private belongs here.

## How it works

```
user-instructions.md  ──symlink──▶  ~/.claude/CLAUDE.md   (Claude Code on the Mac)
        │
        ├──── downloaded by ────▶  ~/.claude/CLAUDE.md   (Claude Code cloud sessions)
        │     setup-cloud.sh
        │
        └──── pasted by hand ───▶  claude.ai Settings > Profile > personal preferences
```

| Where Claude runs | Reads | Personal instructions arrive |
|---|---|---|
| Chat: claude.ai, mobile app, desktop app's Chat mode | Account settings | Pasted into the preferences field |
| Claude Code on the Mac: terminal, IDE, desktop app's Code tab | `CLAUDE.md` files | Through the symlink, at the next session; a change committed elsewhere needs a pull first |
| Claude Code in the cloud: claude.ai/code, cloud sessions from the desktop or mobile app, routines | `CLAUDE.md` files | As a copy from `main`, taken when the environment is built |
| Cowork on the Mac | `CLAUDE.md` files | No, see Known limits |

What a session reads decides the surface, not the app: the desktop app hosts both.
Project instructions reach claude.ai through the project's instructions field and
Claude Code through the repository's `CLAUDE.md`, cloud sessions included.

## Files

| File | Purpose |
|---|---|
| `user-instructions.md` | Personal instructions for all work, on every surface. The master. Project rules never go here |
| `setup-mac.sh` | Links `~/.claude/CLAUDE.md` to `user-instructions.md` |
| `setup-cloud.sh` | Writes `user-instructions.md` to `~/.claude/CLAUDE.md` in a cloud VM |
| `project-instructions.md` | Rules for working on this repository; master of this claude.ai project's instructions field |
| `CLAUDE.md` | Imports `project-instructions.md`, then rules for Claude Code only |

`user-instructions.md` is plain text: one rule per paragraph, blank lines between, no
tables, `#` headings, bullets or angle brackets. The claude.ai field takes only text,
and the raw file and the rendered GitHub page then copy as the same text.

## Design principles

- Instruction files hold directives only. Explanations live in this README.
- Rules in `user-instructions.md` and `project-instructions.md` hold on both surfaces.
  Content only Claude Code can use goes into `CLAUDE.md`, below the import.
- Rules are short and checkable, and state the behaviour wanted rather than how a
  product works, so a product change does not break them.
- Reliability comes from structure (which file holds what, the import, the symlink,
  the setup script), not from prose about how Claude works.

## Install

### Mac

```bash
git clone git@github.com:tiavelum/claude-setup.git ~/vc/claude-setup
bash ~/vc/claude-setup/setup-mac.sh
```

An existing `~/.claude/CLAUDE.md` is first moved to
`~/.claude/CLAUDE.md.backup-<timestamp>`; carry over anything worth keeping. Safe to
run again. Check: `/context` in a Claude Code session lists `~/.claude/CLAUDE.md` under
Memory files.

### Cloud sessions

An account setting, made once per cloud environment (usually just "Default"):

1. Open any Claude Code session at claude.ai/code. The badge next to the session title
   shows environment and repository, e.g. "Default · claude-setup".
2. Click the session title and choose **Edit cloud environment**.
3. Keep **Network access** at **Trusted** (it allows GitHub downloads). Set **Setup
   script** to the following, with the `curl` command on one line (the field may wrap
   it on screen):

   ```bash
   # rebuilt 2026-10-02
   curl -fsSL https://raw.githubusercontent.com/tiavelum/claude-setup/main/setup-cloud.sh | bash || true
   ```

4. **Save changes.** They apply to new sessions only.
5. Start a session with **New** and run `/context`: Memory files must list
   `/root/.claude/CLAUDE.md` next to the repository's files.

The script runs before Claude Code starts in a new VM and writes to the same path
`setup-mac.sh` links on the Mac. `|| true` lets the session start, without personal
instructions, if the download fails. The comment line exists only to force rebuilds.

## Changing the instructions

1. Edit `user-instructions.md` and commit, keeping it plain text.
2. Mac: if committed anywhere but the clone, `git -C ~/vc/claude-setup pull`.
3. claude.ai: replace the whole preferences field. Applies to new conversations.
4. Cloud: in each environment, open the setup script (steps 1 to 3 above), update the
   date and save. This forces a rebuild; otherwise the change arrives when the cache
   expires, after roughly seven days.

## Setting up a project repository

| File | Read by | Holds |
|---|---|---|
| `project-instructions.md` | Claude Code through the import; claude.ai pasted into the project's instructions field | The project's rules, valid on both surfaces. The master |
| `CLAUDE.md` | Claude Code only | The import on its first line, then only what needs Claude Code: build and test commands, file paths |

```markdown
@project-instructions.md

## Claude Code only

- Build: ...
- Test: ...
```

- Import with `@`. A sentence asking Claude to read the file works only if Claude
  decides to open it.
- `/init` on an existing `CLAUDE.md` suggests improvements instead of overwriting.
  Code-only suggestions go below the import, the rest into `project-instructions.md`.
- After changing `project-instructions.md`, paste it into the claude.ai project's
  instructions field.
- Reference material lives in the repository, where Claude Code reads it on demand;
  in claude.ai, add it to the project's knowledge.

## Memory

| Layer | claude.ai | Claude Code |
|---|---|---|
| General | Account memory | `user-instructions.md`, through `~/.claude/CLAUDE.md` |
| Project | The project's memory | `project-instructions.md` and `CLAUDE.md`, plus auto memory |

The memory rules in `user-instructions.md` cover what Claude writes deliberately.
Claude Code's auto memory keeps its own notes in
`~/.claude/projects/<project>/memory/`, outside this repository.

## Known limits

- Cowork skips a `~/.claude/CLAUDE.md` that is a symlink. The terminal and the Code
  tab are not affected.
- Cloud sessions lag behind `main` until their environment is rebuilt, up to about a
  week (see "Changing the instructions", step 4).
- Anthropic's documentation does not describe loading a `~/.claude/CLAUDE.md` written
  by a setup script. Verified on 2026-10-02; if cloud sessions stop showing the
  personal instructions, repeat the check in step 5 under "Cloud sessions".
