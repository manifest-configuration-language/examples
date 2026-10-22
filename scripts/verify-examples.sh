#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

while IFS= read -r -d '' sample; do
  echo "Checking $sample"
  mcl check "$sample"
  actual="$tmp_dir/${sample#./}"
  actual="${actual%/main.mcl}.yaml"
  mkdir -p "$(dirname "$actual")"
  echo "Rendering $sample"
  mcl render "$sample" > "$actual"
  expected="${sample%/main.mcl}/expected.yaml"
  if [[ ! -f "$expected" ]]; then
    echo "Missing expected output for $sample: $expected" >&2
    exit 1
  fi
  diff -u "$expected" "$actual"
done < <(find . -name main.mcl -print0 | sort -z)
