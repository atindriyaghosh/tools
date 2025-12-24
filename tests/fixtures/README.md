Fixtures for manual and automated tests

This directory contains sample PDF fixtures used for testing `pdf-to-image.html`.

Files included:
- `sample-1page.pdf` — single-page sample PDF
- `sample-2page.pdf` — two-page sample PDF
- `sample-3page.pdf` — three-page sample PDF
- `sample-timestamps.json` — Example timestamps and expected ISO strings (UTC) useful for timestamp conversion tests.

Usage:
- Serve the `tools` folder via a local web server (for example `python -m http.server 8000`) and open `http://localhost:8000/pdf-to-image.html`.
- Use `sample-3page.pdf` to validate thumbnail rendering, page selection, conversion, and downloads.

Notes for agents and testers:
- Files are included in the repository to simplify manual and automated testing.
- If you need different PDFs, create them locally and place them in this folder.