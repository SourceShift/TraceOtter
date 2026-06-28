.PHONY: doctor test distill-smoke smoke

doctor:
	python -m traceotter.cli --json doctor

test:
	python -m compileall traceotter
	python -m pytest -q

smoke:
	python -m traceotter.cli --json pipeline \
		--codex /Users/admin/.codex/sessions \
		--claude /Users/admin/.claude/projects \
		--mini-ork /Users/admin/ps/mini-ork/.mini-ork/runs \
		--out /tmp/traceotter-smoke \
		--limit-files 10 \
		--max-events-per-file 2000

distill-smoke:
	python -m traceotter.cli --json distill \
		--jsonl /Users/admin/.codex/sessions \
		--out /tmp/traceotter-distill-smoke \
		--limit-files 10 \
		--max-events-per-file 2000
