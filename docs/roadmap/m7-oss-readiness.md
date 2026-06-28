# M7: OSS Readiness

## Goal

Make TraceOtter ready for external engineers to understand, test, and contribute
without access to private local traces.

## Why It Matters

The project handles private coding histories. Good OSS hygiene must make the
safe path obvious and keep examples sanitized.

## Scope

- GitHub Actions CI.
- Contribution guide.
- Security and privacy guide.
- Sanitized fixture dataset.
- Issue templates.
- Release checklist.
- README badges and quickstart.
- Example outputs under `examples/`.

## Proposed Files

```text
.github/workflows/ci.yml
CONTRIBUTING.md
SECURITY.md
docs/PRIVACY.md
examples/fixtures/
docs/roadmap/
```

## Acceptance Criteria

- CI runs tests on supported Python versions.
- A new contributor can run tests without private data.
- Docs clearly warn against publishing raw local traces.
- Examples use sanitized synthetic data.
- The README has a 5-minute quickstart.

## Non-Goals

- No hosted service.
- No telemetry.
- No automatic upload of training data.

