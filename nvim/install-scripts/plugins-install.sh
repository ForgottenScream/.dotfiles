#!/usr/bin/env bash

set -euo pipefail

echo "Installing Neovim plugins..."

# Ask Neovim where its data directory is (respects XDG)
DATA_DIR="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qa 2>/dev/null)"
PLUGIN_DIR="${DATA_DIR}/site/pack/manual/start"

mkdir -p "$PLUGIN_DIR"

install_plugin() {
  local repo="$1"
  local name
  name="$(basename "$repo" .git)"
  local target="${PLUGIN_DIR}/${name}"

  if [[ -d "$target" ]]; then
    echo "${name} already installed."
  else
    echo "Cloning ${name}..."
    git clone --depth 1 "$repo" "$target"
  fi
}

# ======================
# Core Utilities
# ======================

install_plugin https://github.com/nvim-treesitter/nvim-treesitter.git
install_plugin https://github.com/windwp/nvim-autopairs.git
install_plugin https://github.com/kylechui/nvim-surround.git
install_plugin https://github.com/lewis6991/gitsigns.nvim.git

# ======================
# Completion
# ======================

install_plugin https://github.com/hrsh7th/nvim-cmp.git
install_plugin https://github.com/hrsh7th/cmp-nvim-lsp.git
install_plugin https://github.com/hrsh7th/cmp-buffer.git
install_plugin https://github.com/hrsh7th/cmp-path.git

echo "Neovim plugins setup complete."
