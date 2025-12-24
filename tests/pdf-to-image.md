# Manual Test Scenarios — pdf-to-image.html

Purpose: Verify the PDF → Image converter works: upload/drag-and-drop, thumbnail generation, page selection, conversion/download, and error handling. Includes selectors and run context for agents.

Run context:
- Serve `tools` folder via `python -m http.server 8000` and open `http://localhost:8000/pdf-to-image.html`.
- Use a browser with PDF.js support (Chrome/Firefox). For manual testing, use headful mode to validate downloads.
- Helpful selectors:
  - Upload area: `#uploadArea`
  - Hidden file input: `#fileInput`
  - Controls area: `#controls` (visible after loading a PDF)
  - Page grid: `#pageGrid`
  - Page items: `.page-item` (each has `data-page-num`)
  - Select all / deselect all: `#selectAllBtn`, `#deselectAllBtn`
  - Convert button: `#convertBtn`
  - Status area: `#status`

Scenarios:

## 1) Load a small PDF and render thumbnails
- Steps:
  1. Open the page.
  2. Upload a small multi-page PDF (e.g., 3 pages) via `#fileInput` or drag onto `#uploadArea`.
- Expected:
  - The status shows "Loading PDF..." then "PDF loaded: 3 pages".
  - `#controls` becomes visible and three `.page-item` elements appear in `#pageGrid`.

## 2) Select pages and convert
- Steps:
  1. Click a couple of `.page-item` elements to select pages (they get `.selected`).
  2. Choose output format (PNG/JPEG) and click `#convertBtn`.
- Expected:
  - The status indicates conversion progress (e.g., "Converting 2 page(s)...").
  - Downloads for selected pages are triggered (browser download behavior may require manual confirmation depending on settings).

## 3) Select all / deselect all
- Steps:
  1. Click `#selectAllBtn` then check that all `.page-item` are `.selected`.
  2. Click `#deselectAllBtn` and verify none are selected.
- Expected:
  - Buttons update selection as expected and `#convertBtn` disabled state reflects selection.

## 4) File size limit handling
- Steps:
  1. Attempt to upload a PDF larger than 50 MB.
- Expected:
  - `#status` displays an error with file size information and the file is not processed.

## 5) Non-PDF upload handling
- Steps:
  1. Upload a `.txt` or `.png` file.
- Expected:
  - `#status` shows "Please upload a PDF file" and no thumbnails are generated.

## 6) Edge cases & performance
- Steps:
  1. Try a large but valid PDF (many pages) and observe rendering throughput.
- Expected:
  - Thumbnails render progressively; UI remains responsive. Consider increasing thumbnail scale or providing paging if very large documents are common.

Notes for agents:
- When testing downloads in automated agents, downloads might not be accessible or may require special browser flags; instead, validate that the code creates a blob URL and triggers a link click or that status updates indicate success.
- To simulate drag-and-drop in browser automation, dispatch `dragenter`, `dragover`, and `drop` events with a DataTransfer containing a File object.

---

Sample test PDFs are included in `tests/fixtures/` (e.g. `sample-3page.pdf`) to make manual or automated testing easier.