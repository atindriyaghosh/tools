# Static Verification Report — tests (no browser run)

Date: 2025-12-24
Run by: Git automation (static checks only)

Summary: I verified that scenario docs and fixture files exist and include the console snippets and helper functions required for an agent to run tests manually. I could not run browser-based scenarios here because this environment cannot drive a browser to execute in-page snippets or simulate file uploads/downloads from the local GUI.

Checks performed
- Presence of per-tool scenario files:
  - `tests/index.md` — OK
  - `tests/pdf-to-image.md` — OK
  - `tests/datetime-utilities.md` — OK
- Presence of fixtures:
  - `tests/fixtures/pdf-to-image/sample-1page.pdf` — OK
  - `tests/fixtures/pdf-to-image/sample-2page.pdf` — OK
  - `tests/fixtures/pdf-to-image/sample-3page.pdf` — OK
  - `tests/fixtures/datetime-utilities/sample-timestamps.json` — OK
- Console helper snippets and scenario snippets present (looked for `waitForText`, `uploadFixture`, `__createdBlobs`) — OK
- `tests/AGENT_RUN.md` added and includes run flow and pass/fail criteria — OK
- `tests/RUN_TEMPLATE.md` added for standardized reporting — OK

Limitations / Next steps for a real run
1. Run the scenarios in a browser (preferably via HTTP server):
   - Start server: `python -m http.server 8000`
   - Open `http://localhost:8000/index.html` in a browser and follow `tests/AGENT_RUN.md` and the per-scenario snippets.
2. For each scenario, paste the helper block into DevTools Console once, then paste the scenario snippet and capture artifacts as described in `RUN_TEMPLATE.md`.
3. Save each run report to `tests/runs/<timestamp>/report.md` and attach screenshots & logs.

If you'd like, I can also:
- Add a small shell helper `scripts/open-and-capture` that opens a URL in the default browser (OS dependent) to help start manual runs, or
- Add a sample filled `tests/runs/example-run/report.md` demonstrating the expected format.

