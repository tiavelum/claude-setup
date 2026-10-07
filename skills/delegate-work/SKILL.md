---
name: delegate-work
description: Plan, brief, start and check agents for work larger than one conversation can hold. Use before handing any work to agents, while they run, and after the run to post its effort map.
---

# Delegate work

Follow these steps whenever you hand work to agents. The numbers are starting values; where the tracking issue names others for the task, use those.

## Roles

- You coordinate: plan, split the work, start every agent yourself, run the repository's checks and handle the pull requests. Judge no content yourself; change a passage only by applying a checker's complete replacement.
- A worker makes one piece.
- A checker checks work it did not see being made, and changes nothing. Fit the check to the work: read against the source, run the tests, reproduce a result, or review against a specification.

## Before the start

1. Split the work as "Pieces" says.
2. Estimate for each agent its steps and the context it will reach, and its tokens as steps times average context. Take the figures from the effort map of the last comparable run where the tracking issue has one.
3. Give me the estimate with the number of agents and their models.
4. Put the plan into the tracking issue: the pieces, their branches, the agents and the amount.

## Pieces

- Size each piece so that one agent finishes it within at most about 300,000 tokens of context.
- Make a piece one pull request of about 400 changed lines where the work allows it.
- Give each piece its own branch, and its own git worktree when agents work side by side.
- Where two pieces could hold the same thing, state in both briefs which one holds it, and give the later worker the earlier piece to read.

## Briefs

Write each brief so that an agent that starts without context can work from it alone. Give it these parts:

1. Goal: what the piece is and what it is for.
2. Inputs: what to read, with paths or addresses, and what to read first.
3. Files: the files it may touch, and that it touches no others.
4. Definition of done: every rule the checker will apply, and each check that must pass before a push, as a command to run.
5. Checkpoints: commit and push after each finished part, and keep a part to at most about 30 minutes of work.
6. Report: the file to save the full report to, its parts and a length limit, and the few lines to return.
7. Limits: what it must not do, such as opening pull requests or issues, or touching another repository.

Tell every agent also:

- Read every source yourself and in full, never a summary of it, and do not rely on files an earlier agent left outside the repository.
- Work in few large steps: fetch the sources of one part together, search saved copies instead of reading a source again, and write a whole section in one edit, since every step re-reads the whole context.
- Where agents share a browser, open your own tab, pass its id to every call and close it when done.

Tell a checker in addition:

- You have not seen how the work was made; take nothing in it on trust, change no file, and report only what you checked yourself.
- Start the report with a verdict: how many items you checked, how many hold, how many have a finding and how many could not be checked.
- For each finding give the passage, what the source says, and the smallest change that makes it right, as a complete replacement where you can.

Split a large piece between several checkers so that each part stays within the context limit above.

## While agents run

- Start workers on Opus and checkers on Sonnet.
- Run at most four agents at a time, and never more work in flight than you can afford to lose.
- Let nothing be pushed that has not passed the checks the brief gives as commands.
- Have each agent return a few lines and save its full report to a file. Read the few lines, not the whole report.
- Before a report goes into a pull request, scan it for secrets, local paths and text copied from a source.
- Put the worker's report into the pull request's description and the checker's findings into review comments on it.
- A checker and the worker whose work it checks exchange nothing but the work and the findings, in writing. Workers learn from each other through what is pushed; connect two workers directly only for a named question.
- End your turn after each finished piece, so that a turn ending at a usage limit loses nothing that was not pushed.
- When a usage or spend limit is reported, stop and continue after the reset.

## Corrections

1. Give the findings to a fresh worker together with the passages concerned. It applies each finding unless a source it reads again decides against it, and reports the final text of every passage it changed.
2. Have every changed passage checked again by a checker.
3. Where worker and checker still disagree and no source settles it, leave the point out and open an issue for it.

## After the run

1. Print the effort map: run `session-usage.py` from tiavelum/claude-setup in the coordinating session, from the local clone or fetched from `main`:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/tiavelum/claude-setup/main/session-usage.py -o /tmp/session-usage.py
   python3 /tmp/session-usage.py
   ```

2. Post its token figures on the tracking issue, with the number of agents, their models and the estimate you gave.
3. Post on the tracking issue what became of each piece: merged with its pull request, left out with the reason, or open with its issue.
