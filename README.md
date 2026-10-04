# claude-setup

User instructions for Claude, the rules for all your work, kept in a single file,
`user-instructions.md`, and delivered from there to the Claude app and to Claude Code,
locally and in the cloud. Also the instruction pattern every project repository
follows, and skills that apply it.

**Keep this repository public.** Cloud sessions download from it, so nothing private
belongs here.

## Setup

Setup puts the same user instructions in front of Claude everywhere you use it.
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

1. Open **Settings > Account > Instructions for Claude** and paste the whole of
   `user-instructions.md` into that field.
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

### Skills

Uploads a skill from `skills/` to your claude.ai account. The Claude app, Claude
Code in the cloud and Claude Code locally all load it from there; locally this
requires signing in with `/login` rather than an API key. Done once per skill.

1. Package the skill folder; the ZIP must contain the folder named after the skill:

   ```bash
   cd ~/vc/claude-setup/skills && zip -r ~/Downloads/<skill>.zip <skill>
   ```

2. In the Claude app, open **Customize > Skills**, click **+**, choose
   **Create skill**, then **Upload a skill**, and select the ZIP.

3. Verify: start Claude Code and run

   ```
   /skills
   ```

   The skill must be listed under "claude.ai sync".

## Files

| File | Purpose |
|---|---|
| `user-instructions.md` | User instructions for all work, everywhere. The master. Project rules never go here |
| `setup-local.sh` | Links `~/.claude/CLAUDE.md` to `user-instructions.md` on your own machine |
| `setup-cloud.sh` | Writes `user-instructions.md` to `~/.claude/CLAUDE.md` in a cloud VM |
| `project-instructions.md` | Rules for working on this repository; master of this claude.ai project's instructions field |
| `CLAUDE.md` | Imports `project-instructions.md`, then rules for Claude Code only |
| `skills/project-instructions/SKILL.md` | Guided creation and review of a repository's `project-instructions.md` |

The instruction files hold directives only; explanations live in this README.

Skill frontmatter uses only `name` and `description`. The upload rejects fields that
only Claude Code understands.

`user-instructions.md` is plain text: one rule per paragraph, blank lines between, no
tables, `#` headings, bullets or angle brackets. The Instructions for Claude field
takes only text, and the raw file and the rendered GitHub page then copy as the same
text.

## After changing a file

Commit, then:

| Changed file | Claude app | Claude Code, local | Claude Code, cloud |
|---|---|---|---|
| `user-instructions.md` | Paste into Instructions for Claude¹ | Pull² | Rebuild³ |
| `setup-local.sh` | – | Pull², then rerun the script | – |
| `setup-cloud.sh` | – | – | Rebuild³ |
| `project-instructions.md` | Paste into project instructions¹ | Pull² | – |
| `CLAUDE.md` | – | Pull² | – |
| `skills/<skill>/SKILL.md` | Re-upload⁴ | – | – |

Other files need nothing.

¹ Replace the whole field, as in Setup, "Claude app". Applies to new chats.

² `git -C ~/vc/claude-setup pull`, only if the commit was made outside the local clone.

³ Open the setup script as in Setup, "Claude Code, cloud", steps 1 to 3, change the
comment line (for example the date) and save. Otherwise the change arrives when the
cached environment expires, after roughly seven days.

⁴ Package and upload as in Setup, "Skills"; the upload replaces the existing
version. Claude Code picks up the new version on its own.

## Setting up a project repository

Every repository used with Claude gets two files:

1. `project-instructions.md` with the project's rules. Paste the whole file into the
   claude.ai project's instructions field, and again after every change. Leave the
   project's description field empty or minimal; Claude does not read it.
2. `CLAUDE.md`, which imports those rules for Claude Code. Start from this template
   and add below the import only what Claude Code alone needs:

   ```markdown
   @project-instructions.md

   ## Claude Code only

   - Build: ...
   - Test: ...
   ```

To write or review a project's instructions, use the `project-instructions` skill.

### What project-instructions.md contains

In this order, usually one screen in total:

1. **Anchor:** the repository (`tiavelum/<name>`), its local clone (`~/vc/<name>`),
   and the rule to read `README.md` before working in it and follow it.
2. **Purpose:** one or two sentences on what the project is for.
3. **Rules:** only what holds for this project: invariants, when a change counts as
   done, approval steps, and constraints that protect data.

The file points to knowledge; it does not hold it. What the README or the
repository says stays there, and what `user-instructions.md` says already applies
everywhere. A rule earns its place when Claude would otherwise get it wrong,
typically the second time you correct the same thing.

## Memory

Memory is what Claude records itself, as opposed to the instructions you write:

| Layer | Claude app | Claude Code |
|---|---|---|
| General, used in chats outside projects | Account memory | – |
| Project, used only within that project | The claude.ai project's memory | Auto memory of that repository |

When Claude should record something durable, the memory rules in
`user-instructions.md` apply: it proposes where, and shows the exact text before
writing. Claude Code has no account memory, so there the place is an instruction file:
`user-instructions.md` for general facts, the repository's `project-instructions.md`
for project facts.

Both products also record memory automatically, outside those rules. The Claude app
does so in your account. Claude Code keeps auto memory as files on the machine where
it runs, under `~/.claude/projects/<repository>/memory/`.

`/context` in Claude Code lists `CLAUDE.md` files under "Memory files"; in this README
they count as instructions.

## Known limits

- Cloud sessions lag behind `main` until their environment is rebuilt, up to about a
  week (see "After changing a file").
- Anthropic's documentation does not describe loading a `~/.claude/CLAUDE.md` written
  by a setup script. Verified on 2026-10-02; if cloud sessions stop showing the
  user instructions, repeat the check in step 5 under "Claude Code, cloud".
