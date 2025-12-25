# HTML Tools Portfolio

A collection of single-file, browser-based utility tools built with vanilla JavaScript and Pico CSS.

## Development Workflow

### Phase 1: Brainstorming (Claude.ai Chat)
1. Discuss tool idea and requirements in Claude.ai web/app
2. Work through UX decisions and edge cases
3. Generate a spec document using the tool spec template (available in .dev/ directory)
4. Review and refine the spec

### Phase 2: Specification (Manual)
1. Copy the spec from Claude.ai chat
2. Save to `.dev/specs/tool-name-spec.md` in this repo
3. Commit the spec to version control
4. The spec serves as the contract between design and implementation

### Phase 3: Implementation (Claude Code)
1. Start Claude Code in this repo: `claude`
2. Reference the spec: "Build tool-name.html based on .dev/specs/tool-name-spec.md"
3. Test locally, iterate as needed
4. Claude Code will follow both the spec and these guidelines

### Phase 4: Integration
1. Add tool card to appropriate category in index.html
2. Commit and push to GitHub
3. Tool automatically deploys via GitHub Pages

### Working with Existing Code (No Spec)

If a tool HTML file exists without a corresponding spec:
1. **Generate spec from code**: Ask Claude Code to "Create a spec in .dev/specs/ for tool-name.html by analyzing the existing implementation"
2. Claude Code will examine the code and document: purpose, features, UI layout, libraries used, edge cases handled
3. Review and refine the generated spec
4. Commit the spec for future reference

### Keeping Specs in Sync

If you make direct changes to a tool HTML file:
1. **Update the spec**: Ask Claude Code to "Update .dev/specs/tool-name-spec.md to reflect the changes in tool-name.html"
2. Claude Code will analyze the changes and update the spec accordingly
3. Commit both the code and updated spec together
4. This keeps documentation in sync with implementation

The spec should always reflect the current state of the tool, whether you're building new or modifying existing.

## Tech Stack

- **Framework**: None - vanilla JavaScript only
- **No React, Vue, or any JS frameworks** - keep it simple with plain HTML/JS
- **CSS**: Pico CSS (https://picocss.com/) for minimal, lightweight styling
- **Design**: Clean, minimal, functional - performance over visual flair
- **Single Responsibility**: Each tool does ONE thing well
- **Deployment**: GitHub Pages

## File Structure

```
repo-root/
├── .dev/                    # Development files (auto-excluded by GitHub Pages)
│   ├── CLAUDE.md            # This file - project context
│   ├── specs/
│   │   ├── tool-name-spec.md
│   │   └── SPEC_TEMPLATE.md
│   └── .gitignore           # Ignore any local dev files if needed
├── index.html               # Landing page with categorized tools
├── pdf-to-image.html        # Individual tools (in root for GH Pages)
├── image-converter.html     # Individual tools (in root for GH Pages)
├── .nojekyll                # Optional: disables Jekyll processing
└── README.md
```

**Important**: All development/documentation files go in `.dev/`. Tool HTML files stay in root for clean URLs on GitHub Pages (e.g., `https://yourdomain.com/pdf-to-image.html`).

**Why `.dev/` is not web-accessible:**
- GitHub Pages automatically excludes directories starting with `.` (dot)
- This includes `.dev/`, `.github/`, and any dotfiles
- The files are in git and accessible to Claude Code, but not via the web URL
- `.nojekyll` disables Jekyll processing (prevents issues with underscored folders/files)

## Design System: Pico CSS

- Use semantic HTML with minimal classes
- Leverage Pico's built-in form styling and components
- Light mode only (data-theme="light")
- File size: ~10KB CSS, zero JS framework overhead
- CDN: `<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">`

### Color Scheme
- **Link/accent color**: Soft blue (#6b8dd6)
- **Button color**: Soft blue (#6b8dd6)
  - Hover state: Darker soft blue (#5b7dc6)
  - Disabled state: Light soft blue (#9baee6)
- **Badge/Count badges**: White text on soft blue background (#6b8dd6)
- Use these colors consistently across all tool pages to match the landing page
- Override Pico's default colors by adding to your tool's `<style>`:
  ```css
  a {
      color: #6b8dd6;
  }

  button {
      background-color: #6b8dd6;
      border-color: #6b8dd6;
      color: white;
  }

  button:hover {
      background-color: #5b7dc6;
      border-color: #5b7dc6;
  }

  button:disabled {
      background-color: #9baee6;
      border-color: #9baee6;
      opacity: 0.6;
  }
  ```
- Consistent with the landing page (index.html) for a unified visual experience

### Tool Count Badges (Landing Page)
Tool counts on the landing page's table of contents are displayed as circular badges:
```css
.toc-count {
    font-size: 0.75rem;
    color: white;
    background-color: #6b8dd6;
    border-radius: 50%;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 1.5rem;
    height: 1.5rem;
    margin-left: 0.35rem;
    font-weight: 600;
}
```
- Creates a perfect circle with soft blue background (#6b8dd6)
- White text (color: white) with bold weight (600) for readability
- Positioned inline next to category names with 0.35rem margin
- Automatically updates when tools are filtered by search
- Used to provide quick visual feedback on number of tools per category

### Visual Design Consistency Guidelines
To maintain visual consistency across all pages:

1. **Spacing & Layout**:
   - Tool cards: 0.5rem padding, 0.5rem gap
   - Search box: 0.4rem 0.75rem padding
   - Section headers: 0.75rem top margin, 0.4rem bottom margin
   - Back links: 0.4rem 0.6rem padding

2. **Typography**:
   - Section titles: 1.25rem, bold (font-weight: 700)
   - Card titles: 0.9rem, bold (font-weight: 600)
   - Card descriptions: 0.75rem, muted color, line-height 1.3
   - TOC/search: 0.85rem
   - Placeholder text: italic

3. **Colors** (all pages):
   - Primary accent: #6b8dd6 (soft blue) for links, buttons, badges
   - Hover: #5b7dc6 (darker soft blue)
   - Disabled: #9baee6 (light soft blue) with 0.6 opacity
   - Backgrounds: inherit from Pico CSS defaults (light backgrounds)

4. **Interactions**:
   - All transitions: 0.2s duration
   - Hover effects: subtle background changes, color adjustments
   - No aggressive animations or visual effects
   - Back links: inline-flex layout for proper icon/text alignment

5. **Responsive Design**:
   - Grid uses auto-fill with minmax(200px, 1fr)
   - Flex layouts wrap on smaller screens
   - All padding/spacing scales proportionally

## Tool Template Structure

Each tool is a single, self-contained HTML file in the root directory:
- External libraries via CDN only (https://cdnjs.cloudflare.com)
- All CSS inline in `<style>` tags
- All JS inline in `<script>` tags
- localStorage/sessionStorage allowed when appropriate
- Plain vanilla JavaScript - no frameworks

## Standard Features to Include

Every tool must have:
1. **Back link**: Link to index.html (e.g., `<a href="index.html">← Back to Tools</a>`)
2. **File size limits**: Display max file size in UI, validate on upload
3. **Error handling**: Clear error messages using Pico's styling
4. **Loading states**: Inform users during processing
5. **Semantic HTML**: Use `<main>`, `<article>`, `<hgroup>`, etc.
6. **Accessibility**: Proper labels, ARIA attributes where needed
7. **Tool Name Format**:
   - Use Title Case (e.g., "Timezone Converter", "Unix Timestamp Converter")
   - No icons or emojis in tool names or page titles
   - Keep tool names clear and descriptive
   - Consistent naming across:
     - HTML `<title>` tag
     - Page `<h1>` heading
     - Landing page tool card title

## Common Patterns

### Back Navigation
Include at both the top and bottom of each tool page:
```html
<p style="margin-bottom: 1rem;"><a href="index.html" class="back-link">← Back to Tools</a></p>
```

Back links are styled with the `.back-link` class:
```css
a.back-link {
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    font-weight: bold;
    padding: 0.4rem 0.6rem;
    border-radius: var(--pico-border-radius);
    transition: all 0.2s;
    color: #6b8dd6;
}

a.back-link:hover {
    background-color: rgba(107, 141, 214, 0.1);
    color: #5b7dc6;
}
```

Features:
- Bold text with soft blue color (#6b8dd6)
- Subtle background color on hover
- Rounded corners matching Pico CSS design
- Smooth transitions for better UX

### File Upload with Validation
```javascript
async function handleFile(file) {
    const maxSize = 50 * 1024 * 1024; // 50 MB
    
    if (file.size > maxSize) {
        showStatus(`File too large: ${(file.size / (1024 * 1024)).toFixed(1)} MB. Maximum: 50 MB`, true);
        return;
    }
    
    // Process file...
}
```

### Status Messages
```javascript
function showStatus(message, isError) {
    status.textContent = message;
    status.className = 'visible';
    if (isError) {
        status.setAttribute('aria-invalid', 'true');
    } else {
        status.removeAttribute('aria-invalid');
    }
}
```

### Drag and Drop Upload
```javascript
uploadArea.addEventListener('dragover', (e) => {
    e.preventDefault();
    uploadArea.classList.add('drag-over');
});

uploadArea.addEventListener('drop', (e) => {
    e.preventDefault();
    uploadArea.classList.remove('drag-over');
    const file = e.dataTransfer.files[0];
    if (file) handleFile(file);
});
```

### Using localStorage for Preferences
```javascript
// Save user preference
localStorage.setItem('preferredFormat', 'png');

// Retrieve preference
const format = localStorage.getItem('preferredFormat') || 'png';
```

## Browser APIs for Common Tasks

### PDF Manipulation
- **Library**: pdf.js (https://cdnjs.cloudflare.com/ajax/libs/pdf.js/)
- **Use for**: Rendering PDFs, extracting pages, converting to images
- **Setup**: `pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js'`

### Image Processing
- **API**: Canvas API (native browser)
- **Use for**: Format conversion, compression, resizing, manipulation
- **Example**: `canvas.toBlob(callback, 'image/png', quality)`

### File Handling
- **API**: File API (native browser)
- **Use for**: Reading files, creating downloads
- **Example**: `FileReader`, `URL.createObjectURL()`, `Blob`

### Date/Time Operations
- **API**: Date object and Intl (native browser)
- **Use for**: Date calculations, timezone conversions, formatting
- **Example**: `Intl.DateTimeFormat`, `Date` methods

### PDF Generation
- **Libraries**: jsPDF or pdfmake (via CDN)
- **Use for**: Creating PDFs from content (e.g., markdown to PDF)

### Markdown Parsing
- **Libraries**: marked.js or showdown.js (via CDN)
- **Use for**: Converting markdown to HTML

### API Calls
- **API**: Fetch API (native browser)
- **Use for**: Calling external APIs (e.g., OpenRouter for LLMs)
- **Security**: User provides API key, store in localStorage or pass per-request

## Tool Categories

Organize tools into these categories on the landing page:
- **PDF Tools**: PDF manipulation, conversion, extraction
- **Image Tools**: Image format conversion, compression, editing
- **Date/Time Tools**: Date calculations, timezone conversions
- **Text Tools**: Markdown processing, text manipulation
- **API Tools**: LLM interfaces, external API integrations
- **Other**: Miscellaneous utilities

## Landing Page Structure

The index.html uses a compact, space-efficient layout:

### Header Section
- Page title: "Tools"
- Subtitle: "A collection of web-based utilities for everyday tasks"

### Table of Contents
- "Tool Categories:" label followed by bold category links separated by "|" dividers
- Links are anchor-based (e.g., `#pdf-tools`) for quick navigation
- Empty categories auto-hide when they contain no tools
- **Styling**:
  - Display: flex with wrap
  - Gap: 0.75rem between items
  - Font size: 0.85rem
  - Margin bottom: 0.75rem
  - Line height: centered vertically with align-items: center
  - Link color: soft blue (#6b8dd6)
  - Link hover: underline text-decoration
- **Tool counts**: Displayed as circular badges
  - Background: soft blue (#6b8dd6)
  - Text color: white
  - Font size: 0.75rem (bold weight 600)
  - Width/height: 1.5rem (perfect circle)
  - Display: inline-flex with centered content
  - Margin left: 0.35rem for spacing from category name
  - Auto-updates as tools are filtered

### Search Box
- Compact search input below TOC
- **Styling**:
  - Padding: 0.4rem 0.75rem
  - Font size: 0.85rem
  - Margin bottom: 0.75rem
  - Placeholder text: **italics** for visual distinction
- Real-time filtering across all visible tools
- Updates section visibility and tool counts dynamically

### Tool Sections
- Organized by category (PDF Tools, Date/Time Tools, Image Tools, Text Tools, API Tools, Other)
- **Section header styling**:
  - Font size: 1.25rem
  - Font weight: 700 (bold)
  - Margin top: 0.75rem
  - Margin bottom: 0.4rem
  - Display: flex with gap and align-items
- Empty sections automatically hide if they have 0 tools
- Section visibility updates dynamically with search results
- TOC links and separators hide/show based on section visibility

### Tool Grid Layout
- **Grid**: `repeat(auto-fill, minmax(200px, 1fr))` - auto-fills columns responsively
- **Gap**: 0.5rem between items
- **Margin top**: 0.5rem
- **Tool Card Styling**:
  - Padding: 0.5rem (compact spacing)
  - Border: 1px solid (muted border color)
  - Border radius: var(--pico-border-radius)
  - Background: var(--pico-card-background-color)
  - Display: flex, flex-direction: column
  - Transition: all 0.2s
  - Text decoration: none
  - Color: inherit
  - **Title (h3)**:
    - Font size: 0.9rem
    - Font weight: 600
    - Margin bottom: 0.15rem
    - Color: inherit
  - **Description (p)**:
    - Font size: 0.75rem
    - Color: muted color
    - Line height: 1.3
    - Margin: 0
- **Hover effect**:
  - Border color changes to soft blue (#6b8dd6)
  - Subtle visual feedback
- **Icons**: Hidden (not displayed in cards)

### Tool Card Format
```html
<a href="tool-name.html" class="tool-card">
    <h3>Tool Name</h3>
    <p>Brief description of what the tool does.</p>
</a>
```

### Search Functionality
- Filters tools by title and description
- Updates section visibility (hides sections with no matching tools)
- Updates tool counts dynamically
- Manages TOC link and separator visibility based on filtered results

## Tool Page Visual Design

All individual tool pages (pdf-to-image.html, timezone-converter.html, etc.) follow consistent styling:

### Page Layout
- Main container uses `.container` class from Pico CSS
- Header section with `<hgroup>` for title and subtitle
- Tool content wrapped in semantic HTML (`<section>`, `<article>`, `<fieldset>`)

### Back Navigation
- Positioned at the top (before h1) and bottom of every tool page
- **Styling** (`.back-link` class):
  - Display: inline-flex
  - Align items: center
  - Gap: 0.35rem (space between arrow and text)
  - Font weight: bold
  - Padding: 0.4rem 0.6rem
  - Border radius: var(--pico-border-radius)
  - Color: soft blue (#6b8dd6)
  - Transition: all 0.2s
  - **Hover state**:
    - Background: rgba(107, 141, 214, 0.1) (subtle light blue background)
    - Color: darker soft blue (#5b7dc6)

### Tool Page Color Scheme
- Link color: soft blue (#6b8dd6)
- Button color: soft blue (#6b8dd6)
  - Hover: darker soft blue (#5b7dc6)
  - Disabled: light soft blue (#9baee6) with 0.6 opacity
- Consistent with landing page for unified visual experience

### Tool-Specific Styling
- Each tool may have additional custom styles for its specific UI
- Use consistent spacing, colors, and transitions
- Leverage Pico CSS variables where possible
- Apply custom colors directly to elements (not via CSS variables that Pico doesn't support)

## Code Style Preferences

- Use concise variable names (e, el, i, j) when context is clear
- Prefer async/await over promise chains
- Comment only when logic is non-obvious
- Keep functions small and focused
- Always validate user input
- Handle errors gracefully with clear messages

## Key Constraints

- **No build pipeline** - direct push to GitHub, no compilation
- **Single file per tool** - everything self-contained in root directory
- **Performance first** - lightweight, fast loading
- **Portable** - works anywhere with a browser
- **No frameworks** - vanilla JS only
- **Clean URLs** - Tools in root for `yourdomain.com/tool-name.html` paths

## Quality Checklist

Before considering a tool complete:
- [ ] Spec document exists in `.dev/specs/` directory (or create from code)
- [ ] Tool does ONE thing well
- [ ] Tool file is in root directory (not subdirectory)
- [ ] Back navigation to index.html present (top and bottom)
- [ ] File size limits displayed and enforced
- [ ] Error messages are clear and helpful
- [ ] Loading states inform user during processing
- [ ] Follows Pico CSS styling conventions
- [ ] Works on mobile (responsive)
- [ ] Tool card added to index.html in correct category
- [ ] Tested with edge cases from spec
- [ ] localStorage usage (if any) is documented in code
- [ ] Spec updated if code was modified directly

### Visual Design Checklist
- [ ] Tool name uses Title Case (no icons/emojis)
- [ ] Consistent color scheme: soft blue (#6b8dd6) for links/buttons
- [ ] Back links styled with `.back-link` class (padding, border-radius, hover effects)
- [ ] All buttons use soft blue color scheme with proper hover/disabled states
- [ ] Spacing and padding match guidelines (0.4rem-1rem range)
- [ ] Typography follows font size guidelines (0.75rem-1.25rem range)
- [ ] Transitions set to 0.2s for all interactive elements
- [ ] Page title matches landing page tool card title exactly
- [ ] No icons/emojis in page headings or tool names

## Current Tools

### PDF Tools
- **PDF to Image Converter** (pdf-to-image.html)
  - Converts PDF pages to PNG or JPEG images
  - Supports page selection and format choice
  - File size limit: 50 MB

### Date/Time Tools
- **Timezone Converter** (timezone-converter.html)
  - Converts dates/times between IANA timezones
  - Displays DST information
  - IANA timezone support with auto-detection

- **Unix Timestamp Converter** (unix-timestamp.html)
  - Converts Unix timestamps to human-readable dates
  - Converts dates to Unix timestamps (seconds/milliseconds)
  - Auto-detects or manually specifies timestamp units

- **DateTime Format Converter** (datetime-format-converter.html)
  - Parses and reformats date/time strings
  - Supports standard formats (ISO, RFC2822) and custom patterns
  - Token-based formatting (YYYY, MM, DD, HH, mm, ss)
  - Custom format support with timezone awareness

## Working with Claude Code

### When building a new tool:
1. Always reference the spec file in `.dev/specs/`
2. Create the tool HTML file in the root directory
3. Follow the patterns documented above
4. Ask clarifying questions if the spec is unclear
5. Test edge cases mentioned in the spec
6. Update this file when adding new tools to the "Current Tools" section

### When iterating on existing tools:
1. Read the current implementation first
2. Understand the existing patterns
3. Make incremental changes
4. Preserve working functionality
5. Update the spec in `.dev/specs/` to match any changes

### When working with code that has no spec:
1. Generate a spec by analyzing the existing code
2. Save it to `.dev/specs/tool-name-spec.md`
3. Use the spec for future modifications

### Keeping specs synchronized:
- If you modify code directly, update the spec to match
- If you modify the spec, update the code to match
- Commit both together to keep them in sync
- The spec is documentation, not just a build artifact

## Notes

- This repo is deployed to GitHub Pages
- All tools must work client-side (no backend)
- Performance matters - keep files small and fast
- Favor simplicity over cleverness
- Development files in `.dev/` are not web-accessible but are in git
- Tool HTML files stay in root for clean GitHub Pages URLs