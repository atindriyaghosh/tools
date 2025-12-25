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

## Contributing

Tool specifications are maintained in `.dev/specs/`. See `.dev/CLAUDE.md` for development guidelines.
