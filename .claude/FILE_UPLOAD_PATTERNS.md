# File Upload Patterns

This document consolidates file upload and status patterns used across tools. It is the canonical source for implementing file uploads consistently.

**Cross-references**: See @./TOOL_TEMPLATE.md for HTML structure and @./STANDARD_FEATURES.md for validation requirements.

## Upload Area Styling (Consistent)

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

## Status Div Placement (Critical for UX)

The status div must appear immediately after the upload area, NOT at the end of the form:

```html
<hgroup>
    <h1>Tool Title</h1>
    <p>Description</p>
</hgroup>

<!-- Upload area -->
<div class="upload-area" id="uploadArea">
    <p>Drop file here or click to upload</p>
    <p>Details about file requirements</p>
    <input type="file" id="fileInput" accept=".pdf">
</div>

<!-- Status div MUST come immediately after upload area -->
<article id="status"></article>

<!-- Controls and preview sections come after -->
<article id="controls">
    <!-- Tool controls and file preview go here -->
</article>
```

**Why this matters:**
- Users see upload errors/status immediately (not scrolled off-screen)
- Keeps feedback prominent and easily viewable
- Consistent UX across all tools (pdf-merge, pdf-text-extract, pdf-to-image, pdf-form-editor, etc.)

## Status Messages

**For showStatus() function implementations and best practices, see @./ERROR_HANDLING_GUIDE.md#status-message-display**.

Best practices summary:
- Include specific details (what went wrong, why, how to fix)
- Show errors prominently (don't use small gray text)
- Keep errors visible long enough to read (minimum 2-3 seconds)
- Show progress: "Processing page 1 of 10" (not just "Loading...")
- Disable buttons during processing (prevent duplicate submissions)

## File Validation

Validate file size before processing:

```javascript
if (file.size > 50 * 1024 * 1024) {
    showStatus('File too large: maximum 50 MB', true);
    return;
}
```

Validation checklist:
- Validate both FILE SIZE and FILE TYPE (not just size alone)
- Show user-friendly errors: "File too large: 120 MB. Maximum 50 MB."
- Show file type errors: "Only PDF files are supported, got DOCX"
- Display max file size in UI upfront
- Validate on upload

## PDF Byte Handling - CRITICAL

**IMPORTANT**: When storing PDF bytes from `file.arrayBuffer()` and later passing to PDFLib, must create a proper copy to avoid "detached ArrayBuffer" errors.

### Correct - Proper copy of Uint8Array
```javascript
// Store bytes from file upload
const arrayBuffer = await file.arrayBuffer();
const pdfBytes = new Uint8Array(arrayBuffer);  // Keep as Uint8Array

// Later, when passing to PDFLib for processing - CREATE PROPER COPY
let copyBytes;
if (pdfBytes instanceof Uint8Array) {
    // Correct way: Create empty array and set() data into it
    copyBytes = new Uint8Array(pdfBytes.length);
    copyBytes.set(pdfBytes);
}
const pdfData = await PDFLib.PDFDocument.load(copyBytes);
```

### Wrong - DO NOT do this
```javascript
// WRONG: Slicing ArrayBuffer causes detachment
const pdfBytes = state.pdf.bytes.buffer.slice(
    state.pdf.bytes.byteOffset,
    state.pdf.bytes.byteOffset + state.pdf.bytes.byteLength
);

// WRONG: Direct constructor doesn't copy when passed another TypedArray
const copy = new Uint8Array(pdfBytes);  // Does NOT create proper copy!

// WRONG: Reusing same Uint8Array multiple times
const pdfData = await PDFLib.PDFDocument.load(state.pdf.bytes);
// After first load, buffer may be detached for subsequent operations
```

### Why This Happens
- `ArrayBuffer` is transferred/detached when passed to certain APIs
- PDFLib may transfer ownership of the buffer internally
- TypedArray constructors behave differently:
  - `new Uint8Array(length)` creates new array
  - `new Uint8Array(buffer)` creates view of buffer
  - `new Uint8Array(typedArray)` creates VIEW, not copy!
- Solution: Use `.set()` method to properly copy data

### Rule of Thumb
**For PDF tools**:
1. Store bytes as `Uint8Array` from `file.arrayBuffer()`
2. Create proper copy using:
   ```javascript
   const copy = new Uint8Array(original.length);
   copy.set(original);
   ```
3. Pass copy to PDFLib each time

## File Download Best Practices

### Safe File Download Pattern
```javascript
// Method 1: Blob-based download (most compatible)
const blob = new Blob([fileBytes], { type: 'application/octet-stream' });
const url = URL.createObjectURL(blob);
const link = document.createElement('a');
link.href = url;
link.download = 'filename.pdf';
link.click();
URL.revokeObjectURL(url);  // Clean up memory

// Method 2: For text files
const text = 'file content here';
const blob = new Blob([text], { type: 'text/plain' });
const url = URL.createObjectURL(blob);
const link = document.createElement('a');
link.href = url;
link.download = 'filename.txt';
link.click();
URL.revokeObjectURL(url);
```

### Status Messages During Download
Provide feedback to users while downloading:

```javascript
try {
    showStatus('Preparing file for download...', false);
    downloadBtn.disabled = true;

    // Process file
    const bytes = await processFile();

    showStatus('Downloading...', false);

    // Download
    const blob = new Blob([bytes], { type: 'application/pdf' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = 'output.pdf';
    link.click();
    URL.revokeObjectURL(url);

    showStatus('Download complete!', false);
} catch (error) {
    showStatus(`Download failed: ${error.message}`, true);
} finally {
    downloadBtn.disabled = false;
}
```

### Memory Management
- Always call `URL.revokeObjectURL(url)` after creating downloads to free memory
- For large files, consider streaming or chunked processing
- Don't keep multiple blob URLs in memory

### Common Pitfalls
- ✗ Forgetting `URL.revokeObjectURL()` - causes memory leaks
- ✗ Passing ArrayBuffer directly to Blob - use `[bytes]` array wrapper
- ✗ Not disabling download button during processing - can cause duplicate downloads
- ✗ Not catching errors - users see no feedback if download fails

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
- Show progress during long operations (e.g., "Processing page 5 of 100")
- Disable buttons during processing to prevent duplicate submissions
- Allow user to cancel long-running operations (when possible)
- Consider worker threads for CPU-intensive tasks (pdf.js already does this)
- Don't process entire large files in main thread (UI will freeze)
