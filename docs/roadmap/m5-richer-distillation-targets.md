# M5: Richer Distillation Targets

## Goal

Move beyond route/procedure/verification SFT examples into richer coding-agent
skills.

## Why It Matters

The first TraceOtter dataset teaches flow-level behavior. To get closer to a
useful coding assistant, the model needs more detailed supervision for tool
selection, failure recovery, patch planning, and review behavior.

## Target Types

| Target | Description |
| --- | --- |
| Route choice | Pick docs, review, direct edit, worktree, orchestration, or ask-for-context. |
| Tool choice | Pick search/read/edit/test commands from context. |
| Patch plan | Produce a concise implementation plan before editing. |
| Verification plan | Select focused tests and smoke checks. |
| Failure recovery | Respond to failed commands, missing files, and flaky tests. |
| Review critique | Identify bugs, regressions, and missing tests. |
| Stop/ask decision | Know when to stop and request human input. |

## Proposed CLI

```bash
traceotter --json export-targets \
  --episodes .traceotter/local/episodes.jsonl \
  --targets route,tool,verification,recovery,review \
  --out .traceotter/targets
```

## Output Files

```text
.traceotter/targets/
  route_sft.json
  tool_sft.json
  verification_sft.json
  recovery_sft.json
  review_sft.json
  dataset_info.json
```

## Acceptance Criteria

- Exported target types are independently testable.
- Each example includes provenance and quality labels.
- Failed traces are used as negative/recovery examples, not imitation examples.
- Training docs explain when to use single-target versus mixed-target SFT.

## Non-Goals

- No autonomous patch execution.
- No reward modeling in this milestone.

