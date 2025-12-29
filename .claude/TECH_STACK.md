# Tech Stack

- **Framework**: None - vanilla JavaScript only
- **No React, Vue, or any JS frameworks** - keep it simple with plain HTML/JS
- **CSS**: Pico CSS (https://picocss.com/) for minimal, lightweight styling
- **Design**: Clean, minimal, functional - performance over visual flair
- **Single Responsibility**: Each tool does ONE thing well
- **Deployment**: GitHub Pages via GitHub Actions
  - **Build Process**: Bash script selectively copies production files to `_site/` directory
  - **Build Features**: Automatically updates copyright year in index.html footer based on current year
  - **Excluded from Deployment**: `.claude/`, `.dev/`, `.github/`, `.brainstorm/`, `.git/`, config files, LICENSE
  - **Trigger**: Automatic on push to main branch, or manual via workflow_dispatch
  - **Deployed Files**: All `.html` files, `common-styles.css`, `CNAME`, `.nojekyll`, `favicon.png`

## CDN Best Practices

When adding external libraries:

```html
<!-- Always use specific version numbers (not @latest) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>

<!-- Use https:// links (auto-upgrades from http://) -->
<!-- ✗ Wrong: http://cdnjs.cloudflare.com/... -->
<!-- ✓ Right: https://cdnjs.cloudflare.com/... -->

<!-- Prefer jsdelivr for npm packages -->
<script src="https://cdn.jsdelivr.net/npm/package@version/dist/file.min.js"></script>
```

**Key CDN Options:**
- **cdnjs.cloudflare.com**: Popular libraries (pdf.js, html2canvas, markdown-it, etc.)
- **cdn.jsdelivr.net**: npm packages, GitHub repos, alternative CDN
- **Picocss**: `https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css`

**Versioning:**
- Always pin specific versions (e.g., `3.11.174` not `3` or `latest`)
- Don't use major-only versions that auto-update
- Major version upgrades require testing and should be deliberate

## Performance Targets

Optimize for user experience:

| Metric | Target | Rationale |
|--------|--------|-----------|
| **Page Load** | < 2 seconds | Initial paint, interactive time |
| **File Upload Response** | < 100ms | DOM interaction feedback |
| **Large File Processing** | Show progress | Don't freeze UI (use async/await) |
| **Download Button Response** | < 50ms | User expects instant response |
| **Status Message Display** | 2-3 seconds minimum | Users need time to read |

**Optimization Tips:**
- Minify CSS/JS (Pico CSS is already minified)
- Load scripts at end of `<body>` (not `<head>`)
- Use `async` attribute for non-critical scripts
- Avoid unnecessary DOM manipulation in loops
- Use `requestAnimationFrame` for animations/updates
- Consider lazy loading for large PDFs (only render visible pages)
