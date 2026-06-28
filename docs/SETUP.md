# TraceOtter Setup

## 1. Create the Environment

```bash
cd ~/ps/TraceOtter
python -m venv .venv
source .venv/bin/activate
python -m pip install -U pip
python -m pip install -e ".[dev]"
```

## 2. Check the CLI

```bash
traceotter --json doctor
```

Expected shape:

```json
{"adapters":["codex_jsonl","claude_jsonl","mini_ork_run"],"ok":true,"package":"traceotter","trainerExport":"llamafactory"}
```

## 3. Build a Local Dataset

```bash
traceotter --json pipeline \
  --codex /Users/admin/.codex/sessions \
  --claude /Users/admin/.claude/projects \
  --mini-ork /Users/admin/ps/mini-ork/.mini-ork/runs \
  --out .traceotter/local \
  --limit-files 500
```

## 4. Inspect Before Training

```bash
head -n 3 .traceotter/local/episodes.jsonl
head -n 20 .traceotter/local/llamafactory/traceotter_sft.json
cat .traceotter/local/report.json
```

Review the dataset for private content before copying it to any shared machine.

## 5. Train

Install LLaMA-Factory separately, then run:

```bash
llamafactory-cli train .traceotter/local/llamafactory/llamafactory_sft.yaml
```

Do not add Agent-R1/verl until the replay evaluator and reward model can reject
bad patches, unsafe shell actions, and unverified completions.

