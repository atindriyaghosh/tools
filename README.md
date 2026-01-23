# Tools

A collection of single-file, browser-based utility tools built with vanilla JavaScript and Pico CSS.

## Overview

This repository contains **20 standalone HTML tools** for common tasks like PDF conversion, date/time manipulation, text processing, and more. Each tool is a self-contained HTML file with no build step required.

## Current Tools

**Browse all tools at [atindriyaghosh.com](https://atindriyaghosh.com)**

### AI Tools
- **AI Landscape Explorer** - Interactive exploration of AI development tools and concepts with AI-generated insights and web search

### Date/Time Tools
- **Timezone Converter** - Convert dates and times between timezones with DST information
- **Unix Timestamp Converter** - Convert Unix timestamps to human-readable dates and vice versa
- **DateTime Format Converter** - Parse and reformat date/time strings using custom or standard formats
- **Date Calculator** - Calculate differences between dates or add/subtract time periods

### Text Tools
- **Text to NATO Phonetic Alphabet** - Convert text to NATO phonetic alphabet (Alpha, Bravo, Charlie...) for clear communication
- **Base64 Encoder/Decoder** - Encode text to Base64 format or decode Base64 strings back to plain text
- **Hash Generator** - Generate MD5, SHA1, SHA256, and other hash values from text input
- **JSON/XML/YAML Converter** - Convert between JSON, XML, and YAML formats with instant validation
- **JSON/XML/YAML Formatter** - Format and prettify JSON, XML, and YAML with syntax highlighting
- **Markdown Editor** - Write and preview markdown in real-time with live HTML conversion
- **Regex Tester** - Test regular expressions against text with real-time matching and capture groups
- **Text Case Converter** - Convert text between case formats (camelCase, snake_case, kebab-case, PascalCase, etc.)

### PDF Tools
- **PDF to Image Converter** - Convert PDF pages to PNG or JPEG images with page selection
- **Merge PDFs** - Combine multiple PDF files into a single document with drag-and-drop reordering
- **Extract Text from PDF** - Extract text content from PDFs with plain text or markdown output

### API Tools
- **HTTP Status Codes** - Reference guide for HTTP status codes with descriptions and meanings

### Other Tools
- **Cron Expression Generator** - Create and test cron expressions with an intuitive UI
- **Unit Converter** - Convert between different units (length, weight, temperature, and more)
- **UUID Generator** - Generate UUID v4 identifiers and copy them easily

## Tech Stack

- **Styling**: [Pico CSS](https://picocss.com/) via CDN
- **JavaScript**: Vanilla JS only, no frameworks
- **Deployment**: GitHub Pages

## Libraries Used

- **[Pico CSS v2](https://picocss.com/)** - Minimal CSS framework used across all tools
- **[PDF.js v3.11.174](https://mozilla.github.io/pdf.js/)** - PDF rendering for PDF tools
- **[pdf-lib v1.17.1](https://pdf-lib.js.org/)** - PDF manipulation for merging PDFs
- **[Sortable.js v1.15.0](https://sortablejs.github.io/Sortable/)** - Drag-and-drop reordering for PDF merge
- **[js-yaml v4.1.0](https://github.com/nodeca/js-yaml)** - YAML parsing and generation for data converters
- **[marked v11.1.1](https://marked.js.org/)** - Markdown parsing for markdown editor and AI landscape explorer
- **[croner v8](https://croner.dev/)** - Cron expression parsing and validation
- **[spark-md5 v3.0.2](https://github.com/satazor/js-spark-md5)** - Fast MD5 hashing for hash generator

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
