# M1: Evaluation Harness

## Goal

Add `traceotter eval` so engineers can measure whether a trained or prompted
small model learned useful coding flow from JSONL history.

## Why It Matters

Without evaluation, TraceOtter can produce training data but cannot tell whether
the resulting model is safer, cheaper, or more useful than the baseline agent.
Evaluation must come before reward modeling and before any replacement claim.

## User Story

As an engineer, I want to hold out part of my JSONL history and score a model on
route choice, verification planning, and safety so I can decide whether the
distilled model is ready for a narrow workflow.

## Proposed CLI

```bash
traceotter --json eval \
  --episodes .traceotter/local/episodes.jsonl \
  --predictions .traceotter/predictions.jsonl \
  --out .traceotter/eval
```

Later:

```bash
traceotter --json eval \
  --episodes .traceotter/local/episodes.jsonl \
  --model saves/traceotter-qwen3-4b-lora \
  --out .traceotter/eval
```

## Scope

- Create held-out splits from normalized episodes.
- Define route labels such as `docs_or_review`, `direct_edit`, `worktree`,
  `orchestration`, and `ask_for_context`.
- Score verification quality from expected commands and observed tests.
- Flag unsafe shell actions.
- Score whether failed traces are rejected instead of imitated.
- Emit machine-readable JSON and human-readable markdown.

## Output Files

```text
.traceotter/eval/
  report.json
  report.md
  route_confusion_matrix.json
  failed_cases.jsonl
```

## Acceptance Criteria

- `traceotter eval --help` documents the workflow.
- A fixture dataset can be evaluated without external model calls.
- The report includes route accuracy, verification coverage, failed-trace
  rejection, and safety warnings.
- Tests cover perfect predictions, wrong route, missing verification, and unsafe
  action cases.

## Non-Goals

- No Agent-R1/verl integration.
- No benchmark leaderboard claims.
- No autonomous code execution during evaluation.

