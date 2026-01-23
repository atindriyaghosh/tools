---
description: Analyze README.md completeness and propose updates with tool inventory
allowed-tools: Bash(./.claude/scripts/get-tools-info.sh:*), Read, Edit, Glob
---

Comprehensive analysis of README.md and propose updates with current tool inventory.

This command:
- Scans all .html tool files in the root directory (includes all tools)
- Extracts tool names, titles, and descriptions from HTML files
- Compares against current README.md documentation
- Identifies missing tools and outdated information
- Reviews Tech Stack section (versions, links, accuracy)
- Reviews Libraries Used section (versions, links, completeness)
- Reviews Development section (commands, paths, relevance)
- Proposes concrete updates with formatted entries
- Suggests tool categorization/organization
- Validates links and references

**What it analyzes:**
- Complete tool inventory and documentation
- Section completeness (Overview, Tools, Tech Stack, Libraries, Development)
- Accuracy of versions and library information
- Missing tool descriptions or categories
- Outdated or broken information
- Tool naming consistency

**Output:**
- Full inventory of tools with status (documented/missing)
- Detailed analysis of each README section
- Proposed additions and corrections
- Formatted markdown snippets ready to use
- Summary of recommended changes

To use: `/update-readme` will perform full analysis and propose comprehensive updates to README.md.
