# M2: Dataset Quality Gates

## Goal

Prevent low-quality or unsafe JSONL history from entering the training dataset.

## Why It Matters

Private agent histories often contain secrets, local paths, failed commands,
unfinished plans, duplicate sessions, and accidental user data. Training on
those traces can leak information or teach bad engineering habits.

## Proposed CLI

```bash
traceotter --json quality \
  --episodes .traceotter/local/episodes.jsonl \
  --out .traceotter/quality
```

Optional strict mode:

```bash
traceotter --json quality \
  --episodes .traceotter/local/episodes.jsonl \
  --out .traceotter/quality \
  --fail-on secret,duplicate,failed_trace
```

## Checks

- Secret-like token patterns.
- Duplicate or near-duplicate episodes.
- Empty user goals.
- Episodes with only noisy/tool output.
- Failed traces marked as imitable.
- Missing verification for implementation tasks.
- Overlong examples that exceed training cutoff.
- Source distribution imbalance.
- Private absolute paths in generated SFT examples.

## Output Files

```text
.traceotter/quality/
  report.json
  report.md
  warnings.jsonl
  filtered_episodes.jsonl
```

## Acceptance Criteria

- The quality report includes counts by source, task type, status, and warning
  type.
- A filtered episode file can be passed to `export-llamafactory`.
- Tests include fixtures for secrets, duplicates, failed traces, and overlong
  examples.
- The default pipeline prints quality warning counts in `report.json`.

## Non-Goals

- No guarantee that all secrets are found.
- No upload or external scanning service.

