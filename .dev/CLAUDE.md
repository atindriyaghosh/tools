# Development Guidelines

## Implementation Workflow

1. **Branch**: Create feature branch from main synced with remote
   - `git checkout main && git pull && git checkout -b feature/description`
2. **Clarify**: Ask questions about requirements/approach until you're convinced of what to build
3. **Implement**: Code changes (new tool, feature, fix, or enhancement)
   - New tool: Reference `.dev/TOOL_TEMPLATE.md` and `common-styles.css`
   - Existing: Read current code first, make incremental changes
4. **Test**: Verify locally before committing
5. **Commit**: Push to feature branch
6. **PR**: Open pull request to main for review
7. **Merge**: After review, merge to main and deploy

## Documentation

Quick reference - detailed specs in `.dev/`:
- `TECH_STACK.md` - Framework, deployment
- `FILE_STRUCTURE.md` - Directory layout
- `TOOL_TEMPLATE.md` - HTML structure template
- `STANDARD_FEATURES.md` - Required features
- `LANDING_PAGE.md` - Homepage structure
- `PATTERNS.md` - Common code patterns
- `CODING_STYLE.md` - Style preferences
- `QUALITY_CHECKLIST.md` - Pre-completion checklist

## Styling

Use `common-styles.css` for all standard styling (buttons, links, back-links, result boxes). Tool-specific CSS goes in inline `<style>` tags only.

## Key Constraints

- **No build pipeline** - direct push to GitHub
- **Single file per tool** - self-contained in root
- **Performance first** - lightweight, fast loading
- **No frameworks** - vanilla JavaScript only
- **Clean URLs** - Tools in root for `yourdomain.com/tool-name.html`

## Notes

- Deployed to GitHub Pages
- All client-side, no backend
- Current tools listed in `/README.md`
- Development files in `.dev/` (not web-accessible)