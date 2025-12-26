# Development Guidelines

## Workflow

### Building a New Tool
1. **Ask clarifying questions** about requirements, UX, and implementation approach
2. **Ensure clarity** before writing code - understand exactly what needs to be built
3. Only proceed when convinced of the requirements
4. Create HTML file in root: `tool-name.html`
5. Reference `.dev/TOOL_TEMPLATE.md` for structure
6. Reference `common-styles.css` for styling
7. Test locally, add to index.html, commit and push

### Updating Existing Tools
1. **Ask questions** if requirements are unclear
2. Read the existing implementation first
3. Discuss approach before making changes
4. Make incremental changes preserving functionality
5. Test locally before committing

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