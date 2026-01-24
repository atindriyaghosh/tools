# Development Guidelines

## Implementation Workflow

### Phase 1: Planning
- **Goal**: Create detailed implementation plan with architecture and decisions
- **How**: Initiate a Claude Code session with EnterPlanMode to explore codebase and design approach for approval
- **Brainstorming context**: If a brainstorming document is available, provide it to establish requirements and design rationale
- **Output**: Structured plan covering:
  - Architecture decisions
  - Files to create/modify
  - Implementation steps
  - Integration points

### Phase 2: Implementation
1. **Branch**: Create feature branch from main synced with remote
   - Sync: `git checkout main && git pull`
   - Create: `git checkout -b PREFIX/description` (see branch naming below)
2. **Clarify**: Ask questions about requirements/approach (if not done in planning)
3. **Implement**: Code changes (new tool, feature, fix, or enhancement)
   - New tool: Reference `.claude/TOOL_TEMPLATE.md` and `common-styles.css`
   - Existing: Read current code first, make incremental changes
4. **Test**: Verify locally before committing
5. **Commit**: Commit to feature branch with clear message
6. **Push**: Push to remote with `-u` flag for tracking
7. **PR**: Open pull request to main for review (manual)
8. **Merge**: After review, merge to main and deploy (manual)

## Branch Naming Conventions

Use one of these prefixes:
- `feature/` - New tools or features (e.g., `feature/markdown-to-html-converter`)
- `enhance/` - Enhancements to existing tools (e.g., `enhance/timezone-converter-dst`)
- `fix/` - Bug fixes (e.g., `fix/pdf-converter-memory-leak`)
- `refactor/` - Code refactoring (e.g., `refactor/common-styles-organization`)
- `docs/` - Documentation updates (e.g., `docs/update-tool-template`)

## Documentation

Quick reference - detailed specs in `.claude/`:
- `TECH_STACK.md` - Framework, deployment
- `FILE_STRUCTURE.md` - Directory layout
- `TOOL_TEMPLATE.md` - HTML structure template and pre-completion checklist
- `NAMING_CONVENTIONS.md` - File, tool, variable, and CSS naming rules (consolidated)
- `FILE_UPLOAD_PATTERNS.md` - File upload, validation, and download patterns (consolidated)
- `STANDARD_FEATURES.md` - Required features for all tools
- `LANDING_PAGE.md` - Homepage structure and organization
- `PATTERNS.md` - Common code patterns and best practices
- `CODING_STYLE.md` - Code formatting and style preferences
- `ERROR_HANDLING_GUIDE.md` - Error patterns and user feedback

**Consolidated files** (for maintainability):
- `NAMING_CONVENTIONS.md` consolidates naming rules from FILE_STRUCTURE.md, STANDARD_FEATURES.md, LANDING_PAGE.md, and CODING_STYLE.md
- `FILE_UPLOAD_PATTERNS.md` consolidates file upload patterns from TOOL_TEMPLATE.md, STANDARD_FEATURES.md, and PATTERNS.md
- `TOOL_TEMPLATE.md` now includes Pre-Completion Checklist (merged from separate QUALITY_CHECKLIST.md)

## Design & Planning

When planning a new tool:
- Check `.brainstorm/` directory for existing design documents (if available)
- If creating a new tool concept, add a design doc to `.brainstorm/` before implementation
- Use brainstorm doc to clarify requirements and design approach with user in EnterPlanMode

## Emergency Fixes (Hotfixes)

For critical bugs that need immediate patching:
1. **Branch**: Create `fix/` branch from main (not feature branch)
   - `git checkout main && git pull`
   - `git checkout -b fix/critical-bug-name`
2. **Fix**: Make minimal changes ONLY to fix the issue (no refactoring)
3. **Test**: Thoroughly test the fix in browser
4. **Commit**: Clear, descriptive commit message explaining the bug and fix
5. **Push & Merge**: Push branch, create PR, and merge immediately after approval
6. **No code review delays** - these go to main directly for rapid deployment

**Safety Checks for Hotfixes:**
- ✓ Use `git status` before committing to verify changes
- ✓ Use `git diff` to review exact changes
- ✓ Never use `--force` push (will auto-reject)
- ✓ Never amend and force-push to main
- ✓ Test the fix matches the reported issue exactly

## Styling

Use `common-styles.css` for all standard styling (buttons, links, back-links, result boxes). Tool-specific CSS goes in inline `<style>` tags only.

## Key Constraints

- **Automated deployment** - GitHub Actions builds and deploys on push to main
- **Single file per tool** - self-contained in root
- **Performance first** - lightweight, fast loading
- **No frameworks** - vanilla JavaScript only
- **Clean URLs** - Tools in root for `yourdomain.com/tool-name.html`

## Notes

- Deployed to GitHub Pages via GitHub Actions workflow
- Build process selectively copies only production files (excludes `.claude/`, `.github/`, `.dev/`, etc.)
- All client-side, no backend
- Current tools listed in `/README.md`
- Development files in `.dev/` (not web-accessible)
