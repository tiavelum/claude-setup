#!/usr/bin/env python3
"""Print the steps and tokens of Claude Code sessions, per session and agent.

Reads the session records under ~/.claude/projects/: one JSON Lines file per
session, and the records of its agents in <session>/subagents/. A session whose
working directory changed has records in more than one project folder; all of
them are read. Prints tokens; applies prices only when a price file is given.
"""

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import dataclass, field
from pathlib import Path

KINDS = ("input", "cache_read", "cache_write_5m", "cache_write_1h", "output")
PRICE_KEYS = KINDS
PROJECTS = Path.home() / ".claude" / "projects"


@dataclass
class Usage:
    """Steps and tokens of one session or agent."""

    name: str
    steps: int = 0
    tokens: dict[str, int] = field(default_factory=lambda: dict.fromkeys(KINDS, 0))
    last_context: int = 0
    models: dict[str, int] = field(default_factory=dict)
    cost: float | None = None

    def add(self, model: str, usage: dict) -> None:
        cache_write = usage.get("cache_creation_input_tokens") or 0
        split = usage.get("cache_creation") or {}
        write_1h = split.get("ephemeral_1h_input_tokens") or 0
        step = {
            "input": usage.get("input_tokens") or 0,
            "cache_read": usage.get("cache_read_input_tokens") or 0,
            "cache_write_1h": write_1h,
            "cache_write_5m": cache_write - write_1h,
            "output": usage.get("output_tokens") or 0,
        }
        for kind in KINDS:
            self.tokens[kind] += step[kind]
        self.steps += 1
        self.models[model] = self.models.get(model, 0) + 1
        self.last_context = step["input"] + step["cache_read"] + cache_write

    def price(self, prices: dict[str, dict[str, float]], by_model: dict[str, dict]) -> None:
        total = 0.0
        for model, tokens in by_model.items():
            rates = prices.get(model)
            if rates is None:
                self.cost = None
                return
            total += sum(tokens[k] * rates.get(k, 0.0) for k in KINDS) / 1_000_000
        self.cost = total


def read_steps(paths: list[Path]) -> list[tuple[str, str, dict]]:
    """Return (timestamp, model, usage) per API request, once per request."""
    steps: dict[str, tuple[str, str, dict]] = {}
    for path in paths:
        with path.open(encoding="utf-8") as f:
            for line in f:
                try:
                    entry = json.loads(line)
                except json.JSONDecodeError:
                    continue
                if entry.get("type") != "assistant":
                    continue
                message = entry.get("message") or {}
                usage = message.get("usage")
                if not usage:
                    continue
                key = entry.get("requestId") or message.get("id") or entry.get("uuid")
                steps[key] = (entry.get("timestamp", ""), message.get("model", "?"), usage)
    return sorted(steps.values(), key=lambda step: step[0])


def records_of(session: Path) -> tuple[list[Path], dict[str, list[Path]]]:
    """Return the session's files and, per agent, its files across all project folders.

    A change of working directory starts a new project folder under the same
    session ID, and the agents started before it stay in the old one. Only
    sessions under PROJECTS are widened, so a copied file is read on its own.
    """
    files = [session]
    if session.resolve().parent.parent == PROJECTS.resolve():
        files = sorted({session, *PROJECTS.glob(f"*/{session.name}")})
    agents: dict[str, list[Path]] = {}
    for file in files:
        for agent in sorted((file.with_suffix("") / "subagents").glob("*.jsonl")):
            agents.setdefault(agent.stem, []).append(agent)
    return files, dict(sorted(agents.items()))


def measure(name: str, paths: list[Path], prices: dict | None) -> Usage:
    result = Usage(name)
    by_model: dict[str, dict[str, int]] = {}
    for _, model, usage in read_steps(paths):
        before = dict(result.tokens)
        result.add(model, usage)
        tokens = by_model.setdefault(model, dict.fromkeys(KINDS, 0))
        for kind in KINDS:
            tokens[kind] += result.tokens[kind] - before[kind]
    if prices is not None:
        result.price(prices, by_model)
    return result


def sessions_in(paths: list[str]) -> list[Path]:
    if not paths:
        newest = sorted(PROJECTS.glob("*/*.jsonl"), key=lambda p: p.stat().st_mtime)
        if not newest:
            sys.exit(f"No session records under {PROJECTS}")
        return newest[-1:]
    found: list[Path] = []
    for arg in paths:
        path = Path(arg).expanduser()
        if path.is_dir():
            found.extend(sorted(path.glob("*.jsonl")))
        elif path.is_file():
            found.append(path)
        else:
            sys.exit(f"Not found: {arg}")
    unique: dict[str, Path] = {}
    for path in found:
        unique.setdefault(path.stem, path)
    return list(unique.values())


def report(session: Path, prices: dict | None) -> dict:
    files, agents = records_of(session)
    rows = [measure("session", files, prices)]
    for name, paths in agents.items():
        rows.append(measure(name, paths, prices))
    total = Usage("total")
    for row in rows:
        total.steps += row.steps
        for kind in KINDS:
            total.tokens[kind] += row.tokens[kind]
        for model, count in row.models.items():
            total.models[model] = total.models.get(model, 0) + count
    if prices is not None:
        costs = [row.cost for row in rows]
        total.cost = None if None in costs else sum(costs)
    return {"session": session.stem, "path": str(session), "rows": rows, "total": total}


def as_dict(row: Usage) -> dict:
    return {
        "name": row.name,
        "steps": row.steps,
        "tokens": row.tokens,
        "last_context": row.last_context,
        "models": row.models,
        "cost": row.cost,
    }


def print_table(result: dict, priced: bool) -> None:
    headers = ["", "steps", "input", "cache read", "cache write", "output", "last context"]
    if priced:
        headers.append("cost")
    lines = []
    for row in [*result["rows"], result["total"]]:
        t = row.tokens
        cells = [
            row.name,
            row.steps,
            t["input"],
            t["cache_read"],
            t["cache_write_5m"] + t["cache_write_1h"],
            t["output"],
            row.last_context if row.name != "total" else "",
        ]
        if priced:
            cells.append("?" if row.cost is None else f"{row.cost:.2f}")
        lines.append([f"{c:,}" if isinstance(c, int) else str(c) for c in cells])
    widths = [max(len(h), *(len(line[i]) for line in lines)) for i, h in enumerate(headers)]
    print(f"Session {result['session']}")
    for line in [headers, *lines]:
        cells = (c.ljust(w) if i == 0 else c.rjust(w) for i, (c, w) in enumerate(zip(line, widths)))
        print("  ".join(cells).rstrip())
    models = ", ".join(f"{m} ({n})" for m, n in sorted(result["total"].models.items()))
    print(f"Models by steps: {models}")


def main() -> None:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "A price file is JSON: model id to dollars per million tokens for "
            + ", ".join(PRICE_KEYS)
            + '. Example: {"claude-opus-5-5": {"input": 5, "output": 25, ...}}'
        ),
    )
    parser.add_argument(
        "paths",
        nargs="*",
        help="session .jsonl files or project folders; default: the newest session",
    )
    parser.add_argument("--prices", type=Path, help="price file; without it no cost is shown")
    parser.add_argument("--json", action="store_true", help="print JSON instead of tables")
    args = parser.parse_args()

    prices = None
    if args.prices:
        if not args.prices.is_file():
            sys.exit(f"Not found: {args.prices}")
        prices = json.loads(args.prices.read_text(encoding="utf-8"))
    results = [report(session, prices) for session in sessions_in(args.paths)]
    if args.json:
        out = [
            {
                "session": r["session"],
                "path": r["path"],
                "rows": [as_dict(row) for row in r["rows"]],
                "total": as_dict(r["total"]),
            }
            for r in results
        ]
        print(json.dumps(out, indent=2))
        return
    for i, result in enumerate(results):
        if i:
            print()
        print_table(result, prices is not None)


if __name__ == "__main__":
    main()
