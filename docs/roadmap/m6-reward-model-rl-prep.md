# M6: Reward Model and RL Prep

## Goal

Prepare preference and reward data for Agent-R1/verl after evaluation is stable.

## Why It Matters

RL without a stable evaluator can amplify bad behavior. TraceOtter should only
enter this phase once held-out evaluation can catch unsafe, unverified, or
low-quality actions.

## Prerequisites

- `traceotter eval` exists.
- Dataset quality gates are enforced.
- Train/dev/test splits are stable.
- Route and verification metrics are tracked across runs.

## Proposed CLI

```bash
traceotter --json export-reward \
  --episodes .traceotter/local/episodes.jsonl \
  --eval .traceotter/eval/report.json \
  --out .traceotter/reward
```

Later:

```bash
traceotter --json export-verl \
  --reward .traceotter/reward/preferences.jsonl \
  --out .traceotter/verl
```

## Scope

- Build preference pairs from better/worse traces.
- Use failed traces as negative examples.
- Include evaluator-derived reward signals.
- Export formats usable by reward-model training.
- Document Agent-R1/verl integration assumptions.

## Output Files

```text
.traceotter/reward/
  preferences.jsonl
  reward_report.json

.traceotter/verl/
  train_config.yaml
  dataset.jsonl
```

## Acceptance Criteria

- Reward examples include positive and negative provenance.
- Failed/unsafe traces are never treated as positive imitation examples.
- Exported files are deterministic for the same input.
- Docs explain why RL is gated behind evaluation.

## Non-Goals

- No online RL against live repositories.
- No automatic model deployment.

