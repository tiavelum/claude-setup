# Fixer brief for tiavelum/engineering-standards

This is the part of every brief that a worker settling the screen findings of one standard of tiavelum/engineering-standards follows; the coordinating session adds the standard, the screen report, the issue the work is for and whether yours is its last pull request, the tracking issue, the worktree and branch, the ledger, the question directory and the report path, and you follow that as well.

## Sources

Read first and follow in full `engineering-standards-worker.md`, beside this brief, except where this brief replaces it:

- Files outside the repository: you read the screen report, the ledger and the question directory, and write your question drafts, your ledger lines and your report; these are the exceptions to its rules on files an earlier agent left outside the repository and on working only in your worktree.
- Files you change: "Sort each finding" names them, in place of a list of files in your brief.
- Pull request text: "Branch and pull request" replaces item 6 of its "Report".
- Report and return lines: "Report" replaces its "Report".

Read the screen report and, for each finding, every file it names; read the ledger; and list the open questions already put to tiavelum:

```bash
curl -sS "https://api.github.com/repos/tiavelum/engineering-standards/issues?state=open&labels=tiavelum-decides&per_page=100"
```

## Sort each finding

Verify each finding yourself against the files, then give it one of these four sorts, by these names in the report, the ledger and the return lines:

- **Fix**: a decision on an issue, a rule of the standards (such as RF-42, RF-25, RF-14, RF-16, RF-39, RF-43, WR-8, WR-9), or the rule's own reason and examples leave exactly one fix. Examples: a restatement removed in favour of a citation, a missing `requires` entry, a missing link, an example that contradicts its own rule, a reason that states something false, a broken identifier, wording that reads two ways where the reason and examples already show which way is meant. Apply it.
- **Question**: the fix needs a choice between two requirements a reader could reasonably intend, or adds, removes or widens a requirement no decision covers. Do not change the file; draft a decision issue.
- **No finding**: the finding does not hold when you check it. Say why in the report.
- **Held elsewhere**: a ledger line names the finding by its id, an open `tiavelum-decides` issue already asks about it, or its fix needs a file you may not change. Leave it and name in the report the ledger line, the issue or the piece that holds that file; list a finding that needs such a file under "For other pieces", with the change it needs.

Change only your standard's file and `index.yaml`, and a configuration file of the repository only where a fix needs it and your brief allows it.

After your last push, append one line per finding to the ledger in one command, each in one of the forms `<finding id>: fix <branch>`, `<finding id>: question <draft file>`, `<finding id>: no finding` and `<finding id>: held elsewhere <ledger finding id, #<issue> or piece>`:

```bash
printf '%s\n' '<line>' '<line>' >> <ledger>
```

## Question drafts

Group findings that one decision settles into one draft. Save each to the question directory your brief gives, as `q-<standard>-<n>.md`, first line `Title: <title>`, then the body. Each draft follows `standards/issues.md` and `standards/writing.md` as on `origin/main` when you write it, numbers its options in the table and names the recommended option with its reason. At most 60 lines per draft.

## Branch and pull request

Your branch starts from `origin/main`; before your last push, if `origin/main` moved, merge it as "The change" of the worker brief says. The proposed pull request title is `fix: settle the screen findings of <standard>`. The description follows WR-2, WR-7, WR-10, WR-11 and GW-25 as on `origin/main` and names no local path; it lists each fix with its rule id and the decision or rule that covers it, the versions under RF-18, the checks, and the questions left for decision by topic; and it ends with a `Part of #<issue>` line for the issue your brief names, or a `Closes #<issue>` line where your brief says yours is the last pull request of that issue, and a `Part of #<tracking issue>` line.

## Report

Save to the path your brief gives, at most 120 lines: per finding its sort, with the final text of every changed rule, the draft file or what holds it elsewhere; the versions; the checks; "For other pieces"; the proposed pull request title and description. Return only five lines: the last commit hash, the checks, the versions, the number of findings of each sort, and anything the coordinating session must act on.
