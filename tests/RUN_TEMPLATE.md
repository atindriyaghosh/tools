# Test Run Report Template

Use this template to record manual or agent-driven test runs. Fill one section per scenario.

---

Run metadata
- Date: YYYY-MM-DD
- Agent / Tester: <name or agent-id>
- Environment: (Browser & version, OS, served via http/file)
- URL: (e.g., http://localhost:8000/datetime-utilities.html)
- Fixtures used: (list file paths)

---

Scenario report
- Scenario ID: <e.g., datetime-001>
- Title: <short description>
- Steps performed (concise):
  1. Step
  2. Step
- Snippet used (paste the JS snippet executed):

```
<paste snippet here>
```

- Expected:
  - <what should happen>
- Actual:
  - <what happened>
- Result: PASS / FAIL
- Artifacts:
  - Screenshot: <path or filename>
  - Console logs: <path or pasted excerpt>
  - Files captured (e.g., blobs): <details>
- Notes / deviation / follow-ups:
  - <notes>

---

Summary
- Total scenarios run: N
- Passed: X
- Failed: Y
- Blockers: <list any blockers like file:// fetch blocked, missing worker, browser restriction>
- Recommended next steps: <fixes, retries, which browser to test next>

---

Instructions
- Save this filled report into the test run folder (e.g. `tests/runs/<timestamp>/report.md`) and include screenshots and logs.
- If an automated agent performed the run, attach logs and the command-line invocation used.

