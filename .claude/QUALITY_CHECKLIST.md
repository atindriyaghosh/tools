# Quality Checklist

Before considering a tool complete:

## Core Functionality
- [ ] Tool does ONE thing well and does it correctly
- [ ] All major features work as designed
- [ ] Edge cases handled (empty input, oversized files, special characters)
- [ ] Error messages are clear and helpful (specific, actionable)

## File & Project Structure
- [ ] Tool file is in root directory (not subdirectory)
- [ ] common-styles.css is referenced (not duplicate button styling)
- [ ] Tool-specific CSS is inline only (no separate .css file)
- [ ] All JavaScript is vanilla (no frameworks)
- [ ] No console errors or warnings

## User Feedback & Status
- [ ] Status messages appear immediately AFTER upload area (not at bottom)
- [ ] Buttons are disabled during processing (prevent duplicate submissions)
- [ ] Loading states: "Processing...", then "Complete!" or "Error: reason"
- [ ] Status messages stay visible long enough (minimum 2-3 seconds)
- [ ] No status/error messages disappear too quickly
- [ ] Upload area styling is consistent (padding: 0.75rem 1rem)

## Navigation & Naming
- [ ] Back navigation to index.html present (top and bottom)
- [ ] Tool name uses Title Case (no icons/emojis in title)
- [ ] Page title matches landing page tool card title EXACTLY
- [ ] Semantic HTML used (`<main>`, `<article>`, `<hgroup>`)
- [ ] Form fields have proper labels

## File Handling (if applicable)
- [ ] File size validated AND file type validated
- [ ] File validation errors are user-friendly ("Max 50 MB, got 120 MB")
- [ ] Blob URLs are revoked after downloads (no memory leaks)
- [ ] Buttons disabled during download to prevent duplicates

## Mobile & Accessibility
- [ ] Works on mobile (responsive, no horizontal scroll)
- [ ] Tested with DevTools mobile view (iPhone 12, Android)
- [ ] Buttons are clickable size (minimum 44x44px)
- [ ] localStorage usage documented in code (if used)
- [ ] Proper ARIA labels and roles where needed

## Before Landing Page Add
- [ ] Tool card added to index.html in correct category
- [ ] Tool description is searchable (has relevant keywords)
- [ ] README.md updated with new tool entry (if applicable)
