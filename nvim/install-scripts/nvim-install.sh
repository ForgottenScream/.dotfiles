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
  local url="$1"
  local target="$2"
  if detect_cmd curl; then
    curl -L -o "$target" "$url"
  elif detect_cmd wget; then
    wget -O "$target" "$url"
  else
    echo "Error: Neither curl nor wget found." >&2
    exit 1
  fi
}

# --- Main ---
main() {
  mkdir -p "$INSTALL_DIR"

  if [ ! -f "$INSTALL_PATH" ]; then
    echo "Downloading $APPNAME for the first time..."
    download "$APPURL/$APPNAME" "$INSTALL_PATH"
    chmod u+x "$INSTALL_PATH"
    echo "Installed $INSTALL_PATH"
  else
    if detect_cmd zsync; then
      echo "Checking for updates using zsync..."
      download "$ZSYNC_URL" "$ZSYNC_FILE"
      if zsync -i "$INSTALL_PATH" "$ZSYNC_FILE" -o "$INSTALL_PATH.tmp"; then
        mv "$INSTALL_PATH.tmp" "$INSTALL_PATH"
        chmod u+x "$INSTALL_PATH"
        echo "Updated $INSTALL_PATH"
      else
        echo "zsync update failed, falling back to full download..."
        download "$APPURL/$APPNAME" "$INSTALL_PATH.tmp"
        mv "$INSTALL_PATH.tmp" "$INSTALL_PATH"
        chmod u+x "$INSTALL_PATH"
      fi
      rm -f "$ZSYNC_FILE"
    else
      echo "zsync not found, falling back to full download..."
      download "$APPURL/$APPNAME" "$INSTALL_PATH.tmp"
      mv "$INSTALL_PATH.tmp" "$INSTALL_PATH"
      chmod u+x "$INSTALL_PATH"
    fi
  fi

  echo "Neovim nightly update complete."
}

main
