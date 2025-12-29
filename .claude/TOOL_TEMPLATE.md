# Tool Template Structure

Each tool is a single, self-contained HTML file in the root directory:
- External libraries via CDN only (https://cdnjs.cloudflare.com)
- **Always reference `common-styles.css`** for standard styling (links, buttons, results, back-links)
- Tool-specific CSS only in inline `<style>` tags (custom layouts, unique interactions)
- All JS inline in `<script>` tags
- localStorage/sessionStorage allowed when appropriate
- Plain vanilla JavaScript - no frameworks

## CSS Structure for Tools

1. **Pico CSS**: `<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">`
2. **Common styles**: `<link rel="stylesheet" href="common-styles.css">`
3. **Tool-specific styles**: Inline `<style>` tags for custom layouts and unique styling

## HTML Structure

```html
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tool Name</title>
    <link rel="shortcut icon" type="image/png" href="favicon.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">
    <link rel="stylesheet" href="common-styles.css">
    <style>
        /* Tool-specific styles only */
    </style>
</head>
<body>
    <main class="container">
        <p style="margin-bottom: 1rem;"><a href="index.html" class="back-link">← Back to Tools</a></p>
        <hgroup>
            <h1>Tool Name</h1>
            <p>Brief description</p>
        </hgroup>

        <!-- Tool content -->

        <p style="margin-top:1rem"><a href="index.html" class="back-link">← Back to Tools</a></p>
    </main>
    <script>
        // Tool-specific JavaScript
    </script>
</body>
</html>
```

## Styling Notes

- All color styling (links, buttons, hover states) is handled by `common-styles.css`
- Do not duplicate common styles in tool-specific CSS
- Only add CSS for custom layouts, animations, or tool-specific interactions
- Use Pico CSS variables where available (e.g., `var(--pico-border-radius)`, `var(--pico-card-background-color)`)

## PDF Tools - Upload Area & Status Div Best Practices

**For tools with file uploads (especially PDF tools):**

### Upload Area Styling (Consistent)
All file upload areas should use this standard sizing:
```css
.upload-area {
    padding: 0.75rem 1rem;           /* Compact, consistent sizing across all tools */
    margin-bottom: 0.75rem;          /* Space before status/controls */
    border: 2px dashed var(--pico-muted-border-color);
    border-radius: var(--pico-border-radius);
    cursor: pointer;
    transition: all 0.3s;
}

.upload-area:hover,
.upload-area.drag-over {
    border-color: #6b8dd6;
    background: rgba(107, 141, 214, 0.05);
}
```

### Status Div Placement (Critical for UX)
The status div must appear immediately after the upload area, NOT at the end of the form:

```html
<hgroup>
    <h1>Tool Title</h1>
    <p>Description</p>
</hgroup>

<!-- Upload area -->
<div class="upload-area" id="uploadArea">
    <p>📄 Drop file here or click to upload</p>
    <p>Details about file requirements</p>
    <input type="file" id="fileInput" accept=".pdf">
</div>

<!-- Status div MUST come immediately after upload area -->
<article id="status"></article>

<!-- Controls and preview sections come after -->
<article id="controls">
    <!-- Tool controls and PDF preview go here -->
</article>
```

**Why this matters:**
- Users see upload errors/status immediately (not scrolled off-screen)
- Keeps feedback prominent and easily viewable
- Consistent UX across all tools (pdf-merge, pdf-text-extract, pdf-to-image, pdf-form-editor, etc.)

### PDF Byte Handling
If your tool processes PDFs, refer to PATTERNS.md → "PDF Byte Handling - CRITICAL" for proper ArrayBuffer/Uint8Array handling to avoid detached buffer errors.

## Handling Large Files

When building tools that process large files (> 10 MB):

### Streaming/Chunked Processing
```javascript
// For large file processing, avoid loading entire file into memory
async function processLargeFile(file, chunkSize = 1024 * 1024) {  // 1 MB chunks
    const chunks = [];
    let offset = 0;

    while (offset < file.size) {
        const chunk = file.slice(offset, offset + chunkSize);
        const arrayBuffer = await chunk.arrayBuffer();
        chunks.push(new Uint8Array(arrayBuffer));
        offset += chunkSize;

        // Update progress in UI
        updateProgress((offset / file.size) * 100);
    }

    return new Uint8Array(chunks.reduce((acc, chunk) => acc + chunk.length, 0));
}
```

### Progress Indicators
```javascript
function updateProgress(percent) {
    const progressBar = document.getElementById('progressBar');
    progressBar.style.width = percent + '%';
    document.getElementById('progressText').textContent = Math.round(percent) + '%';
}
```

### Best Practices
- ✓ Show progress during long operations (e.g., "Processing page 5 of 100")
- ✓ Disable buttons during processing to prevent duplicate submissions
- ✓ Allow user to cancel long-running operations (when possible)
- ✓ Consider worker threads for CPU-intensive tasks (pdf.js already does this)
- ✗ Don't process entire large files in main thread (UI will freeze)

## localStorage Usage Pattern

For persistent tool state (templates, preferences, history):

```javascript
// Save state
function saveToLocalStorage(key, data, maxAge = 30 * 24 * 60 * 60 * 1000) {  // 30 days default
    const record = {
        data: data,
        timestamp: Date.now(),
        expires: Date.now() + maxAge
    };
    try {
        localStorage.setItem(key, JSON.stringify(record));
        return true;
    } catch (e) {
        if (e.name === 'QuotaExceededError') {
            showStatus('Storage quota exceeded. Some data may not be saved.', true);
            return false;
        }
        throw e;
    }
}

// Load state
function loadFromLocalStorage(key) {
    try {
        const record = JSON.parse(localStorage.getItem(key));
        if (!record) return null;

        // Check if data has expired
        if (record.expires && Date.now() > record.expires) {
            localStorage.removeItem(key);
            return null;
        }

        return record.data;
    } catch (e) {
        console.error('Error loading from localStorage:', e);
        return null;
    }
}

// Clear old data
function cleanupOldData(prefix, maxAge = 30 * 24 * 60 * 60 * 1000) {
    const now = Date.now();
    for (let i = 0; i < localStorage.length; i++) {
        const key = localStorage.key(i);
        if (key?.startsWith(prefix)) {
            const record = JSON.parse(localStorage.getItem(key));
            if (record.expires && now > record.expires) {
                localStorage.removeItem(key);
            }
        }
    }
}
```

### Best Practices
- ✓ Include timestamps for data freshness tracking
- ✓ Set expiration dates for old data (prevent stale state)
- ✓ Handle `QuotaExceededError` when storage is full
- ✓ Validate loaded data (might be corrupted)
- ✓ Periodically cleanup old entries (call on tool load)
- ✗ Don't store sensitive data (passwords, tokens, private info)
- ✗ Don't rely solely on localStorage (warn users it can be cleared)

## Pre-Completion Checklist

After creating a new tool, verify:

### Functionality
- [ ] Tool does ONE thing well and does it correctly
- [ ] All major features work as designed
- [ ] Edge cases are handled (empty input, large files, special characters, etc.)
- [ ] Error messages are clear and helpful (not "Error: undefined")

### User Experience
- [ ] Status messages appear immediately after upload area (for file upload tools)
- [ ] Buttons are disabled during processing (prevent duplicate submissions)
- [ ] Feedback is clear: "Processing...", "Complete!", "Error: reason"
- [ ] No status/error messages disappear too quickly (minimum 2 seconds visible)
- [ ] Upload area uses consistent styling (padding: 0.75rem 1rem)

### Mobile & Responsive
- [ ] Works on mobile (viewport meta tag present)
- [ ] Test with DevTools mobile view (iPhone 12, Android)
- [ ] Buttons are clickable size (minimum 44x44px recommended)
- [ ] Long content doesn't overflow or create horizontal scroll
- [ ] All controls are accessible without pinch-to-zoom

### Performance & Memory
- [ ] No memory leaks (check DevTools memory profiler)
- [ ] Blob URLs are revoked after downloads (URL.revokeObjectURL)
- [ ] Large operations don't freeze UI (use async/await)
- [ ] Tool loads in < 2 seconds (excluding large file processing)

### Code Quality
- [ ] common-styles.css is referenced (not duplicate button styling)
- [ ] Tool-specific CSS is in inline `<style>` tags (not separate file)
- [ ] All JavaScript is vanilla (no frameworks)
- [ ] No console errors or warnings
- [ ] Code is readable and maintainable

### Navigation & Structure
- [ ] Back link to index.html present (top and bottom)
- [ ] Page title matches landing page tool card exactly
- [ ] Semantic HTML used (`<main>`, `<article>`, `<hgroup>`, etc.)
- [ ] Form fields have proper labels (accessibility)
- [ ] File inputs have appropriate `accept` attributes

### Documentation & Metadata
- [ ] localStorage usage documented in code comments (if applicable)
- [ ] Tool card added to index.html in correct category
- [ ] Tool description is clear and searchable (keywords in landing page)
- [ ] README.md updated with new tool entry (if applicable)

### Browser Testing
- [ ] [ ] Works in Chrome/Edge (Chromium)
- [ ] [ ] Works in Firefox
- [ ] [ ] Works in Safari (if possible)
- [ ] [ ] Clear cache between tests (can hide bugs)
