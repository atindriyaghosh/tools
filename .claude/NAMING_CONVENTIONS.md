# Naming Conventions

This document consolidates all naming conventions for files, directories, variables, and UI elements across the project.

**Cross-references**: See @./FILE_STRUCTURE.md for file organization and @./CODING_STYLE.md for code style.

## File Naming

**Tool files**: lowercase with hyphens
- Examples: `pdf-merge.html`, `timezone-converter.html`, `unix-timestamp.html`
- NOT: `PDFMerge.html`, `pdf_merge.html`, `pdfmerge.html`

**Directory names**: lowercase with hyphens, start with dot for hidden
- Hidden directories: `.claude/`, `.github/`, `.brainstorm/`
- NOT: `.Claude/`, `claude/`, `_claude/`

## Tool Names in UI

**Tool names in UI**: Title Case (no emojis in title)
- Examples: "PDF Merge", "Timezone Converter", "Unix Timestamp Converter"
- NOT: "pdf merge", "TIMEZONE CONVERTER", "📄 PDF Merge"

**Consistency requirement**: Tool names must match EXACTLY across:
- HTML `<title>` tag (page title)
- `<h1>` heading on tool page
- Tool card link on landing page

**Tool name rules:**
- Use Title Case (capitalize first letter of each word)
- Keep names clear and descriptive (searchable keywords)
- No emojis or icons in HTML `<title>` or `<h1>` tags

## Emoji Usage

**In HTML `<title>` and `<h1>` tags**: Never use emojis
- Emojis must not appear in page titles or headings
- Tool names should be text only: "PDF Merge", not "📄 PDF Merge"

**In tool card descriptions (landing page)**: Optional, for visual interest only
- Example: "📄 Combine multiple PDF files into a single document"
- Emoji is decorative only, not part of the official tool title
- Card descriptions can include emojis for user appeal

**In tool UI and tool interfaces**: Avoid emojis completely
- Don't use emojis in status messages, labels, buttons, or displays
- Use clear text labels instead: "Warning: high usage" not "⚠️"
- Use color and styling to indicate status (red for errors, green for success)
- Use icon libraries (if visual indicators are necessary) instead of emojis
- Examples to avoid: "✅ Complete", "⚠️ Warning", "❌ Error"

## Variable Naming

**Use concise names when context is clear:**
```javascript
// ✅ Good - context is obvious (in event handler)
document.addEventListener('click', (e) => {
    const el = e.target;
    console.log(el);
});

// ✅ Good - loop variable
for (let i = 0; i < items.length; i++) {
    processItem(items[i]);
}

// ✗ Avoid - unclear abbreviation
const f = processedFileData;
const dp = calculateDateParts;
```

**Use descriptive names for important variables:**
```javascript
// ✅ Good - clear what the data represents
const uploadedFiles = fileInput.files;
const totalFileSize = sum(files.map(f => f.size));
const isFileTooLarge = totalFileSize > MAX_SIZE;

// ✗ Avoid - too vague
const data = fileInput.files;
const size = getTotalSize();
const ok = checkSize();
```

**Naming patterns:**
- `const by default, let only for reassignments`
- ALL_CAPS for constants: `MAX_FILE_SIZE`, `UPLOAD_TIMEOUT`
- camelCase for variables and functions: `uploadedFiles`, `processFile()`
- Booleans start with "is", "has", "can": `isFileTooLarge`, `hasError`

## Function Naming

**Use descriptive action verbs:**
```javascript
// ✅ Good - clear what function does
function validateFileSize(file) { ... }
function showStatus(message, isError) { ... }
function downloadFile(bytes, filename) { ... }

// ✗ Avoid - vague or unclear
function handle(file) { ... }
function process(x) { ... }
function run() { ... }
```

**Best practices:**
- Start with action verbs: validate, process, show, download, upload, format
- Be specific: `showStatus()` not `show()`
- Match what the function does

## CSS Class Naming

**Use kebab-case (lowercase with hyphens):**
```css
/* ✅ Good */
.upload-area { }
.status-message { }
.error-text { }
.drag-over { }

/* ✗ Avoid */
.uploadArea { }           /* camelCase */
.upload_area { }          /* snake_case */
.UploadArea { }           /* PascalCase */
.upload-area-button { }   /* too specific, non-reusable */
```

**Class naming patterns:**
- Descriptive state classes: `active`, `disabled`, `visible`, `error`, `success`, `loading`
- Component-focused: `upload-area`, `file-input`, `progress-bar`, `status-message`
- Generic styling: Use `common-styles.css` for shared styles (buttons, links, results)

## ID Naming

**Use camelCase for IDs:**
```html
<!-- ✅ Good -->
<div id="uploadArea">...</div>
<button id="downloadBtn">...</button>
<article id="statusMessage"></article>

<!-- ✗ Avoid -->
<div id="upload_area">...</div>
<button id="DownloadBtn">...</button>
<article id="status-message"></article>
```

## Category Organization

**Landing page tool categories**: See @./LANDING_PAGE.md for the authoritative list of tool categories and organization guidelines.

## Related Documentation

For implementation details:
- File structure overview: @./FILE_STRUCTURE.md
- Code style guidance: @./CODING_STYLE.md
- Standard features: @./STANDARD_FEATURES.md
- HTML template: @./TOOL_TEMPLATE.md
