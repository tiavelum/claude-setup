---
name: hand-over-session
description: Hand work that spans several pull requests over to a new session. Use at the end of a phase of the work, when the conversation has passed about 600,000 tokens of context, or when asked to hand over.
---

# Hand over a session

## When

- Hand over at the end of a phase of the work, or once the context has passed about 600,000 tokens, whichever comes first.
- Measure the context where the session has records: run `session-usage.py` from tiavelum/claude-setup, from the local clone or fetched from `main`, and read "last context" of the session row.

  ```bash
  curl -fsSL https://raw.githubusercontent.com/tiavelum/claude-setup/main/session-usage.py -o /tmp/session-usage.py
  python3 /tmp/session-usage.py
  ```

- Where the session has no records, hand over at the end of the phase.
- Measure after each merged pull request and at the end of each phase, not in the middle of a step.

## What

1. Push everything that is finished, so that nothing of the task exists only in this session or its workspace.
2. Bring the tracking issue up to date: what is done, with its pull requests; what is open; the decisions taken, with their reasons; the next step.
3. Put a procedure the next session needs into a brief in the repository the work concerns, through a pull request, and link it from the tracking issue. Keep procedures out of the issue.
4. Post this session's token figures from `session-usage.py` on the tracking issue.

## The start prompt

Give me a prompt of a few lines for the new session, in a code block so that I can copy it. It names:

- the tracking issue, as the handover to read first;
- what I allowed for this work: merging or not, the models, and the amount with how much of it is left;
- when to stop and ask.

## After it

Do no further work on the task in this session.
