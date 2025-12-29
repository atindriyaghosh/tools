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
state.pdf.bytes = pdfBytes;

// Later, when passing to PDFLib for processing - CREATE PROPER COPY
let copyBytes;
if (state.pdf.bytes instanceof Uint8Array) {
    // Correct way: Create empty array and set() data into it
    copyBytes = new Uint8Array(state.pdf.bytes.length);
    copyBytes.set(state.pdf.bytes);
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
const copy = new Uint8Array(state.pdf.bytes);  // Does NOT create proper copy!

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
