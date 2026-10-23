#!/usr/bin/env bash
set -euo pipefail

INSTALL="${HOME}/.local/bin/nvim"
URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage"
ZSYNC_URL="${URL}.zsync"

mkdir -p "$(dirname "$INSTALL")"

TMP="$(mktemp "${INSTALL}.tmp.XXXXXX")"
ZSYNC_TMP="$(mktemp "${INSTALL}.zsync.XXXXXX")"
trap 'rm -f "$TMP" "$ZSYNC_TMP"' EXIT

download() {
    curl --fail --location --silent --show-error --output "$2" "$1"
}

updated_with_zsync=false

if [[ -x "$INSTALL" ]] && command -v zsync >/dev/null 2>&1; then
    if download "$ZSYNC_URL" "$ZSYNC_TMP" &&
       zsync -i "$INSTALL" -o "$TMP" "$ZSYNC_TMP"; then
        updated_with_zsync=true
    else
        echo "zsync update failed; downloading the full AppImage." >&2
    fi
fi

if [[ "$updated_with_zsync" != true ]]; then
    download "$URL" "$TMP"
fi

chmod 755 "$TMP"
mv -f -- "$TMP" "$INSTALL"

if [[ "$updated_with_zsync" == true ]]; then
    echo "Updated: $INSTALL (zsync)"
else
    echo "Installed or updated: $INSTALL (full download)"
fi
