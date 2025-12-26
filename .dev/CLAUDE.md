# HTML Tools Portfolio

A collection of single-file, browser-based utility tools built with vanilla JavaScript and Pico CSS.

## Development Workflow

### Building a New Tool
1. **Ask clarifying questions** about requirements, UX, and implementation approach
2. **Ensure clarity** before writing code - understand exactly what needs to be built
3. Only proceed to implementation when convinced of the requirements
4. Create a new HTML file in root directory (e.g., `tool-name.html`)
5. Follow the patterns documented in this file (structure, styling, patterns)
6. Test locally, iterate as needed
7. Add tool card to appropriate category in index.html
8. Commit and push to GitHub
9. Tool automatically deploys via GitHub Pages

### Updating Existing Tools
1. **Ask questions** if requirements are unclear
2. Read the existing implementation first
3. Discuss approach and proposed changes before making modifications
4. Make incremental changes preserving working functionality
5. Test locally
6. Commit and push to GitHub

## Documentation

Detailed specifications are in separate files:
- **[TECH_STACK.md](TECH_STACK.md)** - Framework, languages, deployment
- **[FILE_STRUCTURE.md](FILE_STRUCTURE.md)** - Directory layout and naming conventions
- **[TOOL_TEMPLATE.md](TOOL_TEMPLATE.md)** - HTML structure and CSS organization
- **[STANDARD_FEATURES.md](STANDARD_FEATURES.md)** - Required features for each tool
- **[LANDING_PAGE.md](LANDING_PAGE.md)** - Homepage structure and categories

## Styling

- Use `common-styles.css` for all standard styling (buttons, links, back-links, result boxes)
- See `common-styles.css` for color scheme and component styling
- Tool-specific CSS goes in inline `<style>` tags (custom layouts, unique interactions only)
- Use semantic HTML with minimal classes
- Leverage Pico CSS built-in form styling
- Light mode only (data-theme="light")

## Common Patterns

### Back Navigation
Include at top and bottom of each tool page (styled automatically by `common-styles.css`):
```html
<p style="margin-bottom: 1rem;"><a href="index.html" class="back-link">← Back to Tools</a></p>
```

### File Upload with Validation
Validate file size before processing:
```javascript
if (file.size > 50 * 1024 * 1024) {
    showStatus('File too large: maximum 50 MB', true);
    return;
}
```

### Status Messages
Display messages with error state:
```javascript
function showStatus(message, isError) {
    status.textContent = message;
    status.className = 'visible';
    if (isError) status.setAttribute('aria-invalid', 'true');
}
```

## Code Style Preferences

- Use concise variable names (e, el, i, j) when context is clear
- Prefer async/await over promise chains
- Comment only when logic is non-obvious
- Keep functions small and focused
- Always validate user input
- Handle errors gracefully with clear messages

## Key Constraints

- **No build pipeline** - direct push to GitHub, no compilation
- **Single file per tool** - everything self-contained in root directory
- **Performance first** - lightweight, fast loading
- **Portable** - works anywhere with a browser
- **No frameworks** - vanilla JS only
- **Clean URLs** - Tools in root for `yourdomain.com/tool-name.html` paths

## Quality Checklist

Before considering a tool complete:
- [ ] Tool does ONE thing well
- [ ] Tool file is in root directory (not subdirectory)
- [ ] common-styles.css is referenced
- [ ] Back navigation to index.html present (top and bottom)
- [ ] Error messages are clear and helpful
- [ ] Loading states inform user during processing
- [ ] Works on mobile (responsive)
- [ ] Tool card added to index.html in correct category
- [ ] localStorage usage (if any) is documented in code
- [ ] Tool name uses Title Case (no icons/emojis)
- [ ] Page title matches landing page tool card title exactly

## Current Tools

### PDF Tools
- **PDF to Image Converter** (pdf-to-image.html)
  - Converts PDF pages to PNG or JPEG images
  - Supports page selection and format choice
  - File size limit: 50 MB

### Date/Time Tools
- **Timezone Converter** (timezone-converter.html)
  - Converts dates and times between IANA timezones
  - Supports both 12-hour (AM/PM) and 24-hour time formats with automatic conversion
  - Displays result in target timezone, UTC, and DST information
  - Responsive 2-column grid layout (desktop) / 1-column stack (mobile)

- **Unix Timestamp Converter** (unix-timestamp.html)
  - Converts Unix timestamps to human-readable dates
  - Converts dates to Unix timestamps (seconds/milliseconds)
  - Auto-detects or manually specifies timestamp units

- **DateTime Format Converter** (datetime-format-converter.html)
  - Parses and reformats date/time strings
  - Supports standard formats (ISO, RFC2822) and custom patterns
  - Token-based formatting (YYYY, MM, DD, HH, mm, ss)
  - Custom format support with timezone awareness

## Working with Claude Code

### When building a new tool:
1. Create the tool HTML file in the root directory (e.g., `tool-name.html`)
2. Reference `common-styles.css` for standard styling
3. Follow the patterns documented in this file
4. Structure: Pico CSS → common-styles.css → tool-specific styles
5. Update the "Current Tools" section in this file when adding new tools

### When iterating on existing tools:
1. Read the current implementation first
2. Understand the existing patterns
3. Make incremental changes preserving working functionality
4. Ensure `common-styles.css` is referenced (no duplicate styling)
5. Test locally before committing

## Notes

- This repo is deployed to GitHub Pages
- All tools must work client-side (no backend)
- Performance matters - keep files small and fast
- Favor simplicity over cleverness
- Development files in `.dev/` are not web-accessible but are in git
- Tool HTML files stay in root for clean GitHub Pages URLs