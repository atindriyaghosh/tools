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
