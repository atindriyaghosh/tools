# Tool Template Structure

Each tool is a single, self-contained HTML file in the root directory:
- External libraries via CDN only (https://cdnjs.cloudflare.com)
- **Always reference `common-styles.css`** for standard styling (links, buttons, results, back-links)
- Tool-specific CSS only in inline `<style>` tags (custom layouts, unique interactions)
- All JS inline in `<script>` tags
- localStorage/sessionStorage allowed when appropriate
- Plain vanilla JavaScript - no frameworks

**Cross-references**: See @./NAMING_CONVENTIONS.md for file naming, tool names, and variable conventions. See @./STANDARD_FEATURES.md for required features.

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

## File Upload Patterns

**For tools with file uploads**: See @./FILE_UPLOAD_PATTERNS.md for:
- Upload area styling and status div placement
- File validation patterns
- PDF byte handling (CRITICAL for PDF tools)
- File download best practices
- Large file handling and streaming

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

Before considering a tool complete, verify all items:

**Cross-reference**: For detailed patterns and best practices, see @./FILE_UPLOAD_PATTERNS.md and @./PATTERNS.md.

### Core Functionality
- [ ] Tool does ONE thing well and does it correctly
- [ ] All major features work as designed
- [ ] Edge cases handled (empty input, oversized files, special characters)
- [ ] Error messages are clear and helpful (specific, actionable)

### File & Project Structure
- [ ] Tool file is in root directory (not subdirectory)
- [ ] common-styles.css is referenced (not duplicate button styling)
- [ ] Tool-specific CSS is inline only (no separate .css file)
- [ ] All JavaScript is vanilla (no frameworks)
- [ ] No console errors or warnings

### User Feedback & Status
- [ ] Status messages appear immediately AFTER upload area (not at bottom)
- [ ] Buttons are disabled during processing (prevent duplicate submissions)
- [ ] Loading states: "Processing...", then "Complete!" or "Error: reason"
- [ ] Status messages stay visible long enough (minimum 2-3 seconds)
- [ ] No status/error messages disappear too quickly
- [ ] Upload area styling is consistent (padding: 0.75rem 1rem)

### Navigation & Naming
- [ ] Back navigation to index.html present (top and bottom)
- [ ] Tool name uses Title Case (no icons/emojis in title)
- [ ] Page title matches landing page tool card title EXACTLY
- [ ] Semantic HTML used (`<main>`, `<article>`, `<hgroup>`)
- [ ] Form fields have proper labels

### File Handling (if applicable)
- [ ] File size validated AND file type validated
- [ ] File validation errors are user-friendly ("Max 50 MB, got 120 MB")
- [ ] Blob URLs are revoked after downloads (no memory leaks)
- [ ] Buttons disabled during download to prevent duplicates

### Mobile & Accessibility
- [ ] Works on mobile (responsive, no horizontal scroll)
- [ ] Tested with DevTools mobile view (iPhone 12, Android)
- [ ] Buttons are clickable size (minimum 44x44px)
- [ ] localStorage usage documented in code (if used)
- [ ] Proper ARIA labels and roles where needed

### Before Landing Page Add
- [ ] Tool card added to index.html in correct category
- [ ] Tool description is searchable (has relevant keywords)
- [ ] README.md updated with new tool entry (if applicable)
