#!/usr/bin/env bash
set -euo pipefail

INSTALL="$HOME/.local/bin/nvim"
URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage"

mkdir -p "$(dirname "$INSTALL")"
download() { curl -L -f -o "$2" "$1" || exit 1; }

TMPDIR="$(mktemp -d)"
trap 'rm -rf $TMPDIR' EXIT
cd "$TMPDIR"

# First install
if [[ ! -f $INSTALL ]]; then
  echo "Installing Neovim..."
  download "$URL" nvim
  chmod +x nvim
  mv nvim "$INSTALL"
  echo "Done: $INSTALL"
  exit
fi

# Update via zsync
echo "Updating Neovim..."
if command -v zsync >/dev/null; then
  download "${URL}.zsync" nvim.zsync
  zsync -i "$INSTALL" nvim.zsync
  mv nvim-linux-x86_64.appimage "$INSTALL"
  chmod +x "$INSTALL"
  echo "Done: $INSTALL (zsync)"
  exit
fi

# Fallback to full download
echo "zsync not found, full download..."
download "$URL" nvim
chmod +x nvim
mv nvim "$INSTALL"
echo "Done: $INSTALL"
