#!/bin/bash
cd "$(dirname "$0")"

echo "Finding Hebrew-named files in git..."

python3 << 'PYEOF'
import subprocess

result = subprocess.run(['git', 'ls-files', '-z', 'iec/', 'idf/'], capture_output=True)
files = result.stdout.split(b'\x00')

to_remove = []
for f in files:
    if f and any(b > 127 for b in f):
        fname = f.decode('utf-8', errors='replace')
        to_remove.append(fname)
        print(f"  Found: {fname}")

if to_remove:
    print(f"\nRemoving {len(to_remove)} Hebrew-named files...")
    for fname in to_remove:
        r = subprocess.run(['git', 'rm', '--cached', fname], capture_output=True, text=True)
        if r.returncode == 0:
            print(f"  Removed: {fname}")
        else:
            print(f"  Failed: {fname}: {r.stderr.strip()}")
else:
    print("No Hebrew-named files found - all clean!")
PYEOF

git commit -m "Remove remaining Hebrew-named files from git" && git push origin main
