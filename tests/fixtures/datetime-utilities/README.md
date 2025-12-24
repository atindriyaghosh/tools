# datetime-utilities fixtures

This folder contains fixtures used for testing `datetime-utilities.html`.

Files:
- `sample-timestamps.json` — array of example timestamps and notes, useful for validating Unix timestamp conversions and format parsing/formatting.

Usage:
- Serve the `tools` folder via a local web server (for example `python -m http.server 8000`) and open `http://localhost:8000/datetime-utilities.html`.
- Use the values from `sample-timestamps.json` to verify timestamp input parsing and output formatting in different time zones.

Selectors & notes for agents:
- Timestamp input: `#tsInput` and unit select `#tsUnit`.
- Timestamp output area: `#tsToDateResult`.
- Date input for conversion to Unix: `#dateInput`, source timezone: `#dateSrcTz`, output area: `#dateToTsResult`.
- Format converter input: `#formatInputText`, input format `#inputFormat`, output format `#outputFormat`, timezone `#formatTz`, result `#formatResult`.

Example test flow (manual):
1. Open `datetime-utilities.html` in your browser.
2. Load `tests/fixtures/datetime-utilities/sample-timestamps.json` and pick a timestamp value (e.g., `1690000000`).
3. Enter it into `#tsInput`, choose unit if necessary, set `#tsOutTz` to `UTC`, click "Convert to Date" and verify the ISO output matches the expected ISO in the fixture file.

Notes:
- Browser `Intl` implementations may differ slightly; cross-check offsets using an authoritative source (IANA TZ database, timeanddate.com).
- For automated agents wanting to run these checks headlessly, use a browser automation tool like Playwright or Puppeteer and assert on the DOM values in the result areas.