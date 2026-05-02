#!/usr/bin/env bash

set -euo pipefail

echo "Installing Tree-sitter..."

APPNAME="tree-sitter-linux-x64.gz"
APPURL="https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.8/$APPNAME"
INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/tree-sitter"

detect_cmd() {
  command -v "$1" >/dev/null 2>&1
}

download() {
  local url="$1" target="$2"
  if detect_cmd curl; then
    curl -C - -L -f -o "$target" "$url"
  elif detect_cmd wget; then
    wget -c -O "$target" "$url"
  else
    echo "Error: Neither curl nor wget found." >&2
    exit 1
  fi
}

secure_remove() {
  if detect_cmd shred; then
    for f in "$@"; do
      [ -e "$f" ] || continue
      shred -vfzu "$f" 2>/dev/null || rm -f -- "$f"
    done
  else
    rm -f -- "$@"
  fi
}

main() {
  mkdir -p "$INSTALL_DIR"

  TMPDIR="$(mktemp -d)"
  TMPFILE="$TMPDIR/$APPNAME"

  trap 'rm -rf "$TMPDIR"; secure_remove "$TMPFILE" "$INSTALL_PATH.tmp" || true' EXIT

  if [ ! -f "$INSTALL_PATH" ]; then
    echo "Downloading $APPNAME..."
    download "$APPURL" "$TMPFILE"
    gunzip -c "$TMPFILE" > "$INSTALL_PATH.tmp"
    chmod +x "$INSTALL_PATH.tmp"
    mv "$INSTALL_PATH.tmp" "$INSTALL_PATH"
    if ! file "$INSTALL_PATH" | grep -qi 'executable'; then
      rm -f "$INSTALL_PATH"
      echo "Downloaded file doesn't look like an executable, aborting." >&2
      exit 1
    fi
    echo "Installed $INSTALL_PATH"
  else
    echo "Tree-sitter already installed at $INSTALL_PATH. Remove it first to reinstall."
  fi
}

main
