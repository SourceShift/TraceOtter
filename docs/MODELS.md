# Model Selection

TraceOtter should optimize for trainability, licensing, long-horizon coding
behavior, and future RL/evaluator compatibility. Raw leaderboard rank is not
enough.

## Default

```text
Qwen/Qwen3-4B-Instruct-2507
```

Why this is the default:

- It is small enough to fine-tune first.
- LLaMA-Factory documents Qwen3 SFT support with `template: qwen3_nothink`.
- It keeps the project on the newer Qwen3 tokenizer/template path instead of
  the older Qwen2.5-Coder path.
- A 4B dense model is easier to debug, evaluate, quantize, and serve than a
  larger MoE model.

Generated LLaMA-Factory settings:

```yaml
model_name_or_path: Qwen/Qwen3-4B-Instruct-2507
template: qwen3_nothink
trust_remote_code: true
cutoff_len: 8192
finetuning_type: lora
```

## Upgrade Target

```text
Qwen/Qwen3-Coder-30B-A3B-Instruct
```

Use this when GPU budget allows and the evaluator is stable. It is a stronger
agentic-coding target, but its total parameter footprint makes iteration slower.
For TraceOtter, it should be the second-stage model, not the first bootstrap
model.

## Watchlist

```text
Qwen3.6-35B-A3B
```

This is a promising future target, but it should not be the default until the
training stack explicitly supports it and a small TraceOtter smoke fine-tune is
verified. Newer is not automatically better for this project; unsupported
templates and inference backends can waste days.

## Why Not Qwen2.5-Coder Anymore

Qwen2.5-Coder was a reasonable initial default because it was small and easy to
train. It is now the wrong long-term anchor because TraceOtter needs newer
Qwen3-compatible templates, longer trajectory windows, and a path toward
agentic-code models.

## Selection Rule

Promote a new default only when all of these are true:

- LLaMA-Factory has a documented or locally verified template.
- The model has a permissive enough license for OSS and private commercial use.
- A 10-file local smoke pipeline exports non-empty SFT data.
- A one-epoch LoRA smoke run completes.
- Held-out route/verification evaluation does not regress.

