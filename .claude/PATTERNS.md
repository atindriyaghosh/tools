# Common Patterns

## Back Navigation

Include at top and bottom of each tool page (styled automatically by `common-styles.css`):
```html
<p style="margin-bottom: 1rem;"><a href="index.html" class="back-link">← Back to Tools</a></p>
```

## File Upload with Validation

Validate file size before processing:
```javascript
if (file.size > 50 * 1024 * 1024) {
    showStatus('File too large: maximum 50 MB', true);
    return;
}
```

## Status Messages

Display messages with error state:
```javascript
function showStatus(message, isError) {
    status.textContent = message;
    status.className = 'visible';
    if (isError) status.setAttribute('aria-invalid', 'true');
}
```

## PDF Byte Handling - CRITICAL

**IMPORTANT**: When storing PDF bytes from `file.arrayBuffer()` and later passing to PDFLib, must create a proper copy to avoid "detached ArrayBuffer" errors.

### ✅ CORRECT - Proper copy of Uint8Array
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

### ✗ WRONG - DO NOT do this
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

## State Management Pattern

For tools with complex state (forms, multi-step workflows, undo/redo):

```javascript
// Single source of truth - one state object
const state = {
    data: {},
    selectedItems: [],
    mode: 'view',  // or 'edit', 'fill', etc.
    history: { past: [], future: [] }
};

// All state updates go through this function
function updateState(updates) {
    Object.assign(state, updates);
    render();  // Trigger re-render after state changes
}

// Deep cloning for history (undo/redo)
function saveToHistory() {
    const snapshot = JSON.parse(JSON.stringify(state));
    state.history.past.push(snapshot);
    state.history.future = [];  // Clear redo stack
}

function undo() {
    if (state.history.past.length === 0) return;
    const current = JSON.parse(JSON.stringify(state));
    state.history.future.push(current);
    Object.assign(state, state.history.past.pop());
    render();
}
```

**Benefits:**
- Predictable state changes
- Easy to debug (state is centralized)
- Easier to implement undo/redo
- Clear data flow

## Keyboard Shortcut Pattern

Handle keyboard shortcuts without interfering with form inputs:

```javascript
document.addEventListener('keydown', (e) => {
    // Don't trigger shortcuts when typing in inputs/textareas
    const isTyping = ['INPUT', 'TEXTAREA'].includes(e.target.tagName);
    if (isTyping) return;

    // Check for Cmd/Ctrl key combos
    const isMeta = e.metaKey || e.ctrlKey;

    if (isMeta && e.key === 'z') {
        e.preventDefault();
        e.shiftKey ? redo() : undo();
    } else if (isMeta && e.key === 'c') {
        e.preventDefault();
        copySelected();
    } else if (isMeta && e.key === 'v') {
        e.preventDefault();
        paste();
    } else if (e.key === 'Delete' || e.key === 'Backspace') {
        e.preventDefault();
        deleteSelected();
    } else if (e.key === 'Escape') {
        e.preventDefault();
        deselectAll();
    }
});

// Add helpful labels in UI
// <button title="Ctrl+Z or Cmd+Z">Undo</button>
```

**Best Practices:**
- ✓ Prevent default browser behavior with `e.preventDefault()`
- ✓ Skip shortcuts when user is typing (in inputs/textareas)
- ✓ Show keyboard shortcuts in button titles/labels
- ✓ Use standard shortcuts: Ctrl+Z (undo), Ctrl+C (copy), etc.
- ✗ Don't override browser defaults like Ctrl+S (save), Ctrl+F (find)

## Modal/Dialog Pattern

For confirmations, prompts, or complex interactions:

```javascript
function showModal(title, message, options = {}) {
    const modal = document.createElement('article');
    modal.id = 'modal-' + Math.random().toString(36).slice(2);
    modal.style.position = 'fixed';
    modal.style.top = '50%';
    modal.style.left = '50%';
    modal.style.transform = 'translate(-50%, -50%)';
    modal.style.zIndex = '1000';
    modal.style.maxWidth = '500px';
    modal.style.padding = '2rem';

    let html = `<h2>${title}</h2><p>${message}</p>`;

    if (options.type === 'confirm') {
        html += `
            <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                <button id="modal-cancel">Cancel</button>
                <button id="modal-confirm" style="background: #6b8dd6;">Confirm</button>
            </div>
        `;
    } else if (options.type === 'input') {
        html += `
            <input type="text" id="modal-input" placeholder="${options.placeholder || ''}" />
            <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                <button id="modal-cancel">Cancel</button>
                <button id="modal-confirm" style="background: #6b8dd6;">OK</button>
            </div>
        `;
    }

    modal.innerHTML = html;
    document.body.appendChild(modal);

    return new Promise((resolve) => {
        document.getElementById('modal-cancel')?.addEventListener('click', () => {
            modal.remove();
            resolve(null);
        });

        document.getElementById('modal-confirm')?.addEventListener('click', () => {
            const value = options.type === 'input'
                ? document.getElementById('modal-input').value
                : true;
            modal.remove();
            resolve(value);
        });

        // Close on Escape key
        const handleEscape = (e) => {
            if (e.key === 'Escape') {
                modal.remove();
                document.removeEventListener('keydown', handleEscape);
                resolve(null);
            }
        };
        document.addEventListener('keydown', handleEscape);
    });
}

// Usage:
const result = await showModal('Delete?', 'Are you sure you want to delete this item?', { type: 'confirm' });
if (result) deleteItem();
```

**Best Practices:**
- ✓ Use `position: fixed` to overlay modals on top of content
- ✓ Add high `z-index` to ensure visibility
- ✓ Support Escape key to close (standard UX pattern)
- ✓ Return Promise for async workflows
- ✓ Prevent background scrolling (optional: `document.body.style.overflow = 'hidden'`)
