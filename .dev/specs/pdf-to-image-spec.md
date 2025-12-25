# PDF to Image Converter

## Purpose
Converts PDF pages to high-quality PNG or JPEG images with selective page conversion.

## Features
- Upload PDF via drag-and-drop or file picker
- Preview thumbnails of all pages in a grid layout
- Select individual pages or use Select All/Deselect All
- Choose output format (PNG or JPEG)
- Download converted images individually
- 50 MB file size limit with validation

## UI Layout
- **Header**: Title "PDF to Image Converter" with subtitle
- **Upload Area**: Dashed-border drop zone with click-to-upload support
  - Shows file size limit (50 MB)
  - Visual feedback on drag-over
- **Controls Section** (hidden until PDF loaded):
  - Output format dropdown (PNG/JPEG)
  - Select All / Deselect All links
  - Page thumbnail grid (auto-fill columns, min 150px)
  - Convert button (disabled until pages selected)
- **Status Area**: Shows loading, progress, and success/error messages
- **Footer**: Back link to index.html

## File Handling
- **Accepted formats**: PDF files only (.pdf, application/pdf)
- **Size limits**: Maximum 50 MB
- **Validation requirements**:
  - Check MIME type on drop
  - Validate file size before processing
- **Output format**: Individual image files downloaded automatically
  - Filename format: `page-{number}.{format}`
  - PNG or JPEG based on selection
  - JPEG quality: 0.95

## Libraries/APIs Required
- **pdf.js**: PDF rendering library
  - CDN: https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js
  - Worker: https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js
- **Browser APIs**:
  - Canvas API for rendering
  - File API for reading uploads
  - Blob API for creating downloadable images

## Implementation Notes
- **Edge cases**:
  - Empty PDF (0 pages)
  - Very large PDFs (many pages) - thumbnails render sequentially
  - Corrupted/invalid PDFs - catch and display error
  - Non-PDF file dropped - show error message
- **Performance considerations**:
  - Thumbnails rendered at 0.5x scale for speed
  - Full-size images rendered at 2.0x scale for quality
  - Pages converted sequentially to avoid memory issues
- **State management**:
  - `selectedPages` Set tracks selected page numbers
  - `pdfDoc` holds the loaded PDF document
- **Error handling**:
  - File too large: Shows size in MB with limit reminder
  - Invalid PDF: Shows error message from pdf.js
  - Conversion errors: Shows specific error message
- **Accessibility**:
  - Status element uses aria-invalid for error states
  - Upload area is keyboard accessible (hidden file input)

## Category
PDF Tools

## Tool Card Info
- **Icon**: 📄→🖼️
- **Title**: PDF to Image
- **Description**: Convert PDF pages to PNG or JPEG images
