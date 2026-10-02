# claude-setup

Personal instructions for Claude, kept in a single file, `user-instructions.md`, and
delivered from there to the Claude app and to Claude Code, locally and in the cloud.
Also the instruction pattern every project repository follows.

**Keep this repository public.** Cloud sessions download from it, so nothing private
belongs here.

## Setup

Setup puts the same personal instructions in front of Claude everywhere you use it.
The Claude app reads them from your account. Claude Code reads them from
`~/.claude/CLAUDE.md`, a file that has to be put in place separately on your own
machine and in each cloud environment.

Which setup applies depends on what runs, not on the window you open:

| You open | Claude app | Claude Code, local | Claude Code, cloud |
|---|---|---|---|
| Browser | claude.ai | –¹ | claude.ai/code |
| Mobile | Chat | –¹ | Code |
| Desktop | Chat | Code, "Local" | Code, cloud environment |
| Terminal, IDE | – | `claude` | `claude --cloud` |

¹ A local session can be operated from the browser or phone via Remote Control; it
uses the local setup.

### Claude app

Copies the instructions into your account, where every new chat reads them.

1. Open **Settings > Profile** and paste the whole of `user-instructions.md` into the
   personal preferences field.
2. If you use a claude.ai project for this repository, paste `project-instructions.md`
   into that project's instructions field.

### Claude Code, local

Links `~/.claude/CLAUDE.md` to `user-instructions.md` in a local clone, so edits there
apply from the next session.

1. Clone the repository and run the setup script:

   ```bash
   git clone git@github.com:tiavelum/claude-setup.git ~/vc/claude-setup
   bash ~/vc/claude-setup/setup-local.sh
   ```

2. Verify: start Claude Code and run

   ```
   /context
   ```

   Memory files must list `~/.claude/CLAUDE.md`.

### Claude Code, cloud

Adds a setup script to your cloud environment that downloads `user-instructions.md`
into every new cloud session. Done once per cloud environment in your claude.ai
account; usually there is just one, called "Default".

1. In a browser, log in to claude.ai and open Claude Code:

   ```
   https://claude.ai/code
   ```

2. Open any session, or start one with **New**. Click the session title at the top
   left and choose **Edit cloud environment**.

3. In **Setup script**, enter:

   ```bash
   # rebuilt 2026-10-02
   curl -fsSL https://raw.githubusercontent.com/tiavelum/claude-setup/main/setup-cloud.sh | bash || true
   ```

   Keep the `curl` command on one line; the field may wrap it on screen.

4. Click **Save changes**. Changes apply to new sessions only.

5. Verify: start a new session with **New** and run

   ```
   /context
   ```

   Memory files must list `/root/.claude/CLAUDE.md`.

## After changing a file

Commit, then:

| Changed file | Claude app | Claude Code, local | Claude Code, cloud |
|---|---|---|---|
| `user-instructions.md` | Paste into preferences¹ | Pull² | Rebuild³ |
| `project-instructions.md` | Paste into project instructions¹ | Pull² | – |
| `CLAUDE.md` | – | Pull² | – |
| `setup-local.sh` | – | Pull², then rerun the script | – |
| `setup-cloud.sh` | – | – | Rebuild³ |

Other files need nothing.

¹ Replace the whole field, as in Setup, "Claude app". Applies to new chats.

² `git -C ~/vc/claude-setup pull`, only if the commit was made outside the local clone.

³ Open the setup script as in Setup, "Claude Code, cloud", steps 1 to 3, change the
comment line (for example the date) and save. Otherwise the change arrives when the
cached environment expires, after roughly seven days.

## How it works

```
user-instructions.md  ──symlink──▶  ~/.claude/CLAUDE.md   (Claude Code, local)
        │
        ├──── downloaded by ────▶  ~/.claude/CLAUDE.md   (Claude Code, cloud)
        │     setup-cloud.sh
        │
        └──── pasted by hand ───▶  claude.ai Settings > Profile > personal preferences
```

The Claude app reads your account settings; Claude Code reads `CLAUDE.md` files. On
your own machine the symlink makes an edit in the clone apply at the next session; a
change committed elsewhere needs a pull first. A cloud session gets a copy from
`main`, taken when its environment is built. Project instructions reach the Claude
app through the project's instructions field and Claude Code through the repository's
`CLAUDE.md`, cloud sessions included.

## Files

| File | Purpose |
|---|---|
| `user-instructions.md` | Personal instructions for all work, everywhere. The master. Project rules never go here |
| `setup-local.sh` | Links `~/.claude/CLAUDE.md` to `user-instructions.md` on your own machine |
| `setup-cloud.sh` | Writes `user-instructions.md` to `~/.claude/CLAUDE.md` in a cloud VM |
| `project-instructions.md` | Rules for working on this repository; master of this claude.ai project's instructions field |
| `CLAUDE.md` | Imports `project-instructions.md`, then rules for Claude Code only |

`user-instructions.md` is plain text: one rule per paragraph, blank lines between, no
tables, `#` headings, bullets or angle brackets. The preferences field takes only
text, and the raw file and the rendered GitHub page then copy as the same text.

## Design principles

- Instruction files hold directives only. Explanations live in this README.
- Rules in `user-instructions.md` and `project-instructions.md` hold for both the
  Claude app and Claude Code. Content only Claude Code can use goes into `CLAUDE.md`,
  below the import.
- Rules are short and checkable, and state the behaviour wanted rather than how a
  product works, so a product change does not break them.
- Reliability comes from structure (which file holds what, the import, the symlink,
  the setup script), not from prose about how Claude works.

## Setting up a project repository

| File | Read by | Holds |
|---|---|---|
| `project-instructions.md` | Claude Code through the import; the Claude app pasted into the project's instructions field | The project's rules, valid for both. The master |
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
  in the Claude app, add it to the project's knowledge.

## Memory

| Layer | Claude app | Claude Code |
|---|---|---|
| General | Account memory | `user-instructions.md`, through `~/.claude/CLAUDE.md` |
| Project | The project's memory | `project-instructions.md` and `CLAUDE.md`, plus auto memory |

The memory rules in `user-instructions.md` cover what Claude writes deliberately.
Claude Code's auto memory keeps its own notes in
`~/.claude/projects/<project>/memory/`, outside this repository.

## Known limits

- Claude Code's documentation says Cowork sessions on the desktop skip a
  `~/.claude/CLAUDE.md` that is a symlink. Whether this still applies is open in
  issue #4.
- Cloud sessions lag behind `main` until their environment is rebuilt, up to about a
  week (see "After changing a file").
- Anthropic's documentation does not describe loading a `~/.claude/CLAUDE.md` written
  by a setup script. Verified on 2026-10-02; if cloud sessions stop showing the
  personal instructions, repeat the check in step 5 under "Claude Code, cloud".
