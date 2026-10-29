# agents

This directory holds the agent types that both Claude Code setups install at user
level, and this README is for whoever adds or changes one.

Each file defines one agent type, is named after it and holds the `name`,
`description`, `tools`, `model` and `effort` frontmatter of the
[Subagents](https://code.claude.com/docs/en/sub-agents) documentation, with a body of
directives only.

`setup-local.sh` links every `.md` file here except this README. `setup-cloud.sh`
downloads the files whose names its `agents` list holds, since a raw file URL serves
no directory listing; a new file is added to that list in the same pull request.
