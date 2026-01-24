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

## Tool Card Titles & Naming

**For comprehensive naming conventions:** See @./NAMING_CONVENTIONS.md for all naming rules including tool name format, emoji usage guidelines, and consistency requirements across pages.

## Category Organization Tips

When adding new tools:

1. **Keep similar tools together** - PDF tools, Date/Time tools, etc.
2. **If a category has only 1 tool**, consider moving it to "Other" (unless it's a major category)
3. **Periodically review categories** as more tools are added (may need reorganization)
4. **Subcategories** (optional) - For large categories (10+ tools), consider subcategories:
   - PDF Tools → "Merge/Combine", "Convert", "Extract"
   - Date/Time Tools → "Converters", "Calculators", "Formatters"

**Note**: See "Tool Categories" section above (lines 14-20) for the definitive category list and organization.
