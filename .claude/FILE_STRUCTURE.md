# File Structure

- **Root directory**: Tool HTML files only (e.g., `tool-name.html`)
- **`common-styles.css`**: Shared styling in root, referenced by all tools
- **`.dev/` directory**: Development files (CLAUDE.md, other docs) - not web-accessible
- `.dev/` is auto-excluded by GitHub Pages (directories starting with `.` are hidden from web)

## Naming Conventions

- Tool files: lowercase with hyphens (e.g., `pdf-to-image.html`, `timezone-converter.html`)
- Tool names in UI: Title Case (e.g., "PDF to Image Converter", "Timezone Converter")
