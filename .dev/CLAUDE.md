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

## Tech Stack

- **Framework**: None - vanilla JavaScript only
- **No React, Vue, or any JS frameworks** - keep it simple with plain HTML/JS
- **CSS**: Pico CSS (https://picocss.com/) for minimal, lightweight styling
- **Design**: Clean, minimal, functional - performance over visual flair
- **Single Responsibility**: Each tool does ONE thing well
- **Deployment**: GitHub Pages

## File Structure

- **Root directory**: Tool HTML files only (e.g., `tool-name.html`)
- **`.dev/` directory**: Development files (CLAUDE.md, specs, etc.) - not web-accessible
- **`common-styles.css`**: Shared styling in root, referenced by all tools
- `.dev/` is auto-excluded by GitHub Pages (directories starting with `.` are hidden from web)

## Design System: Pico CSS

- Use semantic HTML with minimal classes
- Leverage Pico's built-in form styling and components
- Light mode only (data-theme="light")
- File size: ~10KB CSS, zero JS framework overhead
- CDN: `<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">`

### Color Scheme
- **Link/accent color**: Soft blue (#6b8dd6)
- **Button color**: Soft blue (#6b8dd6)
  - Hover state: Darker soft blue (#5b7dc6)
  - Disabled state: Light soft blue (#9baee6)
- **Badge/Count badges**: White text on soft blue background (#6b8dd6)
- All common color styling is included in `common-styles.css` and automatically applied to all pages
- Consistent with the landing page (index.html) for a unified visual experience
- No need to add color overrides to individual tool pages - the common stylesheet handles all standard styling

### Visual Design Consistency Guidelines
To maintain visual consistency across all pages:

1. **Spacing & Layout**:
   - Tool cards: 0.5rem padding, 0.5rem gap
   - Search box: 0.4rem 0.75rem padding
   - Section headers: 0.75rem top margin, 0.4rem bottom margin
   - Back links: 0.4rem 0.6rem padding

2. **Typography**:
   - Section titles: 1.25rem, bold (font-weight: 700)
   - Card titles: 0.9rem, bold (font-weight: 600)
   - Card descriptions: 0.75rem, muted color, line-height 1.3
   - TOC/search: 0.85rem
   - Placeholder text: italic

3. **Colors** (all pages):
   - Primary accent: #6b8dd6 (soft blue) for links, buttons, badges
   - Hover: #5b7dc6 (darker soft blue)
   - Disabled: #9baee6 (light soft blue) with 0.6 opacity
   - Backgrounds: inherit from Pico CSS defaults (light backgrounds)

4. **Interactions**:
   - All transitions: 0.2s duration
   - Hover effects: subtle background changes, color adjustments
   - No aggressive animations or visual effects
   - Back links: inline-flex layout for proper icon/text alignment

5. **Responsive Design**:
   - Grid uses auto-fill with minmax(200px, 1fr)
   - Flex layouts wrap on smaller screens
   - All padding/spacing scales proportionally

## Tool Template Structure

Each tool is a single, self-contained HTML file in the root directory:
- External libraries via CDN only (https://cdnjs.cloudflare.com)
- **Always reference `common-styles.css`** for standard styling (links, buttons, results, back-links)
- Tool-specific CSS only in inline `<style>` tags (custom layouts, unique colors, etc.)
- All JS inline in `<script>` tags
- localStorage/sessionStorage allowed when appropriate
- Plain vanilla JavaScript - no frameworks

### CSS Structure for Tools
1. **Pico CSS**: `<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">`
2. **Common styles**: `<link rel="stylesheet" href="common-styles.css">` (buttons, links, back-links, result boxes, timezone lists)
3. **Tool-specific styles**: Inline `<style>` tags for custom layouts and unique styling

## Standard Features to Include

Every tool must have:
1. **Back link**: Link to index.html (e.g., `<a href="index.html">← Back to Tools</a>`)
2. **File size limits**: Display max file size in UI, validate on upload
3. **Error handling**: Clear error messages using Pico's styling
4. **Loading states**: Inform users during processing
5. **Semantic HTML**: Use `<main>`, `<article>`, `<hgroup>`, etc.
6. **Accessibility**: Proper labels, ARIA attributes where needed
7. **Tool Name Format**:
   - Use Title Case (e.g., "Timezone Converter", "Unix Timestamp Converter")
   - No icons or emojis in tool names or page titles
   - Keep tool names clear and descriptive
   - Consistent naming across:
     - HTML `<title>` tag
     - Page `<h1>` heading
     - Landing page tool card title

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

## Browser APIs for Common Tasks

### PDF Manipulation
- **Library**: pdf.js (https://cdnjs.cloudflare.com/ajax/libs/pdf.js/)
- **Use for**: Rendering PDFs, extracting pages, converting to images
- **Setup**: `pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js'`

### Image Processing
- **API**: Canvas API (native browser)
- **Use for**: Format conversion, compression, resizing, manipulation
- **Example**: `canvas.toBlob(callback, 'image/png', quality)`

### File Handling
- **API**: File API (native browser)
- **Use for**: Reading files, creating downloads
- **Example**: `FileReader`, `URL.createObjectURL()`, `Blob`

### Date/Time Operations
- **API**: Date object and Intl (native browser)
- **Use for**: Date calculations, timezone conversions, formatting
- **Example**: `Intl.DateTimeFormat`, `Date` methods

### PDF Generation
- **Libraries**: jsPDF or pdfmake (via CDN)
- **Use for**: Creating PDFs from content (e.g., markdown to PDF)

### Markdown Parsing
- **Libraries**: marked.js or showdown.js (via CDN)
- **Use for**: Converting markdown to HTML

### API Calls
- **API**: Fetch API (native browser)
- **Use for**: Calling external APIs (e.g., OpenRouter for LLMs)
- **Security**: User provides API key, store in localStorage or pass per-request

## Tool Categories

Organize tools into these categories on the landing page:
- **PDF Tools**: PDF manipulation, conversion, extraction
- **Image Tools**: Image format conversion, compression, editing
- **Date/Time Tools**: Date calculations, timezone conversions
- **Text Tools**: Markdown processing, text manipulation
- **API Tools**: LLM interfaces, external API integrations
- **Other**: Miscellaneous utilities

## Landing Page Structure

The index.html layout consists of:
- **Header**: "Tools" title with subtitle
- **Table of Contents**: Category links with tool count badges (auto-hide empty categories)
- **Search box**: Real-time tool filtering by title and description
- **Tool sections**: Organized by category, each with a grid of tool cards
- **Tool cards**: Link, title, and brief description (see Visual Design Consistency for styling details)

## Tool Page Structure

All tool pages follow this structure:
- Use `.container` class from Pico CSS for main container
- Include `<hgroup>` with title and subtitle
- Use semantic HTML: `<section>`, `<article>`, `<fieldset>`, `<main>`
- Include back navigation at top and bottom (see Common Patterns)
- Tool-specific styling goes in inline `<style>` tags (layout, unique interactions, etc.)
- Reference `common-styles.css` for all standard colors and component styling

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
- [ ] common-styles.css is referenced (for buttons, links, back-links, result boxes)
- [ ] Back navigation to index.html present (top and bottom)
- [ ] File size limits displayed and enforced
- [ ] Error messages are clear and helpful
- [ ] Loading states inform user during processing
- [ ] Follows Pico CSS styling conventions
- [ ] Works on mobile (responsive)
- [ ] Tool card added to index.html in correct category
- [ ] localStorage usage (if any) is documented in code

### Visual Design Checklist
- [ ] Tool name uses Title Case (no icons/emojis)
- [ ] Consistent color scheme: soft blue (#6b8dd6) for links/buttons
- [ ] Back links styled with `.back-link` class (padding, border-radius, hover effects)
- [ ] All buttons use soft blue color scheme with proper hover/disabled states
- [ ] Spacing and padding match guidelines (0.4rem-1rem range)
- [ ] Typography follows font size guidelines (0.75rem-1.25rem range)
- [ ] Transitions set to 0.2s for all interactive elements
- [ ] Page title matches landing page tool card title exactly
- [ ] No icons/emojis in page headings or tool names

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