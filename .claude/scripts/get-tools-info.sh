#!/bin/bash
# Script to extract tool information from HTML files for README analysis

TOOLS_DIR="${1:-.}"
OUTPUT_FORMAT="${2:-json}"  # json or text

# Function to extract text from HTML
extract_title() {
  local file="$1"
  grep -m1 '<title>\|<h1>\|<h2>' "$file" | sed 's/<[^>]*>//g' | xargs
}

# Function to extract description from meta or comments
extract_description() {
  local file="$1"
  grep -oP 'meta name="description" content="\K[^"]+' "$file" | head -1 || \
  grep -oP '<!-- Description:\s*\K[^-]+' "$file" | head -1 || \
  echo ""
}

# Function to parse library name and version from URL
parse_library() {
  local url="$1"

  # jsdelivr CDN format: https://cdn.jsdelivr.net/npm/package@version/...
  # Handles both regular packages and scoped packages like @picocss/pico@version
  if [[ "$url" =~ cdn\.jsdelivr\.net/npm/(.*?)@([^/]+)/ ]]; then
    local name="${BASH_REMATCH[1]}"
    local version="${BASH_REMATCH[2]}"
    # Clean up scoped package names (e.g., @picocss/pico -> picocss-pico)
    name=$(echo "$name" | sed 's|^@||; s|/|-|g')
    echo "$name|$version|$url"
  # cdnjs format: https://cdnjs.cloudflare.com/ajax/libs/package/version/...
  elif [[ "$url" =~ cdnjs\.cloudflare\.com/ajax/libs/([^/]+)/([^/]+)/ ]]; then
    local name="${BASH_REMATCH[1]}"
    local version="${BASH_REMATCH[2]}"
    echo "$name|$version|$url"
  # unpkg format: https://unpkg.com/package@version/...
  elif [[ "$url" =~ unpkg\.com/(.*?)@([^/]+)/ ]]; then
    local pkg="${BASH_REMATCH[1]}"
    local version="${BASH_REMATCH[2]}"
    pkg=$(echo "$pkg" | sed 's|^@||; s|/|-|g')
    echo "$pkg|$version|$url"
  else
    # Fallback: try to extract from filename
    local filename=$(basename "$url" | sed 's/\..*//')
    echo "$filename||$url"
  fi
}

# Function to extract libraries used in a tool
extract_libraries() {
  local file="$1"

  # Extract all script src and link href with CDN URLs
  # Filter to only actual library URLs (not preconnect or metadata links)
  grep -oE '(src|href)="[^"]*"' "$file" | grep -oE '"[^"]*"' | tr -d '"' | \
  grep -E '(cdn\.jsdelivr\.net/npm|cdnjs\.cloudflare\.com/ajax/libs|unpkg\.com)' | \
  grep -v -E '(common-styles|favicon)' | \
  sort -u
}

# Generate output based on format
if [ "$OUTPUT_FORMAT" = "json" ]; then
  echo "{"
  echo '  "tools": ['

  first=true
  for file in "$TOOLS_DIR"/*.html; do
    [ -f "$file" ] || continue
    [ "$(basename "$file")" = "index.html" ] && continue

    filename=$(basename "$file" .html)
    title=$(extract_title "$file")
    description=$(extract_description "$file")

    if [ "$first" = false ]; then
      echo ","
    fi
    first=false

    cat <<ITEM
    {
      "filename": "$filename",
      "file": "$(basename "$file")",
      "title": "$title",
      "description": "$description",
      "libraries": [
ITEM

    # Extract and add libraries
    lib_first=true
    while IFS= read -r lib_url; do
      [ -z "$lib_url" ] && continue
      lib_info=$(parse_library "$lib_url")
      IFS='|' read -r name version url <<< "$lib_info"

      if [ "$lib_first" = false ]; then
        echo ","
      fi
      lib_first=false

      cat <<LIBITEM
        {
          "name": "$name",
          "version": "$version",
          "url": "$url"
        }
LIBITEM
    done < <(extract_libraries "$file")

    cat <<ITEM
      ]
    }
ITEM
  done

  echo ""
  echo "  ]"
  echo "}"
else
  # Text format
  echo "=== Tools Inventory ==="
  echo ""

  count=0
  for file in "$TOOLS_DIR"/*.html; do
    [ -f "$file" ] || continue
    [ "$(basename "$file")" = "index.html" ] && continue

    filename=$(basename "$file" .html)
    title=$(extract_title "$file")
    description=$(extract_description "$file")

    ((count++))
    echo "$count. $filename"
    echo "   Title: $title"
    if [ -n "$description" ]; then
      echo "   Description: $description"
    fi

    # Extract and display libraries
    lib_count=0
    while IFS= read -r lib_url; do
      [ -z "$lib_url" ] && continue
      lib_info=$(parse_library "$lib_url")
      IFS='|' read -r name version url <<< "$lib_info"

      if [ $lib_count -eq 0 ]; then
        echo "   Libraries:"
      fi
      ((lib_count++))

      if [ -n "$version" ] && [ "$version" != "" ]; then
        echo "      - $name v$version"
      else
        echo "      - $name"
      fi
    done < <(extract_libraries "$file")

    echo ""
  done

  echo "Total tools: $count"
fi
