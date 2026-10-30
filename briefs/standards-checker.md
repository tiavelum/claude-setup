# Checker brief for tiavelum/engineering-standards

The shared part of every brief for a checker of a change to tiavelum/engineering-standards. The coordinating session adds the branch, the commits or passages to check, the issues and decisions, the items to check and the report path; follow this part as well.

## Stance

- You have not seen how the work was made. Take nothing in it on trust, change no file except your report, and report only what you checked yourself.
- Read every source yourself and in full, never a summary of it.

## Setup

Check out nothing in an existing clone or worktree. Read with `git show` and `git diff`, and run anything in a worktree of your own that you remove at the end:

```bash
git -C /home/user/engineering-standards fetch -q origin
```

```bash
git -C /home/user/engineering-standards worktree add --detach /home/user/wt/check-<name> origin/<branch>
```

```bash
git -C /home/user/engineering-standards worktree remove --force /home/user/wt/check-<name>
```

Read issues and their comments through the public API (`https://api.github.com/repos/tiavelum/engineering-standards/issues/<n>` and `.../comments?per_page=100`), and GitHub's documentation from its source on raw.githubusercontent.com/github/docs, since docs.github.com is blocked in the container.

## What every check covers

1. Each decision the brief names is carried out as decided, and nothing is written into a rule that no decision covers.
2. Each new or changed rule meets RF-13 to RF-16, RF-39, RF-41 and RF-42, and reads one way when tried on a real example.
3. Every outside fact is linked where it is stated and every link supports a fact (WR-8, WR-9); open the page or its source.
4. The versions are right under RF-18 against `origin/main`, each front matter equals its `index.yaml` entry (RF-30) and `requires` matches the citations (RF-25).
5. In your worktree, these pass:

   ```bash
   pip install -q -r requirements.txt && ruff format --check . && ruff check . && python3 scripts/validate-standards.py
   ```

## Report

Save the report to the path your brief gives, within the length it sets and with no local path. Start with a verdict: how many items you checked, how many hold, how many have a finding and how many you could not check. For each finding give the passage with its file and rule id, what the source says, the smallest change that makes it right as a complete replacement, and whether a decision on an issue covers that change.

Return only the verdict line and one line per finding, or "no findings".
