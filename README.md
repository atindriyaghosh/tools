# Tools

A collection of single-file, browser-based utility tools built with vanilla JavaScript and Pico CSS.

## Overview

This repository contains standalone HTML tools for common tasks like PDF conversion, date/time manipulation, and more. Each tool is a self-contained HTML file with no build step required.

**Browse all tools at [atindriyaghosh.com](https://atindriyaghosh.com)**

## Tech Stack

- **Styling**: [Pico CSS](https://picocss.com/) via CDN
- **JavaScript**: Vanilla JS only, no frameworks
- **Deployment**: GitHub Pages

## Local Development

To preview the tools locally:

```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

Then open `http://127.0.0.1:8000/` in your browser.

## Current Tools

### PDF Tools
- **PDF to Image Converter** - Converts PDF pages to PNG or JPEG images with page selection

### Date/Time Tools
- **Timezone Converter** - Converts dates and times between timezones with DST information
- **Unix Timestamp Converter** - Converts between Unix timestamps and human-readable dates
- **DateTime Format Converter** - Parses and reformats date/time strings with custom patterns

## Development

See `.dev/CLAUDE.md` for development workflow and guidelines.
