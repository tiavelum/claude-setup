# Fix-checker brief for tiavelum/engineering-standards

This is the part of every brief that a checker of a pull request settling screen findings of tiavelum/engineering-standards follows; the coordinating session adds the pull request, the branch, the standard, the issue the pull request is for and whether it is that issue's last, any configuration file the fixer was allowed to change, the screen report, the worker's report, the question directory, your worktree and the report path, and you follow that as well.

## Sources

Read first and follow in full `engineering-standards-checker.md`, beside this brief, except where this brief replaces it:

- Files outside the repository: you read the screen report, the worker's report and the question drafts `q-<standard>-*.md` in the question directory, and write only your report and your worktree.
- Files you change: merging `origin/main` in your worktree for item 10 is the exception to its rule on changing no file; push nothing.
- Return lines: "Report" below replaces the last paragraph of its "Report".

Read also `engineering-standards-fixer.md`, beside this brief, the issues and decisions each fix names, for item 9 every file `index.yaml` lists, and the pull request:

```bash
curl -sS https://api.github.com/repos/tiavelum/engineering-standards/pulls/<n>
```

## Items beyond the checker brief's list

These continue the list under "What every check covers" in `engineering-standards-checker.md`.

7. Each fix is covered as its description says: by a decision on an issue, by a rule of the standards, or by the rule's own reason and examples leaving one fix. A change that picks between two plausible requirements, or adds, removes or widens one no decision covers, is a finding.
8. Each fix removes the screen finding it names, on the case the screen gave.
9. No changed rule now conflicts with another rule of any file listed in `index.yaml`.
10. Where `origin/main` moved after the branch was made, merge it into your worktree and report a conflict as a finding.
11. Every new link to a page outside the repository opens at its published address (DOC-51); name each one you could not open.
12. The pull request changes no file but the standard's file, `index.yaml` and a configuration file your brief says the fixer was allowed to change, and its title and description meet "Branch and pull request" of the fixer brief.
13. For each question draft: whether a decision or rule already leaves one fix, so that it need not be asked, and whether it meets `standards/issues.md` and `standards/writing.md` as on `origin/main`. Report these under "Questions", apart from the findings on the pull request.

## Report

Save to the path your brief gives, at most 80 lines. Return only the verdict line, one line per finding, and one line per question draft that need not be asked or breaks a rule.
