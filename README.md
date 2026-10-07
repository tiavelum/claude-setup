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

Prerequisites: a Claude account. For Claude Code on your own machine also git 2 or
later and bash 3.2 or later; for `session-usage.py` Python 3.9 or later.

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
apply from the next session. Also sets `attribution.commit` to `false` in
`~/.claude/settings.json`, so Claude Code adds no co-author line to commits; other
keys in that file stay as they are, and a changed file is kept as a backup.

1. Clone the repository and run the setup script:

   ```bash
   git clone git@github.com:tiavelum/claude-setup.git ~/vc/claude-setup
   bash ~/vc/claude-setup/setup-local.sh
   ```

   On a second run the script reports `Already linked` and `Already set`.

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
| `user-instructions.md` | User instructions for all work, everywhere. The master. Project rules and repository rules never go here |
| `setup-local.sh` | Links `~/.claude/CLAUDE.md` to `user-instructions.md` on your own machine and turns off the co-author line in `~/.claude/settings.json` |
| `setup-cloud.sh` | Writes `user-instructions.md` to `~/.claude/CLAUDE.md` in a cloud VM |
| `session-usage.py` | Prints a session's steps and tokens, per session and agent; see "Session usage" |
| `project-instructions.md` | Rules for working on this repository; master of this claude.ai project's instructions field |
| `CLAUDE.md` | Imports `project-instructions.md`, then rules for Claude Code only |
| `skills/delegate-work/SKILL.md` | How Claude plans, briefs, starts and checks agents; see "Working with agents" |
| `skills/project-instructions/SKILL.md` | Guided creation and review of a repository's `project-instructions.md` |
| `skills/readme/SKILL.md` | Guided writing and review of a repository's README against the README contract of tiavelum/engineering-standards |
| `skills/hand-over-session/SKILL.md` | How Claude hands long work over to a new session; see "Handing over a session" |
| `.github/workflows/check-scripts.yml` | Checks the setup scripts with shfmt and shellcheck, and `session-usage.py` with ruff and a sample run, on every pull request |
| `.editorconfig`, `.shellcheckrc`, `ruff.toml` | The formatting and lint rules that check applies |

Start here: `user-instructions.md`, then "Setup" above for the place you use Claude.

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
| `session-usage.py` | – | Pull² | – |
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

## Design

Four principles decide where things go and keep the setup from drifting:

1. **One home per kind of content.** Behaviour rules live in an instruction file at
   the narrowest scope that needs them, procedures in skills, explanations and
   operating steps in the repository's README, durable facts about you in memory.
   Rules that hold for any repository, whoever works in it, live in
   [tiavelum/engineering-standards](https://github.com/tiavelum/engineering-standards).
   Nothing is stated twice; a second place points to the first.
2. **Source and runtime are distinct.** Every instruction artefact has one source in
   git and runtime copies that are snapshots of it: the Instructions for Claude
   field, `~/.claude/CLAUDE.md`, a project's instructions field, an uploaded skill.
   A session starts from the snapshots, and a change travels from the source through
   the steps in "After changing a file" to the next session. This is why a session
   can edit `user-instructions.md` under the user instructions without a cycle: the
   new version is written under the old one and reaches other sessions only through
   deployment.
3. **Instructions are loaded; knowledge is read.** Instruction files arrive at
   session start through each product's own mechanism, so they need deployment
   steps rather than a reading rule. Knowledge, above all a repository's README, is
   read on demand, so `user-instructions.md` says when to read it and when to read
   it again. The repository rules are fetched on demand in the same way.
4. **Scopes nest by addition.** User instructions, then project instructions, then
   `CLAUDE.md` for Claude Code only. A narrower scope adds what the wider one cannot
   know and never repeats it.

The layers, from a session with no parent outward:

| Layer | Source | Runtime copies | Bound by |
|---|---|---|---|
| Session | `user-instructions.md` | Instructions for Claude field; `~/.claude/CLAUDE.md` locally and in the cloud | The products load it. It governs every layer below, including itself |
| Repository | `README.md` | None; read on demand | The "Reading a repository" rule |
| Repository rules | `tiavelum/engineering-standards` | None; fetched on demand | The "Repository rules" rule |
| Repository used with Claude | `project-instructions.md`, `CLAUDE.md` | Claude Code imports `project-instructions.md` at session start | The "Project repositories" rule and the `project-instructions` skill |
| claude.ai project | The same `project-instructions.md` | The project's instructions field | The paste step; the skill compares field and file |
| Skills | `skills/<skill>/SKILL.md` | Your claude.ai account | The upload step |

Memory is the other cross-cutting layer; see "Memory" below.

The regress of "what governs the file that governs the file" ends in
`user-instructions.md`: its "Repository rules" rule loads the standards that govern
this README, and its instruction-file rules govern itself. That fixed point is safe because of the second principle: the
version a session writes reaches other sessions only through deployment.

## Setting up a project repository

Every repository used with Claude gets a `project-instructions.md` with the project's
rules and a `CLAUDE.md` that imports it for Claude Code. The `project-instructions`
skill creates and reviews both files and defines their content; see
`skills/project-instructions/SKILL.md`. Claude reads the project's instructions
field, not its description.

## Working with agents

The rule "Agents" in `user-instructions.md` makes Claude follow the `delegate-work`
skill whenever it hands work to agents, so the skill has to be uploaded as in Setup,
"Skills". In that procedure one session coordinates: it splits the work into pieces,
starts every agent and handles the pull requests, and judges no content itself.
Workers make the pieces on Opus; checkers, on Sonnet, check work they did not see
being made. Before the start Claude names the agents, their models and the expected
usage and asks for the amount to stop at; after the run it posts the effort map from
`session-usage.py` on the tracking issue. The skill holds the sizes it starts from,
such as the context per agent and the agents at a time; correct them there after a
run shows better ones.

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

## Handing over a session

The rule "Long work" in `user-instructions.md` keeps the plan and state of work that
spans several pull requests in a tracking issue, and makes Claude hand over as the
`hand-over-session` skill says; upload it as in Setup, "Skills". At the end of a phase,
or once the conversation has grown to the context the skill names, Claude brings the
tracking issue up to date, posts the session's token figures, and gives you a start
prompt of a few lines. Paste it into a new session; the old one does no further work on
the task.

## Session usage

`session-usage.py` reads the records Claude Code keeps of each session under
`~/.claude/projects/` and prints, per session and per agent, the number of steps, the
tokens by kind and the size of the context at the last step. Each step re-reads the
whole context, so "cache read" grows with steps times context and is usually the
largest figure. Run it on the machine where the session runs: a cloud session's records
exist only in its VM. Where no clone of this repository is at hand, fetch the script
from `main`:

```bash
curl -fsSL https://raw.githubusercontent.com/tiavelum/claude-setup/main/session-usage.py -o /tmp/session-usage.py
python3 /tmp/session-usage.py
```

Without arguments it reads the newest session. Pass session files or project folders
to read others, `--json` for machine-readable output, and `--prices <file>` to add a
cost column. The price file maps a model id to dollars per million tokens for `input`,
`cache_read`, `cache_write_5m`, `cache_write_1h` and `output`; the script holds no
prices of its own.

```
Session dc5dc589-3731-57c9-ae3a-97b436e09649
         steps  input  cache read  cache write  output  last context
session     68    136  17,792,220      192,102  49,335       326,749
total       68    136  17,792,220      192,102  49,335
Models by steps: claude-opus-5-5 (68)
```

Each agent of the session adds a row named after its record file. The record format
is not documented; the script reads the `usage` of each request once.

## Known limits

- Cloud sessions lag behind `main` until their environment is rebuilt, up to about a
  week (see "After changing a file").
- Anthropic's documentation does not describe loading a `~/.claude/CLAUDE.md` written
  by a setup script. Verified on 2026-10-02; if cloud sessions stop showing the
  user instructions, repeat the check in step 5 under "Claude Code, cloud".
- In the Claude app and in Claude Code in the cloud, only the "Commit identity" rule
  of `user-instructions.md` keeps the co-author line out of commits. The documentation
  says cloud sessions do not read `~/.claude/settings.json`, and the cloud setup leaves
  it alone, since `attribution.commit` set to `false` might also drop the line that
  links the session.

## License

MIT. See [LICENSE](LICENSE).
