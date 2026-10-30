# Screener brief for tiavelum/engineering-standards

This is the part of every brief that a checker screening one standard of tiavelum/engineering-standards against all others follows; the coordinating session adds the standard, the clone, your worktree and the report path, and you follow that as well.

## Goal

Find what makes two sessions applying the standards reach two results: screen one standard against every other file listed in `index.yaml` and against the consumer contract (`meta/consuming.md`).

## Setup

Follow "Stance" and "Setup" of `engineering-standards-checker.md`, beside this brief. Create your worktree at `origin/main` after a fetch (`git -C <clone> worktree add --detach <worktree> origin/main`), read every file from it, and remove it at the end.

## Read

- In full: `index.yaml`, `meta/rule-format.md`, `meta/consuming.md`, `meta/precedence.md`, your standard, and every other file `index.yaml` lists. Read each once and search your copy afterwards.
- The open questions already put to tiavelum, which you must not raise again but name where a finding touches one: `curl -sS "https://api.github.com/repos/tiavelum/engineering-standards/issues?state=open&labels=tiavelum-decides&per_page=100"`. Search other issues only where a finding needs to know whether a decision covers it.

## Find, for each rule of your standard

1. **Conflict or contradiction**: a rule of your standard and a rule of another file that cannot both be met on one real case, or that give two answers for it.
2. **Ambiguity**: a rule that reads two ways when tried on a concrete case; name the case and both readings.
3. **Gap**: a case that a rule of your standard plainly sets out to govern, where the rules give no answer. Report only gaps you can show on a concrete case.
4. **Restatement**: a requirement your rule states that another rule already states (RF-42), or a rule a repository setting already enforces in full (TL-30).
5. **Broken reference**: a rule identifier, path or term your standard uses that does not exist or means something else where it is defined.

Report a pair of rules once, under your standard. Report nothing that is only a preference of wording.

## Report

Save to the path your brief gives, at most 100 lines. Start with the verdict: how many rules you screened, how many hold, how many have a finding. Then one block per finding, numbered `<standard>-F<n>`: its kind and the rule identifiers and files involved; the concrete case; the smallest change that removes it, as a complete replacement text where you can; whether a decision on an issue covers that change (name the issue and quote the decision) or that none does, and which open question it touches.

Return only the verdict line and one line per finding.
