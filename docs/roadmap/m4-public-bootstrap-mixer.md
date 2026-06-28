# M4: Public Bootstrap Mixer

## Goal

Mix private local JSONL history with public coding-agent trajectory datasets
without losing provenance or local weighting.

## Public Sources

- Open-SWE-Traces.
- SWE-Zero / OpenHands trajectories.

## Why It Matters

Local history teaches repo-specific habits, but it may be too narrow. Public SWE
data can improve general coding priors while local traces remain the high-value
signal for user preferences and workflow style.

## Proposed CLI

```bash
traceotter --json mix \
  --local .traceotter/local/episodes.jsonl \
  --open-swe /data/open-swe-traces \
  --swe-zero /data/swe-zero \
  --local-weight 3.0 \
  --out .traceotter/mixed
```

## Scope

- Add public dataset adapters.
- Normalize public data into the same episode schema.
- Preserve source provenance.
- Support sampling weights.
- Emit source distribution reports.
- Keep private and public examples distinguishable in exported training data.

## Output Files

```text
.traceotter/mixed/
  episodes.jsonl
  mix_report.json
  llamafactory/
    traceotter_mixed_sft.json
    dataset_info.json
    llamafactory_sft.yaml
```

## Acceptance Criteria

- Local-only behavior remains unchanged.
- Mixed exports include provenance labels.
- Local examples can be weighted higher than public examples.
- Tests cover mixing, weights, and source stats.

## Non-Goals

- No automatic large dataset downloads in the default path.
- No public upload of private traces.

