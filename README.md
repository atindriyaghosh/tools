# Tools

A collection of single-file, browser-based utility tools built with vanilla JavaScript and Pico CSS.

## Overview

This repository contains standalone HTML tools for common tasks like PDF conversion, date/time manipulation, and more. Each tool is a self-contained HTML file with no build step required.

## Current Tools

**Browse all tools at [atindriyaghosh.com](https://atindriyaghosh.com)**

### PDF Tools
- **PDF to Image Converter** - Converts PDF pages to PNG or JPEG images with page selection
- **Merge PDFs** - Combines multiple PDF files into a single document with drag-and-drop reordering
- **Extract Text from PDF** - Extracts text content from PDFs with plain text or markdown output

### Date/Time Tools
- **Timezone Converter** - Converts dates and times between timezones with DST information
- **Unix Timestamp Converter** - Converts between Unix timestamps and human-readable dates
- **DateTime Format Converter** - Parses and reformats date/time strings with custom patterns
- **Date Calculator** - Calculates differences between dates or adds/subtracts time periods from a date

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

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Development

See `.claude/CLAUDE.md` for development workflow and guidelines.
