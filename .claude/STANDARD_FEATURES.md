# Standard Features to Include

Every tool must have:

1. **Back link**: Link to index.html at top and bottom
   - HTML: `<a href="index.html" class="back-link">← Back to Tools</a>`
   - Styling handled by `common-styles.css`

2. **File size limits** (if applicable): Display max file size in UI, validate on upload
   - Validate both FILE SIZE and FILE TYPE (not just size alone)
   - Show user-friendly errors: "File too large: 120 MB. Maximum 50 MB."
   - Show file type errors: "Only PDF files are supported, got DOCX"

3. **Status message placement** (for file upload tools):
   - Status div MUST appear immediately after upload area (not at bottom of form)
   - Users need to see upload errors/feedback instantly after clicking upload
   - Don't make users scroll to see error messages

4. **Error handling**: Clear error messages for user actions
   - Include specific details (what went wrong, why, how to fix)
   - Show errors prominently (don't use small gray text)
   - Keep errors visible long enough to read (minimum 2-3 seconds)

5. **Loading states**: Inform users when processing is happening
   - Show progress: "Processing page 1 of 10" (not just "Loading...")
   - Disable buttons during processing (prevent duplicate submissions)
   - Use status messages: "Processing...", then "Complete!" when done
   - For long operations, show estimated time if possible

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
