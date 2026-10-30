# Worker brief for tiavelum/engineering-standards

The shared part of every brief for a worker that changes tiavelum/engineering-standards. The coordinating session adds the goal, the issues, the worktree and branch, the files and the report path; follow this part as well.

## Sources

- Read in full, from your worktree: `README.md`, `project-instructions.md`, `index.yaml`, `meta/rule-format.md`, `meta/consuming.md`, `meta/precedence.md`, every standard you change, every standard its `index.yaml` entry names in `requires`, and `standards/writing.md`.
- Read each issue your brief names, with all its comments, through the public API:

  ```bash
  curl -sS https://api.github.com/repos/tiavelum/engineering-standards/issues/<n>
  ```

  ```bash
  curl -sS "https://api.github.com/repos/tiavelum/engineering-standards/issues/<n>/comments?per_page=100"
  ```

- docs.github.com is blocked in the container. Read a page of GitHub's documentation from its source, `https://raw.githubusercontent.com/github/docs/main/content/<path>.md` (or `<path>/index.md`), for `https://docs.github.com/en/<path>`, and link the docs.github.com address.
- Read every source yourself and in full, never a summary of it, and rely on no file an earlier agent left outside the repository.

## The change

- Write into a rule only what a decision on an issue already covers. Where a decision leaves a point open, leave it out and list it in the report as an open question, with options, their consequences and your recommendation.
- Every file you change follows every file in `index.yaml` as your branch leaves it (RF-45), RF-13 to RF-16, RF-39, RF-41, RF-42, RF-25 and WR-8, WR-9 among them.
- Set each version under RF-18 and RF-19: the front matter and the `index.yaml` entry in the same commit, and `updated:` in `index.yaml` set to the day's date.
- Try each new or changed rule on a real example, read as someone who did not write it. If it reads two ways, rewrite it once; if it still does, leave it out and list it as open.
- If `origin/main` moved, merge it into your branch and resolve the conflicts; `updated:` takes the later date.

## Checks before every push

```bash
pip install -q -r requirements.txt
```

```bash
ruff format --check .
```

```bash
ruff check .
```

```bash
python3 scripts/validate-standards.py
```

The last prints `All checks passed. 0 warning(s).`

## Commits

- Author each commit as `Andreas Tiefenauer <tiavelum@gmail.com>` with `git commit --author=...` and leave the committer as configured.
- The first line reads `<type>: <summary>` (GW-6, GW-7) in at most 65 characters (WR-5); the body states what and why for a reader who was not there (WR-2) and no process (GW-25).
- End each message with the `Co-Authored-By` and `Claude-Session` lines the coordinating session gives.
- Commit and push after each finished part, and keep a part under about 30 minutes of work.

## Limits

- Work only in the worktree and on the branch your brief names; check out nothing in another worktree or clone.
- Open, edit, comment on, label and merge no pull request or issue, and touch no other repository.
- Work in few large steps: fetch the sources of one part together, search saved copies instead of reading a source again, and write a whole section in one edit.

## Report

Save the full report to the path your brief gives, in at most 120 lines and with no local path in the proposed description:

1. each change, with its file, its rule id and the final text of every new or changed rule;
2. the decision that covers each;
3. the versions, with the reason under RF-18;
4. the open questions, each with options, consequences and a recommendation;
5. the output of the checks;
6. a complete pull request description: what and why, the versions, the checks, a `Closes #<n>` line for each issue, `Part of #124`, references written as WR-7 on `main` asks.

Return only five lines: the last commit hash, the result of the checks, the versions, the number of open questions, and anything else the coordinating session must act on.
