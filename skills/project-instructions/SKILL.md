---
name: project-instructions
description: Create or review a repository's project-instructions.md and CLAUDE.md. Use when setting up a repository for Claude, or when asked to write, check, improve or migrate a project's instructions.
---

# Project instructions

Apply the INSTRUCTION FILES rules of the user instructions throughout.

## Anatomy

project-instructions.md has three parts, in this order:

1. Anchor: "Repository tiavelum/<name>, local clone ~/vc/<name>. Read README.md before working in it and follow it."
2. Purpose: one or two sentences on what the project is for.
3. Rules: invariants, done criteria, approval steps beyond the user instructions, and constraints that protect data.

CLAUDE.md starts with the line `@project-instructions.md`. Add below it only what Claude Code alone can use.

## Create

1. Read the repository's README and list its top-level files. If there is no README, say so before drafting.
2. Ask in one round only what the repository cannot answer: the project's purpose, what Claude has got wrong or must never do, when a change counts as done, and what data must stay private.
3. Draft both files following the anatomy.
4. Run the checks below on the draft.
5. Show both files in full and commit only after approval.
6. After the commit, tell me to paste the whole of project-instructions.md into the claude.ai project's instructions field, and to create the project if it does not exist.

## Review

1. Read project-instructions.md, CLAUDE.md and the README from the target branch. If this session runs in a claude.ai project, compare its instructions field with the file.
2. Run the checks below and report each finding with a proposed fix, most important first.
3. Migrate older layouts: fold project-description.md into the purpose and delete it, move claude/project-instructions.md to the repository root, remove headers and copy markers, and update the CLAUDE.md imports.
4. Show the revised file in full and commit only after approval.
5. After the commit, give the same paste reminder as in Create.

## Checks

- The anchor is complete and the purpose is at most two sentences.
- No rule repeats the user instructions or restates the README.
- No content the repository already holds, such as file lists, structure or procedures; point to it instead.
- Each rule is checkable. A reason is at most one clause and only where the purpose is not self-evident.
- Each rule works in both the Claude app and Claude Code, or sits in CLAUDE.md.
- No contradictions with the README or the user instructions.
- No notes about the file itself, no first name, no capitals or "CRITICAL" for emphasis.
- The file fits on one screen. If it does not, name what could move to the README or a skill.
- The claude.ai instructions field matches the file.
