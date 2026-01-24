# Standard Features to Include

Every tool must have:

1. **Back link**: See @./PATTERNS.md for back navigation pattern (top and bottom of tool page)

2. **File handling** (if applicable): See @./FILE_UPLOAD_PATTERNS.md for file upload, validation, and status patterns

3. **Error handling**: Clear error messages for user actions
   - Include specific details (what went wrong, why, how to fix)
   - Show errors prominently (don't use small gray text)
   - Keep errors visible long enough to read (minimum 2-3 seconds)
   - See @./ERROR_HANDLING_GUIDE.md for error patterns

4. **Loading states**: Inform users when processing is happening
   - Show progress: "Processing page 1 of 10" (not just "Loading...")
   - Disable buttons during processing (prevent duplicate submissions)
   - Use status messages: "Processing...", then "Complete!" when done
   - Status div must appear immediately after upload area (not at bottom)

5. **Semantic HTML**: Use `<main>`, `<article>`, `<hgroup>`, `<fieldset>`, `<section>` appropriately

6. **Accessibility**: Proper labels, ARIA attributes where needed

7. **Naming conventions**: Use proper naming across all files, variables, and UI
   - Tool names use Title Case (no icons/emojis in titles)
   - Consistent naming across HTML `<title>`, `<h1>`, and landing page
   - See @./NAMING_CONVENTIONS.md for complete naming rules

8. **Mobile responsive**: Works on all screen sizes
   - Test with DevTools mobile view
   - No horizontal scrolling
   - Buttons clickable size (minimum 44x44px)
