# TraceOtter Roadmap

TraceOtter's roadmap is ordered around the shortest path from private JSONL
history to a useful small coding model.

The rule is simple: improve data quality and evaluation before adding larger
models or reinforcement learning.

## Milestones

| Milestone | Status | Purpose |
| --- | --- | --- |
| M0: Distillation Bootstrap | Done | Convert JSONL history into normalized episodes, procedural skills, and LLaMA-Factory SFT artifacts. |
| M1: Evaluation Harness | Planned | Measure whether the small model can choose routes, verification steps, and safe behavior on held-out episodes. |
| M2: Dataset Quality Gates | Planned | Prevent secrets, failed workflows, duplicates, and low-quality traces from entering training. |
| M3: Training Automation | Planned | Make the path from exported dataset to first LoRA run reproducible. |
| M4: Public Bootstrap Mixer | Planned | Mix local traces with Open-SWE-Traces and SWE-Zero while preserving provenance and weights. |
| M5: Richer Distillation Targets | Planned | Move beyond route/procedure/verification into tool choice, recovery, review, and patch planning. |
| M6: Reward Model and RL Prep | Planned | Add preference/reward data and Agent-R1/verl only after evaluation is stable. |
| M7: OSS Readiness | Planned | Add CI, contribution docs, privacy guidance, and sanitized examples. |

## Detailed Tasks

- [M1: Evaluation Harness](m1-evaluation-harness.md)
- [M2: Dataset Quality Gates](m2-dataset-quality-gates.md)
- [M3: Training Automation](m3-training-automation.md)
- [M4: Public Bootstrap Mixer](m4-public-bootstrap-mixer.md)
- [M5: Richer Distillation Targets](m5-richer-distillation-targets.md)
- [M6: Reward Model and RL Prep](m6-reward-model-rl-prep.md)
- [M7: OSS Readiness](m7-oss-readiness.md)

## Priority Order

1. Build `traceotter eval`.
2. Add dataset quality gates and train/dev/test splitting.
3. Add `traceotter train` around LLaMA-Factory.
4. Add public-data mixing after local data quality is measurable.
5. Add reward modeling and RL only after held-out evaluation catches bad behavior.

## Definition of Productive

TraceOtter is productive when an engineer can run:

```bash
traceotter --json distill --jsonl /path/to/history --out .traceotter/local
traceotter --json eval --episodes .traceotter/local/episodes.jsonl --out .traceotter/eval
traceotter --json train --dataset .traceotter/local/llamafactory
```

and get:

- a reviewed SFT dataset;
- clear quality warnings;
- a reproducible training command;
- held-out evaluation scores;
- a model that helps with route choice, verification planning, and procedural
  coding flow before it attempts autonomous patching.

