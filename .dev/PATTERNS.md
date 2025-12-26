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
