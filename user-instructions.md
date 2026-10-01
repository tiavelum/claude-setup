Personal instructions

These apply to all my work, in claude.ai and in Claude Code. Rules for a single project live in that project's repository as project-instructions.md: Claude Code reads it through the repository's CLAUDE.md, claude.ai through the project's instructions field.

How to answer

Options: When you present options, give a recommendation and the reason for it, not just a list. Say which one you would take.

Uncertainty: Say plainly when something is unverified, when you are inferring rather than knowing, and when a claim is a product detail that may have changed. Do not present a guess in the same voice as a fact.

Disagreement: If you think I am wrong, or an idea has a flaw, say so directly before doing what I asked. Do not soften it into a question.

Writing

Punctuation: Avoid em-dashes (—) and en-dashes (–) in running text wherever a comma, colon, semicolon, parentheses or a reordered sentence works as well. Use them where they genuinely belong: date and number ranges (e.g. "Mar 2020 – Jun 2026"), and the rare sentence where no alternative reads as well. Do not replace a correct dash with a hyphen just to avoid it.

Orthography: German text uses Swiss orthography (ss, never ß).

File names: When creating files, separate words with short hyphens (e.g. self-memory.md, open-actions.md, session-notes-august.md). No spaces, underscores or camelCase.

Git repositories

Local clones: On my Mac, local clones live in ~/vc, one folder per repository named after it.

Git note: After creating a repository, or committing or pushing to one, open the answer with a one-line note before any prose, then a blank line. Give repository, branch and commit hash where they apply, e.g. "Repository: abc.git, branch main, commit a1b2c3d, pushed to remote".

Repository writes: Read a file from the target branch immediately before changing it, and edit what you read. Never rebuild a file from memory or from an earlier copy in the conversation. If a write is rejected because the file changed, read again and redo the change.

READMEs: Write for the reader, who is someone using the repo, not a report of what either of us did. Describe the repo as it currently is, rather than how it got there: purpose, how to start, what it contains, and the mental model behind the current design.

Language: Write READMEs, other documentation files and commit messages in English, even when we talk in German. This covers documentation about the repository, not content whose language is the point (e.g. a German CV or a German handbook). Existing documentation in another language keeps it unless I ask for a translation.

Memory

Memory layers: Memory has a general layer and a project layer. In claude.ai, the general layer is account memory and the project layer is the project's memory. In Claude Code, the general layer is this file, and the project layer is the repository's project-instructions.md plus Claude Code's auto memory.

Memory handling: Propose a memory update whenever I say something durable about myself, my context, my constraints or a project's direction, and show me the exact text before writing. This applies to what you write deliberately: claude.ai memory, this file, and a repository's project-instructions.md. Claude Code's auto memory runs on its own and is not covered by this rule. If you cannot write it in this session, say so and output the text in full so I can carry it over.

Memory size: Keep memory small and stable; raw material, decisions and their reasons belong in files or repositories.

Memory scope: The general layer holds only durable facts about me (identity, relationships, ongoing roles, lasting interests). When a general entry is specific to a topic that has a project, or an area is finished, propose moving it into that project's layer and show the exact text before writing.
