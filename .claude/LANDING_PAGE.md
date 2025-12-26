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
