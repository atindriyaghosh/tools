# Error Handling Guide

Best practices for handling errors and providing user feedback.

## Error Categories

### 1. User Input Errors
Errors caused by user actions (invalid file, oversized file, wrong format).

```javascript
// File too large
if (file.size > MAX_SIZE) {
    showStatus(`File too large: ${formatBytes(file.size)}. Maximum: ${formatBytes(MAX_SIZE)}`, true);
    return;
}

// Wrong file type
if (!file.type.includes('pdf')) {
    showStatus('Only PDF files are supported. You uploaded a ' + file.type, true);
    return;
}

// No file selected
if (!files || files.length === 0) {
    showStatus('Please select a file to upload', true);
    return;
}
```

### 2. Processing Errors
Errors during file processing (invalid PDF, corrupted data, out of memory).

```javascript
try {
    const pdfDoc = await PDFLib.PDFDocument.load(pdfBytes);
} catch (error) {
    console.error('PDF load error:', error);
    if (error.message.includes('Not a PDF')) {
        showStatus('Invalid PDF file: File is corrupted or not a valid PDF', true);
    } else {
        showStatus(`Failed to process PDF: ${error.message}`, true);
    }
}
```

### 3. Browser/Environment Errors
Errors due to browser limitations (out of memory, quota exceeded, no localStorage).

```javascript
try {
    localStorage.setItem(key, JSON.stringify(data));
} catch (error) {
    if (error.name === 'QuotaExceededError') {
        showStatus('Browser storage is full. Please clear some data and try again.', true);
    } else {
        showStatus('Unable to save data: ' + error.message, true);
    }
}
```

## User-Friendly Error Messages

### DO ✅
- **Be specific** - Say what went wrong and why
  - ✅ "File too large: 150 MB. Maximum 50 MB."
  - ✗ "Error"

- **Be actionable** - Tell user how to fix it
  - ✅ "File format not supported. Try uploading a PDF instead."
  - ✗ "Invalid format"

- **Use simple language** - Avoid technical jargon
  - ✅ "We couldn't read the PDF. It may be corrupted."
  - ✗ "PDFDocument.load() raised ArrayBuffer detachment exception"

- **Be polite** - Don't blame the user
  - ✅ "Couldn't process this file"
  - ✗ "You uploaded a bad file"

### DON'T ✗
- **Don't show stack traces** - Users don't understand them
  ```javascript
  // ✗ WRONG - shows confusing error
  showStatus(error.stack, true);

  // ✅ RIGHT - show friendly message
  showStatus('Failed to process file: Invalid or corrupted', true);
  ```

- **Don't use all caps** - Looks like shouting
  ```javascript
  // ✗ WRONG
  showStatus('FILE TOO LARGE!', true);

  // ✅ RIGHT
  showStatus('File too large: Maximum 50 MB', true);
  ```

- **Don't hide errors** - Always show feedback
  ```javascript
  // ✗ WRONG - user thinks nothing happened
  try {
      processFile(file);
  } catch (error) {
      console.error(error);  // Silent failure
  }

  // ✅ RIGHT - user sees what happened
  try {
      processFile(file);
      showStatus('Processing complete!', false);
  } catch (error) {
      showStatus('Processing failed: ' + error.message, true);
  }
  ```

## Status Message Display

### Good Error Message Pattern
```javascript
function showStatus(message, isError) {
    status.textContent = message;
    status.className = 'visible';
    if (isError) {
        status.setAttribute('aria-invalid', 'true');
        status.setAttribute('role', 'alert');  // Announce to screen readers
    } else {
        status.removeAttribute('aria-invalid');
    }
}

// Usage
showStatus('Processing file...', false);  // Progress
showStatus('File processed successfully!', false);  // Success
showStatus('Failed to process: Invalid PDF', true);  // Error
```

### Timing & Visibility
```javascript
// Messages should stay visible long enough to read
// Minimum 2-3 seconds (3000ms is safe)

function showStatus(message, isError, duration = 3000) {
    status.textContent = message;
    status.className = 'visible';

    if (!isError) {
        // Auto-hide success messages after duration
        setTimeout(() => {
            status.className = '';
        }, duration);
    }
    // Keep error messages visible until user dismisses (don't auto-hide)
}

// Or add a close button for error messages
function showStatus(message, isError) {
    status.innerHTML = `
        ${message}
        ${isError ? '<button onclick="this.parentElement.className=\'\'">×</button>' : ''}
    `;
}
```

## Common Error Scenarios

### PDF Processing Errors
```javascript
const errorCases = {
    'Not a PDF': 'This file is not a valid PDF. Please check the file and try again.',
    'corrupted': 'The PDF appears to be corrupted. Try opening it in a PDF reader first.',
    'password': 'This PDF is password-protected. We cannot process encrypted files.',
    'memory': 'The file is too large to process. Try splitting it into smaller files.',
    'timeout': 'Processing took too long. Please try a smaller file.'
};

try {
    const doc = await PDFLib.PDFDocument.load(pdfBytes);
} catch (error) {
    // Find friendly message from error details
    let friendlyMessage = 'Failed to process PDF';
    for (const [key, message] of Object.entries(errorCases)) {
        if (error.message.toLowerCase().includes(key.toLowerCase())) {
            friendlyMessage = message;
            break;
        }
    }
    showStatus(friendlyMessage, true);
}
```

### Download Errors
```javascript
async function downloadFile(bytes, filename) {
    downloadBtn.disabled = true;
    showStatus('Preparing download...', false);

    try {
        // Check if data is valid
        if (!bytes || bytes.length === 0) {
            throw new Error('No data to download');
        }

        const blob = new Blob([bytes], { type: 'application/pdf' });
        const url = URL.createObjectURL(blob);

        const link = document.createElement('a');
        link.href = url;
        link.download = filename;
        link.click();

        URL.revokeObjectURL(url);  // Clean up
        showStatus('Download complete!', false);
    } catch (error) {
        console.error('Download error:', error);
        showStatus(`Download failed: ${error.message}`, true);
    } finally {
        downloadBtn.disabled = false;
    }
}
```

### Validation Errors
```javascript
function validateInput(input) {
    const errors = [];

    if (!input) {
        errors.push('Input is required');
    } else if (input.length < 3) {
        errors.push('Input must be at least 3 characters');
    } else if (input.length > 100) {
        errors.push('Input must be less than 100 characters');
    }

    if (errors.length > 0) {
        showStatus(errors.join('. ') + '.', true);
        return false;
    }

    return true;
}
```

## Error Logging

### Console Logging for Debugging
```javascript
// Always log full error details for debugging (developers only)
try {
    processFile(file);
} catch (error) {
    // Full details in console (for developers)
    console.error('File processing error:', {
        message: error.message,
        stack: error.stack,
        file: file.name,
        size: file.size,
        type: file.type
    });

    // User-friendly message in UI
    showStatus('Failed to process file. Please try again or contact support.', true);
}
```

### When to Log vs Show
```javascript
// Log (developer-only info)
console.error('ArrayBuffer detached during PDFLib.load()', error);

// Show to user (simple, actionable)
showStatus('Unable to process PDF: File may be corrupted', true);

// Both - useful for debugging but user-friendly
try {
    doSomething();
} catch (error) {
    console.error('Specific error context:', error);  // Helps developer debug
    showStatus('Friendly user message', true);  // Helps user understand
}
```

## Accessibility for Error Messages

```javascript
function showStatus(message, isError) {
    status.textContent = message;
    status.className = 'visible';

    if (isError) {
        // Make error messages discoverable by screen readers
        status.setAttribute('aria-invalid', 'true');
        status.setAttribute('role', 'alert');  // Announces immediately
        status.setAttribute('aria-live', 'assertive');  // Interrupt other announcements
    } else {
        status.setAttribute('aria-live', 'polite');  // Wait for natural pause
        status.removeAttribute('aria-invalid');
    }

    // Ensure focus moves to error for keyboard users
    if (isError) {
        status.focus();
        status.tabIndex = -1;  // Make focusable without tab order
    }
}
```

## Error Recovery

```javascript
// Allow retry after error
async function processWithRetry(file, maxRetries = 3) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
            showStatus(`Attempting to process (${attempt}/${maxRetries})...`, false);
            const result = await processFile(file);
            showStatus('Success!', false);
            return result;
        } catch (error) {
            if (attempt === maxRetries) {
                showStatus(`Failed after ${maxRetries} attempts: ${error.message}`, true);
                throw error;
            }
            // Wait before retrying
            await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
        }
    }
}
```
