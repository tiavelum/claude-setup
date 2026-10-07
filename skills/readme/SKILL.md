---
name: readme
description: Write a README for a repository that has none, or review an existing one against the README contract. Use when setting up a repository, when asked to write, check or improve a README, or when a change leaves the README out of date.
---

# README

Written for major version 4 of readme-contract and major version 6 of documentation, both in tiavelum/engineering-standards.

If the repository has no README.md, follow "Write a new README". If it has one, follow "Review an existing README".

## Load the rules

1. Fetch index.yaml from tiavelum/engineering-standards and load readme-contract and documentation, with every entry they require.
2. If either has a major version other than the one named above, stop and tell me which, before writing or reviewing anything.

## Find what the reader needs

1. List the top-level files and directories, and open the files a user of the repository would open first.
2. Find what the repository is for and who uses it, from its files, its open issues and what I have said. Ask in one round only what the repository cannot answer.
3. Find how a reader gets a first result: a command with its output, or the file to open first.
4. Write down the questions this repository gives its reader.

## Write a new README

1. Draft the README from these findings against readme-contract.
2. Run every command in the draft against the default branch and paste its actual output.
3. Run the checks below on the draft and fix what they find.

## Review an existing README

1. Read README.md from the branch you work on.
2. Run the checks below and report each finding with its rule id and a proposed fix, most important first.
3. Change only what the findings require. Keep every passage that meets the rules as it is, including its headings.

## Checks

1. Go through every rule of readme-contract, and every rule of documentation that applies to a README, and note each rule the README breaks, by id.
2. Count the words above the heading that the contract's word limit names: `sed -n '1,/^## <heading>/p' README.md | sed '$d' | wc -w`.
3. Run every command in the README against the default branch and compare its output with the README.
4. List every step in the README that this session cannot carry out, such as a step in a user interface, a command that needs my machine, or any command when the session has no shell. Report each as not verified, with what I need to do to verify it, and report no rule that covers such a step as met while it stays unverified.
5. Open every relative link and confirm that its target exists.
6. Compare every file and directory the README names with the repository, and every top-level directory with the README.
