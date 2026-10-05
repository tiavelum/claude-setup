---
name: project-instructions
description: Create or review a repository's project-instructions.md and CLAUDE.md. Use when setting up a repository for Claude, or when asked to write, check, improve or migrate a project's instructions.
---

# Project instructions

If the repository has no project-instructions.md, follow "Create a new file". If it has one, follow "Review an existing file". Apply the INSTRUCTION FILES rules of the user instructions throughout.

## Anatomy

project-instructions.md has three parts, in this order:

1. Anchor: "Repository tiavelum/<name>."
2. Purpose: one or two sentences on what the project is for.
3. Rules: invariants, done criteria, approval steps beyond the user instructions, and constraints that protect data.

CLAUDE.md follows this template:

```markdown
@project-instructions.md

## Claude Code only

- Build: ...
- Test: ...
```

Target layout: project-instructions.md and CLAUDE.md at the repository root, and no other file that holds instructions or a project description for Claude. Treat any other layout as older and migrate it.

For a done criterion that runs a command, use this pattern: "Run X. If you cannot run it, wait for the CI run of your commit and report its result." Drop the second sentence if the repository has no CI.

## Create a new file

1. Read the repository's README and list its top-level files. If there is no README, say so before drafting.
2. Ask in one round only what the repository cannot answer: the project's purpose, what Claude has got wrong or must never do, when a change counts as done, and what data must stay private.
3. Draft both files following the anatomy.
4. Run the checks below on the draft.
5. Show both files in full and commit only after approval.
6. After the commit, give the follow-up below.

## Review an existing file

1. Read project-instructions.md, CLAUDE.md and the README from the target branch, plus any file an older layout uses for instructions or a description. If this session runs in a claude.ai project, compare its instructions field with the file.
2. Run the checks below and report each finding with a proposed fix, most important first. Do not draft yet.
3. Wait for my decision on each finding. Removing a rule that repeats a user instruction word for word or in substance counts as decided; list it without asking.
4. Draft the changes I accepted. When migrating an older layout, fold any description file into the purpose and delete it, move the instructions file to the repository root, remove headers and copy markers, update the CLAUDE.md imports, and update every reference to moved or deleted files, including the README's file table and wording.
5. Show every changed file in full, or as a diff where a long file has a small change, and list every deleted file. Commit only after approval.
6. After the commit, give the follow-up below.

## Checks

- The anchor is complete and the purpose is at most two sentences.
- No rule repeats a user instruction. Also flag a rule that covers the same ground as a user instruction more strictly; keep it only if the project needs the stricter version.
- No rule restates the README, and no content the repository already holds, such as file lists, structure or procedures; point to it instead.
- Each rule is checkable. A reason is at most one clause and only where the purpose is not self-evident.
- Each rule works in both the Claude app and Claude Code. A rule only Claude Code can use goes into CLAUDE.md instead.
- No contradictions with the README or the user instructions.
- No notes about the file itself, no capitals or "CRITICAL" for emphasis, and no first name except where it is part of a repository name or path.
- The file fits on one screen. If it does not, name what could move to the README or a skill.
- The claude.ai instructions field matches the file.

## Follow-up

After a commit, tell me to:

1. Paste the whole of project-instructions.md into the claude.ai project's instructions field, and create the project if it does not exist.
2. Clear the project's description field, or reduce it to a few words.
3. Pull the local clone before the next Claude Code session, if the commit was made outside it.

Then name any memory entries in this project that describe the old layout or a removed rule, and propose their updated text.
