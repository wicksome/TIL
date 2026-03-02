#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

OUTPUT_FILE="$ROOT_DIR/pages.adoc"
TMP_FILE="$(mktemp)"

{
  cat <<'HEADER'
= Pages
:docinfo: shared
:source-highlighter: highlight.js
:toc: left

전체 페이지 링크 모음입니다.

== AsciiDoc Pages
HEADER

  while IFS= read -r -d '' file; do
    rel="${file#./}"
    base="$(basename "$rel")"

    if [[ "$rel" == "pages.adoc" ]]; then
      continue
    fi

    if [[ "$rel" == "_old/"* ]]; then
      continue
    fi

    if [[ "$base" == .* ]]; then
      continue
    fi

    html_path="${rel%.adoc}.html"
    printf '* link:%s[`%s`]\n' "$html_path" "$rel"
  done < <(find . -type f -name '*.adoc' -print0 | sort -z)

  cat <<'SECTION'

== Standalone HTML Pages
SECTION

  while IFS= read -r -d '' file; do
    rel="${file#./}"
    base="$(basename "$rel")"

    if [[ "$rel" == "docinfo.html" ]]; then
      continue
    fi

    if [[ "$rel" == "_old/"* ]]; then
      continue
    fi

    if [[ -f "${rel%.html}.adoc" ]]; then
      continue
    fi

    if [[ "$base" == .* ]]; then
      continue
    fi

    printf '* link:%s[`%s`]\n' "$rel" "$rel"
  done < <(find . -type f -name '*.html' -print0 | sort -z)
} > "$TMP_FILE"

mv "$TMP_FILE" "$OUTPUT_FILE"
