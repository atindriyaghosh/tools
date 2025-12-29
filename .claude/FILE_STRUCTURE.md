# File Structure

## Root Directory
- **Tool HTML files**: Single file per tool (e.g., `pdf-merge.html`, `timezone-converter.html`)
- **`index.html`**: Landing page with tool directory and categories
- **`common-styles.css`**: Shared styling referenced by all tools
- **`favicon.png`**: Site icon (displayed in browser tab)
- **`CNAME`**: Custom domain configuration (for GitHub Pages)
- **`.nojekyll`**: Tells GitHub Pages to skip Jekyll processing

## Hidden Directories (Dot-prefixed, not web-accessible)

**`.claude/` directory**: Developer documentation (excluded from web build)
- `CLAUDE.md` - Development workflow and branching strategy
- `PATTERNS.md` - Common code patterns and best practices
- `TOOL_TEMPLATE.md` - HTML structure template
- `STANDARD_FEATURES.md` - Required features for all tools
- `CODING_STYLE.md` - Code style preferences
- `TECH_STACK.md` - Framework, deployment, performance targets
- `LANDING_PAGE.md` - Landing page structure and organization
- `FILE_STRUCTURE.md` - This file
- `QUALITY_CHECKLIST.md` - Pre-completion validation checklist
- `ERROR_HANDLING_GUIDE.md` - Error patterns and user feedback

**`.github/` directory**: GitHub configuration (not web-accessible)
- `workflows/` - CI/CD automation (build, deploy)
- `scripts/` - Build scripts (`.github/scripts/build.sh`)

**`.brainstorm/` directory**: Design documents and requirements (not web-accessible)
- Tool design specs before implementation
- Feature brainstorms and planning docs
- Used during EnterPlanMode design phase

**`.git/` directory**: Git repository data (not web-accessible)

## Naming Conventions

- **Tool files**: lowercase with hyphens
  - Examples: `pdf-merge.html`, `timezone-converter.html`, `unix-timestamp.html`
  - NOT: `PDFMerge.html`, `pdf_merge.html`, `pdfmerge.html`

- **Tool names in UI**: Title Case (no emojis in title)
  - Examples: "PDF Merge", "Timezone Converter", "Unix Timestamp"
  - NOT: "pdf merge", "TIMEZONE CONVERTER", "📄 PDF Merge"

- **Directory names**: lowercase with hyphens, start with dot for hidden
  - `.claude/`, `.github/`, `.brainstorm/`
  - NOT: `.Claude/`, `claude/`, `_claude/`

## Web-Accessible vs Hidden

**Web-Accessible** (visible after GitHub Pages build):
- All `.html` files in root
- `common-styles.css`
- `favicon.png`
- `CNAME`, `.nojekyll`

**NOT Web-Accessible** (excluded by build, start with `.`):
- `.claude/` - Documentation
- `.github/` - Configuration
- `.brainstorm/` - Design docs
- `.git/` - Repository data
- All other dot-prefixed files/directories

**Note**: GitHub Pages build script only deploys relevant HTML/CSS & JS files. This is why development docs are safe in `.claude/`.
