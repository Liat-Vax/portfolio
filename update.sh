#!/bin/bash
# Run this from the Portfolio folder to push all changes to GitHub
cd "$(dirname "$0")"
# Keep index.html in sync with portfolio.html (GitHub Pages needs index.html)
cp portfolio.html index.html
git add -A
git commit -m "Update portfolio $(date '+%Y-%m-%d %H:%M')"
git push origin main
