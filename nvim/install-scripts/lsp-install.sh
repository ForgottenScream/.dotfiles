#!/usr/bin/env bash

set -euo pipefail

echo "Installing Neovim LSP plugins..."

DATA_DIR="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qa)"
PLUGIN_DIR="$DATA_DIR/site/pack/manual/start"

mkdir -p "$PLUGIN_DIR"

install_plugin () {
  local repo="$1"
  local name
  name="$(basename "$repo" .git)"
  local target="$PLUGIN_DIR/$name"

  if [ ! -d "$target" ]; then
    echo "Cloning $name..."
    git clone "$repo" "$target"
  else
    echo "$name already installed."
  fi
}

# Minimal required plugins
install_plugin https://github.com/neovim/nvim-lspconfig.git

echo "Neovim LSP setup complete."
