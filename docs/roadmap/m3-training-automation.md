# M3: Training Automation

## Goal

Add `traceotter train` as a reproducible wrapper around LLaMA-Factory.

## Why It Matters

TraceOtter currently exports the right files, but engineers still need to know
how to arrange LLaMA-Factory paths and run the training command. A wrapper makes
the first LoRA run repeatable.

## Proposed CLI

Dry run:

```bash
traceotter --json train \
  --dataset .traceotter/local/llamafactory \
  --dry-run
```

Run:

```bash
traceotter --json train \
  --dataset .traceotter/local/llamafactory
```

## Scope

- Detect `llamafactory-cli`.
- Validate `dataset_info.json`, dataset JSON, and YAML config.
- Print the exact training command.
- Optionally copy or symlink data into a LLaMA-Factory checkout.
- Record model name, template, cutoff length, LoRA output path, and git commit.
- Store run metadata under `.traceotter/runs/`.

## Output Files

```text
.traceotter/runs/<timestamp>/
  train_command.txt
  train_config.yaml
  metadata.json
```

## Acceptance Criteria

- `--dry-run` succeeds without running GPU work.
- Missing LLaMA-Factory produces a clear actionable error.
- Existing generated configs are validated before training.
- Tests cover dry-run and invalid dataset layout.

## Non-Goals

- No automatic GPU provisioning.
- No dependency installation without explicit user action.

