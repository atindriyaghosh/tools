# Tools

A small collection of web-based utilities.

## Date/Time Tools 🕒

The original `datetime-utilities.html` was split into focused pages:

- **`timezone-converter.html`** — Convert a wall time between IANA timezones and inspect DST information. 🕒
- **`unix-timestamp.html`** — Convert Unix timestamps to human-readable dates and convert dates to Unix timestamps (seconds/ms). 🔁
- **`datetime-format-converter.html`** — Parse and reformat date/time strings using built-in or custom patterns (tokens: `YYYY`, `MM`, `DD`, `HH`, `mm`, `ss`). 🔤

Each page is self-contained (HTML + JS). If you prefer, common helper functions can be extracted into a shared script (e.g., `datetime-common.js`) to reduce duplication.

## Serving locally

To preview the tools locally, run:

```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

Then open `http://127.0.0.1:8000/` in your browser and click the tool you want.

## Notes

- The UI uses Pico CSS from the CDN.
- The timezone list is populated from the browser's `Intl` APIs when available.

---

(If you want, I can extract shared functions into `datetime-common.js` and update each page to import it.)