#!/usr/bin/env bash
set -euo pipefail

BLOG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ROOT_DIR="$(cd "$BLOG_DIR/.." && pwd)"
PAGES_DIR="$BLOG_DIR/docs/modules/ROOT/pages"
TIL_PAGES_DIR="$PAGES_DIR/til"
ASSETS_DIR="$BLOG_DIR/docs/modules/ROOT/assets"
ATTACHMENTS_DIR="$ASSETS_DIR/attachments"
TOOLS_ATTACH_DIR="$ATTACHMENTS_DIR/tools"
NAV_FILE="$BLOG_DIR/docs/modules/ROOT/nav.adoc"
ABOUT_SRC_FILE="$ROOT_DIR/about.adoc"

mkdir -p "$PAGES_DIR" "$ATTACHMENTS_DIR"
rm -rf "$TIL_PAGES_DIR"
mkdir -p "$TIL_PAGES_DIR"
rm -rf "$TOOLS_ATTACH_DIR"
mkdir -p "$TOOLS_ATTACH_DIR"

while IFS= read -r -d '' file; do
  rel="${file#"$ROOT_DIR"/}"
  base="$(basename "$rel")"

  if [[ "$rel" == _old/* ]]; then
    continue
  fi

  if [[ "$rel" == "pages.adoc" ]]; then
    continue
  fi

  if [[ "$base" == .* ]]; then
    continue
  fi

  target="$TIL_PAGES_DIR/$rel"
  mkdir -p "$(dirname "$target")"
  cp "$file" "$target"
done < <(
  find "$ROOT_DIR" \
    -path "$ROOT_DIR/.git" -prune -o \
    -path "$BLOG_DIR" -prune -o \
    -path "$ROOT_DIR/_old" -prune -o \
    -type f -name '*.adoc' -print0 | sort -z
)

if [[ -d "$ROOT_DIR/tools" ]]; then
  while IFS= read -r -d '' file; do
    rel="${file#"$ROOT_DIR/tools"/}"
    rel="${rel#/}"
    base="$(basename "$rel")"

    if [[ "$base" == .* ]]; then
      continue
    fi

    target="$TOOLS_ATTACH_DIR/$rel"
    mkdir -p "$(dirname "$target")"
    cp "$file" "$target"
  done < <(find "$ROOT_DIR/tools" -type f -print0 | sort -z)
fi

cat > "$PAGES_DIR/index.adoc" <<'INDEX'
= Documents

* xref:about.adoc[About]
* xref:pages.adoc[All TIL Pages]
* xref:til/index.adoc[TIL Home]
* xref:tools.adoc[Tools]
INDEX

if [[ -f "$ABOUT_SRC_FILE" ]]; then
  cp "$ABOUT_SRC_FILE" "$PAGES_DIR/about.adoc"
else
  cat > "$PAGES_DIR/about.adoc" <<'ABOUT'
= About

This page introduces the Documents site.
ABOUT
fi

{
  cat <<'TOOLS_HEADER'
= Tools

`tools` 하위 HTML 유틸 링크 모음입니다.

TOOLS_HEADER

  while IFS= read -r -d '' file; do
    rel="${file#"$TOOLS_ATTACH_DIR"/}"
    if [[ "$rel" != *.html ]]; then
      continue
    fi

    label="$rel"
    if [[ "$rel" == */index.html ]]; then
      label="${rel%/index.html}"
    else
      label="${rel%.html}"
    fi

    if [[ "$rel" == */index.html ]]; then
      url="/tools/${rel%/index.html}"
    else
      url="/tools/$rel"
    fi

    printf '* link:%s[`%s`]\n' "$url" "$label"
  done < <(find "$TOOLS_ATTACH_DIR" -type f -name '*.html' -print0 | sort -z)
} > "$PAGES_DIR/tools.adoc"

{
  cat <<'HEADER'
= All TIL Pages

TIL 하위 모든 AsciiDoc 페이지 목록입니다.

HEADER

  while IFS= read -r -d '' file; do
    rel="${file#"$PAGES_DIR"/}"

    if [[ "$rel" == "index.adoc" || "$rel" == "pages.adoc" || "$rel" == "tools.adoc" ]]; then
      continue
    fi

    if [[ "$rel" == "til/index.adoc" ]]; then
      printf '* xref:%s[TIL Home]\n' "$rel"
      continue
    fi

    printf '* xref:%s[`%s`]\n' "$rel" "$rel"
  done < <(find "$PAGES_DIR" -type f -name '*.adoc' -print0 | sort -z)
} > "$PAGES_DIR/pages.adoc"

{
  cat <<'NAV_HEADER'
* Blog
** xref:index.adoc[Home]
** xref:about.adoc[About]
** xref:pages.adoc[All Pages]
** xref:tools.adoc[Tools]
* Documents
NAV_HEADER

  stars() {
    local depth="$1"
    local s=""
    local i
    for ((i = 0; i < depth; i++)); do
      s="${s}*"
    done
    printf '%s' "$s"
  }

  nav_line() {
    local depth="$1"
    local content="$2"
    printf '%s %s\n' "$(stars "$depth")" "$content"
  }

  emit_dir_tree() {
    local dir="$1"
    local rel="$2"
    local depth="$3"
    local name
    name="$(basename "$rel")"
    local readme="$dir/README.adoc"

    if [[ -f "$readme" ]]; then
      nav_line "$depth" "xref:til/$rel/README.adoc[$name]"
    else
      nav_line "$depth" "$name"
    fi

    while IFS= read -r -d '' file; do
      local base
      base="$(basename "$file")"
      if [[ "$base" == "README.adoc" || "$base" == .* ]]; then
        continue
      fi

      local file_rel label
      file_rel="${file#"$TIL_PAGES_DIR"/}"
      label="${base%.adoc}"
      nav_line "$((depth + 1))" "xref:til/$file_rel[$label]"
    done < <(find "$dir" -mindepth 1 -maxdepth 1 -type f -name '*.adoc' -print0 | sort -z)

    while IFS= read -r subdir; do
      local subbase
      subbase="$(basename "$subdir")"
      if [[ "$subbase" == .* ]]; then
        continue
      fi
      emit_dir_tree "$subdir" "$rel/$subbase" "$((depth + 1))"
    done < <(find "$dir" -mindepth 1 -maxdepth 1 -type d | sort)
  }

  root_files=()
  while IFS= read -r -d '' file; do
    rel="${file#"$TIL_PAGES_DIR"/}"
    if [[ "$rel" == "index.adoc" ]]; then
      continue
    fi
    if [[ "$rel" != */* ]]; then
      root_files+=("$rel")
    fi
  done < <(find "$TIL_PAGES_DIR" -maxdepth 1 -type f -name '*.adoc' -print0 | sort -z)

  if [[ ${#root_files[@]} -gt 0 ]]; then
    nav_line 2 "Misc"
    for rel in "${root_files[@]}"; do
      label="${rel%.adoc}"
      nav_line 3 "xref:til/$rel[$label]"
    done
  fi

  while IFS= read -r dir; do
    top="$(basename "$dir")"
    if [[ "$top" == .* ]]; then
      continue
    fi
    emit_dir_tree "$dir" "$top" 2
  done < <(find "$TIL_PAGES_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
} > "$NAV_FILE"
