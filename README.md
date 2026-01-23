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

### Text & Data Tools
- **Text Case Converter** - Converts text between case formats (camelCase, snake_case, kebab-case, PascalCase, etc.)
- **Markdown Editor** - Write and preview markdown with real-time conversion to HTML
- **NATO Phonetic Converter** - Converts text to NATO phonetic alphabet spelling

### Development & Code Tools
- **Regex Tester** - Test and debug regular expressions with pattern matching and flags
- **Cron Expression Generator** - Generate and explain cron expressions for scheduled tasks
- **Hash Generator** - Generate MD5, SHA1, SHA256, and SHA512 hashes from text or files
- **UUID Generator** - Generate v4 UUIDs with one-click copying

### Data Format Tools
- **JSON/XML/YAML Converter** - Convert between JSON, XML, and YAML formats
- **JSON/XML/YAML Formatter** - Format, validate, and beautify JSON, XML, and YAML data
- **Base64 Encoder/Decoder** - Encode text to Base64 or decode Base64 strings
- **Unit Converter** - Convert between units (length, weight, temperature, etc.)

### Reference Tools
- **HTTP Status Codes** - Reference guide for HTTP status codes with descriptions
- **AI Landscape Explorer** - Explore the AI/ML tools and models landscape

## Tech Stack

- **Styling**: [Pico CSS](https://picocss.com/) via CDN
- **JavaScript**: Vanilla JS only, no frameworks
- **Deployment**: GitHub Pages

## Libraries Used

- **[Pico CSS v2](https://picocss.com/)** - Minimal CSS framework
- **[PDF.js v3.11.174](https://mozilla.github.io/pdf.js/)** - PDF rendering
- **[pdf-lib v1.17.1](https://pdf-lib.js.org/)** - PDF manipulation
- **[Sortable.js v1.15.0](https://sortablejs.github.io/Sortable/)** - Drag-and-drop reordering

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
