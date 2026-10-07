# claude-setup

User instructions for all of tiavelum's work with Claude, kept in a single file,
`user-instructions.md`, and delivered from there to the Claude app and to Claude Code,
locally and in the cloud, together with the instruction pattern every project
repository follows and the skills that apply it. It is for tiavelum, who maintains
these instructions and deploys them to each place Claude runs.

**Keep this repository public.** Cloud sessions download from it, so nothing private
belongs here.

## Setup

Setup puts the same user instructions in front of Claude everywhere you use it.
The Claude app reads them from your account. Claude Code reads them from
`~/.claude/CLAUDE.md`, a file that has to be put in place separately on your own
machine and in each cloud environment.

Prerequisites: a Claude account. For Claude Code on your own machine also git 2 or
later, bash 3.2 or later and an SSH key added to your GitHub account; for uploading
skills zip 3.0 or later; for `session-usage.py` Python 3.9 or later.

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

Copies the instructions into your account, which applies them to all your conversations
with Claude.

1. Open **Instructions for Claude** in **Settings**
   ([help](https://support.claude.com/en/articles/10185728)) and paste the whole of
   `user-instructions.md` into that field.
2. If you use a claude.ai project for this repository, paste `project-instructions.md`
   into that project's instructions
   ([help](https://support.claude.com/en/articles/9519177-how-can-i-create-and-manage-projects)).
3. Verify: start a new chat, in that project if you use one, and send

   ```
   Quote your instruction "Usage" word for word, and the first line of your project instructions if you have any.
   ```

   The answer must match the paragraph "Usage" of `user-instructions.md` and, in the
   project, the first line of `project-instructions.md`.

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
account; usually there is just one, called "Default". The screens are described in
[Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web).

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

2. In the Claude app, open [Customize > Skills](https://claude.ai/customize/skills),
   click **+**, choose **Create skill**, then **Upload a skill**, and select the ZIP
   ([help](https://support.claude.com/en/articles/12512180-use-skills-in-claude)).

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
| `skills/` | One folder per skill, named after it and holding its `SKILL.md`; each is uploaded as in Setup, "Skills" |
| `skills/delegate-work/SKILL.md` | How Claude plans, briefs, starts and checks agents; see "Working with agents" |
| `skills/project-instructions/SKILL.md` | Guided creation and review of a repository's `project-instructions.md` |
| `skills/readme/SKILL.md` | Guided writing and review of a repository's README against the README contract of tiavelum/engineering-standards |
| `skills/hand-over-session/SKILL.md` | How Claude hands long work over to a new session; see "Handing over a session" |
| `.github/` | GitHub configuration; holds only the workflow below |
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

Merge the pull request, then:

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

¹ Replace the whole field, as in Setup, "Claude app". A session that is already
running may keep the text it started with.

² `git -C ~/vc/claude-setup pull`.

³ Open the setup script as in Setup, "Claude Code, cloud", steps 1 to 3, change the
comment line (for example the date) and save. Otherwise the change arrives when the
cached environment expires, after roughly seven days.

⁴ Package and upload as in Setup, "Skills"; the upload replaces the existing
version. Claude Code picks up the new version on its own.

To check that the copies match `main`, ask Claude in a new session to compare each
copy it received with the file on `main` by git blob hash: `git hash-object` on the
copy saved as a file, against `git rev-parse origin/main:<file>`. Equal hashes mean
the same bytes, whitespace included.

## Design

Five principles decide where things go and keep the setup from drifting:

1. **One home per kind of content.** Each kind of information has one home, given in
   "Kinds of information" below. Nothing is stated twice; a second place points to
   the first.
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
5. **References run one way.** The instruction files may name a skill, a skill may
   cite a standard, and nothing names or restates the layer above it, so a change
   in one layer never has to be found in another. A skill states the major version
   of each standard it was written for: a breaking change in the standards then
   stops it, rather than leaving it to apply rules that have moved.

### Kinds of information

| Kind | How to recognise it | Home |
|---|---|---|
| Rule for all work with Claude | Tells Claude how to behave, in any project | `user-instructions.md` |
| Rule for one project | Tells Claude how to behave in one repository only | That repository's `project-instructions.md` |
| Rule only Claude Code can follow | Needs something only Claude Code has | That repository's `CLAUDE.md`, below the import |
| Repository rule | Would also hold if the work were done by hand, without Claude | [tiavelum/engineering-standards](https://github.com/tiavelum/engineering-standards) |
| Procedure | Several steps executed by Claude, needed only for a certain task | A skill, `skills/<name>/SKILL.md` |
| Template or pattern for instruction files | The form such a file takes | The skill that creates the file |
| Explanation or operating step | Describes how to use or run a repository | That repository's `README.md` |
| Fact about you | Durable, true across projects | Account memory, kept small |
| Fact about one project | Durable, true for one project | That project's memory; in Claude Code, its `project-instructions.md` |
| Decision with its reasons, raw material | Explains why, or is the source a decision rests on | Files in a repository, not memory |
| Open work and state | Still to be done, under review, or a change note | GitHub issues, pull requests and releases |
| Distilled documentation of how Claude products work | Consulted occasionally, not needed in day-to-day work | [tiavelum/claude-mechanics](https://github.com/tiavelum/claude-mechanics) |
| Instruction for this conversation only | Ends with the task | The conversation; never filed |

The runtime copies of each source are in the layers table below.

To decide the kind of something new:

1. Does it still matter after this conversation? If not, it stays in the
   conversation.
2. Does it prescribe or describe? Prescribing makes it a rule; describing makes it
   knowledge or a fact.
3. For a rule: would it also hold if the work were done by hand, without Claude? If
   yes, it is a repository rule. If no, it is a rule for Claude, filed at the
   narrowest scope that needs it.
4. For a description: is it about you, about using a repository, about how Claude
   products work beyond what day-to-day work needs, or about work still open? That
   decides between memory, the README, claude-mechanics and an issue.

### Layers

The layers, from a session with no parent outward:

| Layer | Source | Runtime copies | Bound by |
|---|---|---|---|
| Session | `user-instructions.md` | Instructions for Claude field; `~/.claude/CLAUDE.md` locally and in the cloud | The products load it. It governs every layer below, including itself |
| Repository | `README.md` | None; read on demand | The "Reading a repository" rule |
| Repository rules | `tiavelum/engineering-standards` | None; fetched on demand | The "Repository rules" rule |
| Repository used with Claude | `project-instructions.md`, `CLAUDE.md` | Claude Code imports `project-instructions.md` at session start | The "Project repositories" rule and the `project-instructions` skill |
| claude.ai project | The same `project-instructions.md` | The project's instructions field | The paste step; the skill compares field and file |
| Skills | `skills/<skill>/SKILL.md` | Your claude.ai account | The upload step |

Memory is the other cross-cutting layer; see "Memory".

The regress of "what governs the file that governs the file" ends in
`user-instructions.md`: its "Repository rules" rule loads the standards that govern
this README, and its instruction-file rules govern itself. That fixed point is safe because of the second principle: the
version a session writes reaches other sessions only through deployment.

## Setting up a project repository

Ask Claude, in a session working in the repository, to set the repository up for
Claude. Under the rule "Project repositories" it creates a `project-instructions.md`
with the project's rules and a `CLAUDE.md` that imports it for Claude Code. Ask it
later to review them; the `project-instructions` skill defines their content, see
`skills/project-instructions/SKILL.md`.

## Working with agents

The rule "Agents" in `user-instructions.md` makes Claude follow the `delegate-work`
skill whenever it hands work to agents, and the rule "Usage" decides when it may start
them. Upload the skill as in Setup, "Skills". The roles, their models and the procedure
are in `skills/delegate-work/SKILL.md`, together with the sizes the skill starts from,
such as the context per agent and the agents at a time; correct them there after a run
shows better ones.

## Memory

Memory is what Claude records itself, as opposed to the instructions you write:

| Layer | Claude app | Claude Code |
|---|---|---|
| General, used in chats outside projects | Account memory | – |
| Project, used only within that project | The claude.ai project's memory | Auto memory of that repository |

When Claude should record something durable, the memory rules in
`user-instructions.md` apply: it proposes where, and shows the exact text before
writing. The Claude Code documentation describes no account memory, only `CLAUDE.md`
files and auto memory, so in Claude Code the place is an instruction file:
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
`hand-over-session` skill says; upload it as in Setup, "Skills". When Claude hands
over, paste the start prompt it gives you into a new session. When and how it hands
over is in `skills/hand-over-session/SKILL.md`.

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
