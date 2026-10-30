# Checker brief for tiavelum/engineering-standards

This is the part of every brief that a checker of a change to tiavelum/engineering-standards follows; the coordinating session adds the branch, the commits or passages to check, the issues and decisions, the items to check and the report path, and you follow that as well.

## Stance

- You have not seen how the work was made. Take nothing in it on trust, change no file of the repository, create no file except your report and your own worktree below, and report only what you checked yourself.
- Read every source yourself and in full, never a summary of it.

## Setup

Check out nothing in an existing clone or worktree. Below, `<clone>` is the clone of tiavelum/engineering-standards your brief names. Fetch first:

```bash
git -C <clone> fetch -q origin
```

Read a file of the branch, and the branch's changes against `main`, without checking anything out:

```bash
git -C <clone> show origin/<branch>:<path>
```

```bash
git -C <clone> diff origin/main...origin/<branch>
```

Run anything in a worktree of your own, at a path `<worktree>` outside every clone, and remove it at the end:

```bash
git -C <clone> worktree add --detach <worktree> origin/<branch>
```

```bash
git -C <clone> worktree remove --force <worktree>
```

Read issues and their comments through the public API (`https://api.github.com/repos/tiavelum/engineering-standards/issues/<n>` and `.../comments?per_page=100`). Where docs.github.com is blocked, read GitHub's documentation from its source on raw.githubusercontent.com/github/docs.

## What every check covers

1. Each decision the brief names is carried out as decided, and nothing is written into a rule that no decision covers.
2. Each new or changed rule meets RF-13 to RF-16, RF-39, RF-41 and RF-42, and reads one way when tried on a real example.
3. Every outside fact is linked where it is stated and every link supports a fact (WR-8, WR-9); open the page or its source.
4. The versions are right under RF-18 against `origin/main`, each front matter id, title and version equals its `index.yaml` entry (RF-30) and `requires` names every standard the file cites (RF-25).
5. In your worktree, these pass:

   ```bash
   pip install -q -r requirements.txt && ruff format --check . && ruff check . && python3 scripts/validate-standards.py
   ```

6. Each commit and the proposed pull request description meet the rules that `engineering-standards-worker.md`, beside this brief, names for them (RF-19, RF-45, RF-46, GW-6, GW-7, GW-25, WR-2, WR-5, WR-7), and each commit, a merge commit included, has the author its "Commits" names.

## Report

Save the report to the path your brief gives, within the length it sets and with no local path. Start with a verdict: how many items you checked, how many hold, how many have a finding and how many you could not check. For each finding give the passage with its file and rule id, what the source says, the smallest change that makes it right as a complete replacement, and whether a decision on an issue covers that change.

Return only the verdict line and one line per finding, or "no findings".
