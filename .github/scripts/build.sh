#!/bin/bash

# GitHub Pages Build Script
# Copies only production files to _site/ directory, excluding development files

set -e  # Exit on error

# Configuration
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SITE_DIR="${REPO_ROOT}/_site"

echo "Building GitHub Pages site..."
echo "Repository root: $REPO_ROOT"

# 1. Clean and create _site directory
echo ""
echo "Step 1: Preparing _site directory..."
if [ -d "$SITE_DIR" ]; then
  rm -rf "$SITE_DIR"
  echo "  Cleaned existing _site/"
fi
mkdir -p "$SITE_DIR"
echo "  Created _site/"

# 2. Copy HTML files
echo ""
echo "Step 2: Copying HTML files..."
html_count=0
current_year=$(date +%Y)
for file in "$REPO_ROOT"/*.html; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    cp "$file" "$SITE_DIR/$filename"
    # Update copyright year in index.html
    if [ "$filename" = "index.html" ]; then
      sed -i "s/© [0-9]\{4\} atindriyaghosh/© $current_year atindriyaghosh/g" "$SITE_DIR/$filename"
    fi
    echo "  ✓ $filename"
    ((++html_count))
  fi
done
echo "  Total: $html_count HTML files"

# 3. Copy other production files
echo ""
echo "Step 3: Copying production assets..."
files_to_copy=(
  "common-styles.css"
  "CNAME"
  ".nojekyll"
  "favicon.png"
)

for file in "${files_to_copy[@]}"; do
  if [ -f "$REPO_ROOT/$file" ]; then
    cp "$REPO_ROOT/$file" "$SITE_DIR/$file"
    echo "  ✓ $file"
  else
    echo "  ⚠ $file (not found, skipping)"
  fi
done

# 4. Validate required files exist
echo ""
echo "Step 4: Validating required files..."
required_files=(
  "index.html"
  "CNAME"
  ".nojekyll"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$SITE_DIR/$file" ]; then
    echo "  ✗ ERROR: Required file missing: $file"
    exit 1
  fi
  echo "  ✓ $file"
done

# 5. Print summary
echo ""
echo "✓ Build complete!"
echo ""
echo "Deployment manifest:"
ls -1 "$SITE_DIR" | sed 's/^/  - /'
echo ""
echo "Total files: $(find "$SITE_DIR" -type f | wc -l)"
