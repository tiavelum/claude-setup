# Fixer brief for tiavelum/engineering-standards

This is the part of every brief that a worker settling the screen findings of one standard of tiavelum/engineering-standards follows; the coordinating session adds the standard, the screen report, the issue the work is for, the worktree and branch, the ledger, the question directory and the report path, and you follow that as well.

## Sources

Read first and follow in full `engineering-standards-worker.md`, beside this brief, and the screen report.

## Sort each finding

Verify each finding yourself against the files, then sort it:

- **Fix**: a decision on an issue, a rule of the standards (such as RF-42, RF-25, RF-14, RF-16, RF-39, RF-43, WR-8, WR-9), or the rule's own reason and examples leave exactly one fix. Examples: a restatement removed in favour of a citation, a missing `requires` entry, a missing link, an example that contradicts its own rule, a reason that states something false, a broken identifier, wording that reads two ways where the reason and examples already show which way is meant. Apply it.
- **Question**: the fix needs a choice between two requirements a reader could reasonably intend, or adds, removes or widens a requirement no decision covers. Do not change the file; draft a decision issue.
- **No finding**: the finding does not hold when you check it. Say why in the report.

Change only your standard's file and `index.yaml`. A fix that needs another file changed is a question for that file's piece: list it under "For other pieces" and leave it. Read the ledger first: a finding a ledger line names as held elsewhere is not yours. Append one line per finding you fix or draft, `<finding id>: fixed on <branch>` or `<finding id>: question <draft file>`, with a single shell append at the end.

Where an open `tiavelum-decides` issue already asks about a finding, draft no new question; name the issue in the report.

## Question drafts

Group findings that one decision settles into one draft. Save each to the question directory your brief gives, as `q-<standard>-<n>.md`, first line `Title: <title>`, then the body. Each draft follows `standards/issues.md` and `standards/writing.md` as on `origin/main` when you write it, numbers its options in the table and names the recommended option with its reason. At most 60 lines per draft.

## Branch and pull request

Your branch starts from `origin/main`; merge `origin/main` again before your last push if it moved. The proposed pull request title is `fix: settle the screen findings of <standard>` or shorter. The description follows WR-10 and WR-11 as on `origin/main`, lists each fix with its rule id and the decision or rule that covers it, the versions under RF-18, the checks, and the questions left for decision by topic, and ends with a `Part of #<n>` line for the issue your brief names and one for the tracking issue.

## Report

Save to the path your brief gives, at most 120 lines: per finding its sort (fix, question, no finding, held elsewhere) with the final text of every changed rule; versions; checks; "For other pieces"; the proposed pull request title and description. Return only five lines: the last commit hash, the checks, the versions, the counts of fixes, questions and dropped findings, and anything the coordinating session must act on.
