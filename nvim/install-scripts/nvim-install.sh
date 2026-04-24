#!/usr/bin/env bash

set -euo pipefail

echo "Installing Neovim AppImage..."

APPNAME="nvim-linux-x86_64.appimage"
APPURL="https://github.com/neovim/neovim/releases/download/nightly"
INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/nvim"
ZSYNC_FILE="$APPNAME.zsync"
ZSYNC_URL="$APPURL/$ZSYNC_FILE"

detect_cmd() {
  command -v "$1" >/dev/null 2>&1
}

download() {
  local url="$1"; local target="$2"
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

# --- Main ---
main() {
  mkdir -p "$INSTALL_DIR"

  TMPDIR="$(mktemp -d)"
  TMPFILE="$TMPDIR/nvim.tmp"
  ZSYNC_TMP="$TMPDIR/$ZSYNC_FILE"
  PART="$INSTALL_PATH.part"

  trap 'rm -rf "$TMPDIR"; secure_remove "$PART" "$TMPFILE" "$ZSYNC_TMP" "$PART.part" "$INSTALL_PATH.tmp.part" || true' EXIT

  if [ ! -f "$INSTALL_PATH" ]; then
    echo "Downloading $APPNAME for the first time..."
    download "$APPURL/$APPNAME" "$TMPFILE"
    install -m 0755 "$TMPFILE" "$INSTALL_PATH"
    if ! file "$INSTALL_PATH" | grep -qi 'executable'; then
      rm -f "$INSTALL_PATH"
      echo "Downloaded file doesn't look like an executable, aborting." >&2
      exit 1
    fi
    secure_remove "$TMPFILE"
    echo "Installed $INSTALL_PATH"
  else
    if detect_cmd zsync; then
      echo "Checking for updates using zsync..."
      download "$ZSYNC_URL" "$ZSYNC_TMP"

      # try zsync with referer and write to .part file
      if zsync -u "$ZSYNC_URL" -i "$INSTALL_PATH" "$ZSYNC_TMP" -o "$PART"; then
        install -m 0755 "$PART" "$INSTALL_PATH"
        if ! file "$INSTALL_PATH" | grep -qi 'executable'; then
          rm -f "$INSTALL_PATH"
          echo "Downloaded file doesn't look like an executable, aborting." >&2
          secure_remove "$PART" "$ZSYNC_TMP" "$TMPFILE"
          exit 1
        fi
        secure_remove "$PART" "$ZSYNC_TMP" "$TMPFILE"
        echo "Updated $INSTALL_PATH"
      else
        echo "zsync update failed, falling back to full download..."
        download "$APPURL/$APPNAME" "$PART"
        install -m 0755 "$PART" "$INSTALL_PATH"
        if ! file "$INSTALL_PATH" | grep -qi 'executable'; then
          rm -f "$INSTALL_PATH"
          echo "Downloaded file doesn't look like an executable, aborting." >&2
          secure_remove "$PART" "$ZSYNC_TMP" "$TMPFILE"
          exit 1
        fi
        secure_remove "$PART" "$ZSYNC_TMP" "$TMPFILE"
        echo "Updated $INSTALL_PATH (full download)"
      fi
    else
      echo "zsync not found, falling back to full download..."
      download "$APPURL/$APPNAME" "$TMPFILE"
      install -m 0755 "$TMPFILE" "$INSTALL_PATH"
      if ! file "$INSTALL_PATH" | grep -qi 'executable'; then
        rm -f "$INSTALL_PATH"
        echo "Downloaded file doesn't look like an executable, aborting." >&2
        secure_remove "$TMPFILE"
        exit 1
      fi
      secure_remove "$TMPFILE"
    fi
  fi

  echo "Neovim nightly update complete."
}

main
