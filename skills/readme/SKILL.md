---
name: readme
description: Write a README for a repository that has none, or review an existing one against the README contract. Use when setting up a repository, when asked to write, check or improve a README, or when a change leaves the README out of date.
---

# README

If the repository has no README.md, follow "Write a new README". If it has one, follow "Review an existing README". The rules are the standards readme-contract and documentation of tiavelum/engineering-standards: load them as the "Repository rules" user instruction says, cite their rule ids, and never restate them here or in the README.

## Find what the reader needs

1. List the top-level files and directories, and open the files a user of the repository would open first.
2. Find what the repository is for and who uses it, from its files, its open issues and what I have said. Ask in one round only what the repository cannot answer.
3. Find how a reader gets a first result: a command with its output, or the file to open first.
4. Write down the questions this repository gives its reader. Each one gets a section; a question it does not give gets none.

## Write a new README

1. Draft the sections in the order the reader needs them, and name each for what it holds in this repository.
2. Run every command in the draft against the default branch and paste its actual output.
3. Run the checks below on the draft and fix what they find.

## Review an existing README

1. Read README.md from the branch you work on.
2. Run the checks below and report each finding with its rule id and a proposed fix, most important first.
3. Change only what the findings require. Keep every passage that meets the rules as it is, including its headings.

## Checks

1. Go through every rule of readme-contract and DOC-30 to DOC-33, and note each rule the README breaks, by id.
2. Count the words above the first-result heading: `sed -n '1,/^## <heading>/p' README.md | sed '$d' | wc -w`.
3. Run every command in the README against the default branch and compare its output with the README.
4. Open every relative link and confirm that its target exists.
5. Compare every file and directory the README names with the repository, and every top-level directory of the repository with the README.
6. For each optional section, find the sentence that no other section states. A section without one goes.
