# Worker brief for tiavelum/engineering-standards

This is the part of every brief that a worker changing tiavelum/engineering-standards follows; the coordinating session adds the goal, the issues, the worktree and branch, the files and the report path, and you follow that as well.

## Sources

- Read in full, from your worktree: `README.md`, `project-instructions.md`, `index.yaml`, `meta/rule-format.md`, `meta/consuming.md`, `meta/precedence.md`, every standard you change, every standard its `index.yaml` entry names in `requires`, and `standards/writing.md`.
- Read each issue your brief names, with all its comments, through the public API:

  ```bash
  curl -sS https://api.github.com/repos/tiavelum/engineering-standards/issues/<n>
  ```

  ```bash
  curl -sS "https://api.github.com/repos/tiavelum/engineering-standards/issues/<n>/comments?per_page=100"
  ```

- Where docs.github.com is blocked, read a page of GitHub's documentation from its source, `https://raw.githubusercontent.com/github/docs/main/content/<path>.md` (or `<path>/index.md`), for `https://docs.github.com/en/<path>`, and link the docs.github.com address.
- Read every source yourself and in full, never a summary of it, and rely on no file an earlier agent left outside the repository.

## The change

- Follow "Open decisions" and "Testing a rule" in `project-instructions.md`; list each point you leave out in the report as an open question, with options, their consequences and your recommendation.
- Every file you change follows the standards that apply to this work under `index.yaml` (CO-2, CO-3), and follows each listed file you also change as your branch leaves it (RF-45); your commit messages, branch name and pull request text follow each such file as it is on `origin/main` (RF-46). Among them, RF-13 to RF-16, RF-39, RF-41 and RF-42 apply to every rule you write, and RF-25, WR-8 and WR-9 to every file you change.
- Set each version under RF-18 and RF-19: the front matter and the `index.yaml` entry in the same commit.
- If `origin/main` moved since you started, fetch it and merge it into your branch so that tiavelum stays the author of the merge commit: start the merge without committing, resolve the conflicts, then commit it with the first line, body and trailer lines "Commits" asks for, given with `-m` since no editor opens.

  ```bash
  git fetch -q origin && git merge --no-ff --no-commit origin/main
  ```

  ```bash
  git commit --author="Andreas Tiefenauer <tiavelum@gmail.com>" -m "<type>: <summary>" -m "<body>" -m "<trailer lines>"
  ```

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

- Make tiavelum the author of each commit, under the real name and address the author field takes, and leave the committer as configured:

  ```bash
  git commit --author="Andreas Tiefenauer <tiavelum@gmail.com>" -m "<type>: <summary>" -m "<body>" -m "<trailer lines>"
  ```

- The first line reads `<type>: <summary>`, the form GW-6 and GW-7 set for a pull request's title, within the length WR-5 sets; the body states what and why for a reader who was not there and no process, as WR-2 and GW-25 ask of a pull request description.
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
6. a complete pull request description: what and why, the versions, the checks, a `Closes #<n>` line for the issue, a `Part of #<n>` line for the tracking issue where your brief names one, references written as WR-7 on `main` asks, and laid out as WR-10, WR-11 and WR-12 on `main` ask, with the `Closes` and `Part of` lines in its top part.

Return only five lines: the last commit hash, the result of the checks, the versions, the number of open questions, and anything else the coordinating session must act on.
