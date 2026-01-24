# Code Style Preferences

**Cross-references**: See @./NAMING_CONVENTIONS.md for complete naming guidelines (variables, functions, CSS classes, IDs).

This document focuses on code formatting and style patterns. For naming conventions, see the consolidated NAMING_CONVENTIONS.md file.

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
// See @./ERROR_HANDLING_GUIDE.md#status-message-display for showStatus() patterns

// See @./FILE_UPLOAD_PATTERNS.md#file-validation for file validation patterns

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

**For comprehensive error handling patterns and best practices:**
- See @./ERROR_HANDLING_GUIDE.md for:
  - Input validation patterns
  - Error message guidelines
  - User-friendly error display
  - Common error scenarios
  - Exception handling patterns

## HTML & UI Conventions

**Avoid emojis in HTML tools**: See @./NAMING_CONVENTIONS.md#emoji-usage for guidelines on emoji usage in tool UIs, titles, and card descriptions.

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
