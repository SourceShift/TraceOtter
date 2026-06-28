# TraceOtter

TraceOtter turns local coding-agent trajectories into training data for a
small coding model.

It starts with the practical path:

```text
Codex JSONL + Claude JSONL + mini-ork runs
  -> normalized episodes
  -> procedural skill consolidation
  -> LLaMA-Factory SFT dataset/config
  -> evaluator/reward model
  -> later Agent-R1/verl RL
```

## Install

```bash
cd ~/ps/TraceOtter
python -m venv .venv
source .venv/bin/activate
python -m pip install -e ".[dev]"
traceotter --json doctor
```

## Prepare Local Data

```bash
traceotter --json pipeline \
  --codex /Users/admin/.codex/sessions \
  --claude /Users/admin/.claude/projects \
  --mini-ork ~/ps/mini-ork/.mini-ork/runs \
  --out .traceotter/local \
  --limit-files 500
```

Generated files:

```text
.traceotter/local/
  manifest.json
  episodes.jsonl
  skills.json
  report.json
  llamafactory/
    traceotter_sft.json
    dataset_info.json
    llamafactory_sft.yaml
```

## Train With LLaMA-Factory

Copy or symlink the generated dataset files into your LLaMA-Factory `data/`
directory, then run:

```bash
llamafactory-cli train .traceotter/local/llamafactory/llamafactory_sft.yaml
```

The default first model is:

```text
Qwen/Qwen2.5-Coder-1.5B-Instruct
```

## Design References

- Agent Data Protocol is the normalization reference.
- MemP is the procedural-memory and self-consolidation reference.
- Open-SWE-Traces and SWE-Zero are planned public bootstrap data sources.
- LLaMA-Factory is the first trainer.
- Agent-R1/verl is deliberately deferred until a stable evaluator/reward model exists.

## Verify

```bash
python -m compileall traceotter
python -m pytest -q
python -m traceotter.cli --json doctor
```

## Safety

Local trajectories can contain private prompts, repository paths, code, and
secrets. TraceOtter redacts obvious token patterns, but exported datasets should
stay private until reviewed.

