#!/usr/bin/env bash
set -euo pipefail

SITE_DIR="${1:-}"
if [[ -z "$SITE_DIR" ]]; then
  echo "usage: $0 <site-dir>" >&2
  exit 1
fi

if [[ ! -d "$SITE_DIR/blog" ]]; then
  echo "missing blog output directory: $SITE_DIR/blog" >&2
  exit 1
fi

# Expose the main blog component at the site root while keeping /blog paths.
cp -a "$SITE_DIR/blog/." "$SITE_DIR/"

# Preserve tools as real static directories/files under /tools/**.
if [[ -d "$SITE_DIR/_attachments/tools" ]]; then
  mkdir -p "$SITE_DIR/tools"
  cp -a "$SITE_DIR/_attachments/tools/." "$SITE_DIR/tools/"
fi
