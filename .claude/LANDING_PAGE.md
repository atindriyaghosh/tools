# Landing Page Structure

The index.html layout consists of:

- **Header**: "Tools" title with subtitle
- **Table of Contents**: Category links with tool count badges (auto-hide empty categories)
- **Search box**: Real-time tool filtering by title and description
- **Tool sections**: Organized by category, each with a grid of tool cards
- **Tool cards**: Link, title, and brief description
- **Footer**: Copyright notice and GitHub repository link (auto-updated year during build)

## Tool Categories

Organize tools into these categories on the landing page:
- **PDF Tools**: PDF manipulation, conversion, extraction
- **Image Tools**: Image format conversion, compression, editing
- **Date/Time Tools**: Date calculations, timezone conversions
- **Text Tools**: Markdown processing, text manipulation
- **API Tools**: LLM interfaces, external API integrations
- **Other**: Miscellaneous utilities

## Adding a Tool Card

```html
<a href="tool-name.html" class="tool-card">
    <h3>Tool Name</h3>
    <p>Brief description of what the tool does.</p>
</a>
```

Place in the appropriate category section.

## Tool Icons & Titles

**Tool Card Titles:**
- Use Title Case (e.g., "PDF Merge", "Unix Timestamp Converter")
- No emojis or icons in HTML `<title>` or `<h1>` tags
- Keep names clear and descriptive (searchable keywords)
- Titles must match EXACTLY across:
  - HTML `<title>` tag (page title)
  - `<h1>` heading on tool page
  - Tool card link on landing page

**Emoji Usage:**
- Tool card descriptions CAN include emojis (optional, for visual interest)
- Example: "📄 Combine multiple PDF files into a single document"
- Emoji is decorative only, not in the title

## Category Organization Tips

When adding new tools:

1. **Keep similar tools together** - PDF tools, Date/Time tools, etc.
2. **If a category has only 1 tool**, consider moving it to "Other" (unless it's a major category)
3. **Periodically review categories** as more tools are added (may need reorganization)
4. **Subcategories** (optional) - For large categories (10+ tools), consider subcategories:
   - PDF Tools → "Merge/Combine", "Convert", "Extract"
   - Date/Time Tools → "Converters", "Calculators", "Formatters"

**Current Categories:**
- **PDF Tools**: PDF manipulation, conversion, extraction (growing category)
- **Image Tools**: Image format conversion, compression, editing
- **Date/Time Tools**: Date calculations, timezone conversions, formatting
- **Text Tools**: Markdown processing, text manipulation, formatting
- **API Tools**: LLM interfaces, external API integrations
- **Other**: Miscellaneous utilities (catch-all for 1-2 tools)
