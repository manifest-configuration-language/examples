#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

find . -name main.mcl -print \
  | sed -E 's#^\./##; s#/main\.mcl$##' \
  | sort > "$tmp_dir/example-directories.txt"
awk -F'[()]' '/^\| \[/ { print $2 }' README.md \
  | sed 's#/$##' \
  | sort > "$tmp_dir/readme-example-directories.txt"
awk -F'|' '
  /^\| \[/ {
    if (NF != 5 || $3 !~ /[^[:space:]]/ || $4 !~ /`mcl (check|render) [^`]+`/) {
      printf "README.md example row %d must include a description and an executable MCL command.\n", NR > "/dev/stderr"
      failed = 1
    }
  }
  END { exit failed }
' README.md
if ! diff -u "$tmp_dir/example-directories.txt" "$tmp_dir/readme-example-directories.txt"; then
  echo "README.md must list each directory containing main.mcl exactly once." >&2
  exit 1
fi

while IFS= read -r -d '' sample; do
  echo "Checking $sample"
  mcl check "$sample"
  actual="$tmp_dir/${sample#./}"
  actual="${actual%/main.mcl}.yaml"
  mkdir -p "$(dirname "$actual")"
  echo "Rendering $sample"
  mcl render "$sample" > "$actual"
done < <(find . -name main.mcl -print0 | sort -z)

while IFS= read -r -d '' expected; do
  sample="${expected%/expected.yaml}/main.mcl"
  actual="$tmp_dir/$sample"
  actual="${actual%/main.mcl}.yaml"
  diff -u "$expected" "$actual"
done < <(find adapters -name expected.yaml -print0 | sort -z)
