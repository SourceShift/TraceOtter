# Engineer Workflow

TraceOtter is for engineers who already have JSONL history from coding-agent
sessions and want to distill it into a small model that learns local engineering
habits.

## What It Learns First

The first useful TraceOtter model should learn coding flow, not full autonomous
replacement:

- classify a task from the user request;
- choose a route such as docs, review, direct edit, worktree, or orchestration;
- extract reusable procedures from prior sessions;
- suggest focused verification commands;
- avoid imitating failed or unsafe episodes.

Patch-writing can come later, after evaluation and reward modeling.

## 1. Distill JSONL History

For generic JSONL folders:

```bash
traceotter --json distill \
  --jsonl /path/to/jsonl/history \
  --out .traceotter/local \
  --limit-files 1000 \
  --max-events-per-file 4000
```

For known local sources:

```bash
traceotter --json distill \
  --codex /Users/admin/.codex/sessions \
  --claude /Users/admin/.claude/projects \
  --mini-ork /Users/admin/ps/mini-ork/.mini-ork/runs \
  --out .traceotter/local \
  --limit-files 1000
```

The `distill` command runs:

```text
ingest -> normalize episodes -> consolidate procedural skills -> export SFT
```

## 2. Inspect the Output

```bash
cat .traceotter/local/report.json
head -n 3 .traceotter/local/episodes.jsonl
cat .traceotter/local/skills.json
head -n 40 .traceotter/local/llamafactory/traceotter_sft.json
cat .traceotter/local/llamafactory/llamafactory_sft.yaml
```

Do not train if the examples contain private secrets, irrelevant tasks, or
failed workflows that should not be imitated.

## 3. Train the First Model

```bash
llamafactory-cli train .traceotter/local/llamafactory/llamafactory_sft.yaml
```

Default model:

```text
Qwen/Qwen3-4B-Instruct-2507
```

The goal of this first run is to prove that the data pipeline and model behavior
are sensible. Do not optimize for benchmark numbers yet.

## 4. Evaluate Before Replacing Anything

Before using the model as a coding-agent replacement, build held-out evals for:

- route choice accuracy;
- verification-command quality;
- dirty-worktree safety;
- secret and private-data avoidance;
- ability to say that more context is needed;
- refusal to imitate failed traces.

Only after those gates are stable should TraceOtter add reward modeling and
Agent-R1/verl.

## 5. Repeat Weekly

```bash
traceotter --json distill \
  --codex /Users/admin/.codex/sessions \
  --claude /Users/admin/.claude/projects \
  --mini-ork /Users/admin/ps/mini-ork/.mini-ork/runs \
  --out .traceotter/run-$(date +%Y%m%d) \
  --limit-files 5000
```

Track these numbers:

- normalized episodes;
- SFT examples;
- consolidated skills;
- skipped files;
- completed versus partial episodes;
- manual review failures.

If SFT examples grow but eval quality drops, improve filtering before training a
larger model.
