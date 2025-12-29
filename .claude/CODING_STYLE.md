# Code Style Preferences

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

## Async/Await vs Promises

**Prefer async/await over promise chains:**
```javascript
// ✅ Good - easier to read and reason about
async function processFile() {
    try {
        const data = await file.arrayBuffer();
        const result = await processData(data);
        return result;
    } catch (error) {
        console.error('Error:', error);
        showStatus('Processing failed', true);
    }
}

// ✗ Avoid - harder to follow
function processFile() {
    return file.arrayBuffer()
        .then(data => processData(data))
        .then(result => result)
        .catch(error => {
            console.error('Error:', error);
            showStatus('Processing failed', true);
        });
}
```

## Comments & Documentation

**Comment only when logic is non-obvious:**
```javascript
// ✅ Good - explains WHY and the workaround
function copybytes(original) {
    // Create empty array and copy data using .set()
    // Direct constructor creates a VIEW, not a copy (see PATTERNS.md)
    const copy = new Uint8Array(original.length);
    copy.set(original);
    return copy;
}

// ✗ Bad - just repeats what the code says
function copyBytes(original) {
    const copy = new Uint8Array(original.length);  // Create new Uint8Array
    copy.set(original);  // Set data into it
    return copy;  // Return it
}

// ✅ Self-documenting - no comment needed
function calculateFileSize(bytes) {
    return Math.round(bytes / (1024 * 1024) * 100) / 100;
}
```

## Functions & Scope

**Keep functions small and focused:**
```javascript
// ✅ Good - single responsibility
function showStatus(message, isError) {
    status.textContent = message;
    status.className = isError ? 'visible error' : 'visible';
}

function validateFileSize(file) {
    if (file.size > MAX_SIZE) {
        showStatus(`File too large: ${formatBytes(file.size)}`, true);
        return false;
    }
    return true;
}

// ✗ Avoid - doing too much in one function
function handleFileUpload(file) {
    if (file.size > MAX_SIZE) {
        status.textContent = 'File too large';
        status.className = 'visible error';
        return;
    }
    // ... 50 more lines of code ...
}
```

**Const by default, let only for reassignments:**
```javascript
// ✅ Good - const for values that don't change
const MAX_FILE_SIZE = 50 * 1024 * 1024;
const uploadArea = document.getElementById('uploadArea');

// ✅ Good - let only when reassigning
let currentFile = null;
let processedCount = 0;

// ✗ Avoid - var is function-scoped, confusing
var oldStyle = 'file';  // Don't use var
```

## Input Validation & Error Handling

**Always validate user input at boundaries:**
```javascript
// ✅ Good - validates at entry points
function handleUpload(files) {
    if (!files || files.length === 0) {
        showStatus('No file selected', true);
        return;
    }

    const file = files[0];
    if (file.size > MAX_SIZE) {
        showStatus(`File too large: ${formatBytes(file.size)}. Max: ${formatBytes(MAX_SIZE)}`, true);
        return;
    }

    if (!isValidFileType(file)) {
        showStatus('Only PDF files are supported', true);
        return;
    }

    processFile(file);
}

// ✗ Avoid - no validation, crashes silently
function handleUpload(files) {
    processFile(files[0]);
}
```

**Handle errors gracefully:**
```javascript
// ✅ Good - catches errors and shows user message
try {
    const pdfDoc = await PDFLib.PDFDocument.load(pdfBytes);
    showStatus('PDF loaded successfully', false);
} catch (error) {
    console.error('PDF load error:', error);
    showStatus('Failed to load PDF: Invalid or corrupted file', true);
}

// ✗ Avoid - crashes without feedback
const pdfDoc = await PDFLib.PDFDocument.load(pdfBytes);
```

## Common Patterns

**Disable buttons during operations:**
```javascript
downloadBtn.addEventListener('click', async () => {
    downloadBtn.disabled = true;
    showStatus('Preparing download...', false);

    try {
        const bytes = await processFile();
        downloadFile(bytes);
        showStatus('Download complete!', false);
    } catch (error) {
        showStatus(`Download failed: ${error.message}`, true);
    } finally {
        downloadBtn.disabled = false;
    }
});
```

**Use arrow functions for callbacks:**
```javascript
// ✅ Good - arrow functions preserve `this`
button.addEventListener('click', () => {
    this.handleClick();  // `this` refers to object
});

// ✗ Avoid - regular function loses `this`
button.addEventListener('click', function() {
    this.handleClick();  // `this` is undefined/window
});
```
