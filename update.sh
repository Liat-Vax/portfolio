#!/bin/bash
# Run this from the Portfolio folder to push all changes to GitHub
cd "$(dirname "$0")"
git add -A
git commit -m "Update portfolio $(date '+%Y-%m-%d %H:%M')"
git push origin main
