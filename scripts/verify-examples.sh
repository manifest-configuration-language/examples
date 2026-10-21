#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

while IFS= read -r -d '' sample; do
  echo "Checking $sample"
  mcl check "$sample"
done < <(find . -name main.mcl -print0 | sort -z)

while IFS= read -r -d '' expected; do
  sample="${expected%/expected.yaml}/main.mcl"
  actual="$tmp_dir/$(basename "$(dirname "$expected")").yaml"
  echo "Rendering $sample"
  mcl render "$sample" > "$actual"
  diff -u "$expected" "$actual"
done < <(find adapters -name expected.yaml -print0 | sort -z)
