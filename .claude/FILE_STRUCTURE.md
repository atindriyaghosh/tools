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
- `TOOL_TEMPLATE.md` - HTML structure template and pre-completion checklist
- `NAMING_CONVENTIONS.md` - Naming rules for files, tools, variables, and CSS (consolidated)
- `FILE_UPLOAD_PATTERNS.md` - File upload, validation, and download patterns (consolidated)
- `STANDARD_FEATURES.md` - Required features for all tools
- `PATTERNS.md` - Common code patterns and best practices
- `CODING_STYLE.md` - Code formatting and style preferences
- `TECH_STACK.md` - Framework, deployment, performance targets
- `LANDING_PAGE.md` - Landing page structure and organization
- `ERROR_HANDLING_GUIDE.md` - Error patterns and user feedback
- `FILE_STRUCTURE.md` - This file (directory layout reference)

**`.github/` directory**: GitHub configuration (not web-accessible)
- `workflows/` - CI/CD automation (build, deploy)
- `scripts/` - Build scripts (`.github/scripts/build.sh`)

**`.brainstorm/` directory**: Design documents and requirements (not web-accessible)
- Tool design specs before implementation
- Feature brainstorms and planning docs
- Used during EnterPlanMode design phase

**`.git/` directory**: Git repository data (not web-accessible)

## Naming Conventions

For comprehensive naming conventions, see @./NAMING_CONVENTIONS.md which covers:
- File naming (tools, directories)
- Tool names in UI
- Variable and function naming
- CSS class and ID naming
- Category organization

Quick reference:
- **Tool files**: lowercase with hyphens (e.g., `pdf-merge.html`)
- **Directories**: lowercase with hyphens, dot-prefixed for hidden (e.g., `.claude/`)
- **Tool UI names**: Title Case, no emojis (e.g., "PDF Merge")

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
