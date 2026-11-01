# plugin

This directory is the plugin `tiavelum-claude-setup`, which carries the agent types of
[`agents/`](../agents/README.md) to a claude.ai account, and this README is for whoever
changes it.

`.claude-plugin/plugin.json` is its manifest. `agents/` holds one symbolic link per
agent type, pointing at its file in the repository's `agents/`, so that each type keeps
one home; `zip` packs the linked file's content. A new agent type gets a link here in
the same pull request that adds its file.

The upload takes only `.claude-plugin/` and `agents/`; this README stays out of the
package.
