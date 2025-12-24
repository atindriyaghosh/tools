# pdf-to-image fixtures

This folder contains PDF files used for testing `pdf-to-image.html`.

Files:
- `sample-1page.pdf` — single-page sample PDF
- `sample-2page.pdf` — two-page sample PDF
- `sample-3page.pdf` — three-page sample PDF

Usage:
- Serve the `tools` folder via a local web server (for example `python -m http.server 8000`) and open `http://localhost:8000/pdf-to-image.html`.
- Upload `tests/fixtures/pdf-to-image/sample-3page.pdf` (or drag onto the upload area) to validate thumbnail generation, page selection, and conversion/download behavior.

Notes for agents:
- For automated tests that cannot validate downloads directly, assert that the UI shows conversion progress and success messages and/or that a blob URL is created for each converted page.
- If you need fixtures with different page counts/sizes, create PDFs and place them in this folder.
