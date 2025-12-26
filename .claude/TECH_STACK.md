# Tech Stack

- **Framework**: None - vanilla JavaScript only
- **No React, Vue, or any JS frameworks** - keep it simple with plain HTML/JS
- **CSS**: Pico CSS (https://picocss.com/) for minimal, lightweight styling
- **Design**: Clean, minimal, functional - performance over visual flair
- **Single Responsibility**: Each tool does ONE thing well
- **Deployment**: GitHub Pages via GitHub Actions
  - **Build Process**: Bash script selectively copies production files to `_site/` directory
  - **Build Features**: Automatically updates copyright year in index.html footer based on current year
  - **Excluded from Deployment**: `.claude/`, `.dev/`, `.github/`, `.brainstorm/`, `.git/`, config files, LICENSE
  - **Trigger**: Automatic on push to main branch, or manual via workflow_dispatch
  - **Deployed Files**: All `.html` files, `common-styles.css`, `CNAME`, `.nojekyll`, `favicon.png`
