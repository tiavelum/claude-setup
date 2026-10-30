# Fix-checker brief for tiavelum/engineering-standards

This is the part of every brief that a checker of a pull request settling screen findings of tiavelum/engineering-standards follows; the coordinating session adds the pull request, the branch, the standard, the screen report, the worker's report, the question directory, your worktree and the report path, and you follow that as well.

## Sources

Read first and follow in full `engineering-standards-checker.md`, beside this brief. Read the screen report, the worker's report, the question drafts `q-<standard>-*.md` in the question directory, the pull request (`curl -sS https://api.github.com/repos/tiavelum/engineering-standards/pulls/<n>`) and the issues and decisions each fix names.

## Items beyond the shared list

1. Each fix is covered as its description says: by a decision on an issue, by a rule of the standards, or by the rule's own reason and examples leaving one fix. A change that picks between two plausible requirements, or adds, removes or widens one no decision covers, is a finding.
2. Each fix removes the screen finding it names, on the case the screen gave.
3. No changed rule now conflicts with another rule of any file listed in `index.yaml`.
4. Where `origin/main` moved after the branch was made, merge it into your worktree and report a conflict as a finding.
5. Every new link to a page outside the repository opens at its published address (DOC-51); name each one you could not open.
6. For each question draft: whether a decision or rule already leaves one fix, so that it need not be asked, and whether it meets `standards/issues.md` and `standards/writing.md` as on `origin/main`. Report these under "Questions", apart from the findings on the pull request.

## Report

Save to the path your brief gives, at most 80 lines. Return only the verdict line, one line per finding, and one line per question draft that need not be asked or breaks a rule.
