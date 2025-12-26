# Standard Features to Include

Every tool must have:

1. **Back link**: Link to index.html at top and bottom
   - HTML: `<a href="index.html" class="back-link">← Back to Tools</a>`
   - Styling handled by `common-styles.css`

2. **File size limits** (if applicable): Display max file size in UI, validate on upload

3. **Error handling**: Clear error messages for user actions

4. **Loading states**: Inform users when processing is happening

5. **Semantic HTML**: Use `<main>`, `<article>`, `<hgroup>`, `<fieldset>`, `<section>` appropriately

6. **Accessibility**: Proper labels, ARIA attributes where needed

7. **Tool Name Format**:
   - Use Title Case (e.g., "Timezone Converter", "Unix Timestamp Converter")
   - No icons or emojis in tool names or page titles
   - Keep tool names clear and descriptive
   - Consistent naming across:
     - HTML `<title>` tag
     - Page `<h1>` heading
     - Landing page tool card title

8. **Mobile responsive**: Works on all screen sizes
