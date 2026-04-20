#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/.dotfiles"

link() {
  local source="$1"
  local target="$2"

  echo "Linking $target → $source"

  if [ -e "$target" ] || [ -L "$target" ]; then
    rm -rf "$target"
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"
}

echo "Starting dotfiles installation..."

#######
# git #
#######
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

########
# nvim #
########
link "$DOTFILES/nvim" "$HOME/.config/nvim"

#######
# X11 #
#######
link "$DOTFILES/X11" "$HOME/.config/X11"
link "$DOTFILES/X11/.xinitrc" "$HOME/.xinitrc"
link "$DOTFILES/X11/.Xresources" "$HOME/.Xresources"

######
# i3 #
######
link "$DOTFILES/i3" "$HOME/.config/i3"

########
# Bash #
########
link "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
link "$DOTFILES/bash/.bash_aliases" "$HOME/.bash_aliases"
link "$DOTFILES/bash/.bash_paths" "$HOME/.bash_paths"
link "$DOTFILES/bash/.bash_functions" "$HOME/.bash_functions"
link "$DOTFILES/bash/.bash_prompt" "$HOME/.bash_prompt"
link "$DOTFILES/bash/.bash_profile" "$HOME/.bash_profile"
link "$DOTFILES/bash/.bash_dashboard" "$HOME/.bash_dashboard"

#######
# ZSH #
#######
link "$DOTFILES/zsh" "$HOME/.config/zsh"
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"

########
# TMUX #
########
link "$DOTFILES/tmux" "$HOME/.config/tmux"

#########
# Picom #
#########
link "$DOTFILES/picom" "$HOME/.config/picom"

#########
# dunst #
#########
link "$DOTFILES/dunst" "$HOME/.config/dunst"

############
# Newsboat #
############
link "$DOTFILES/newsboat" "$HOME/.config/newsboat"

#######
# w3m #
#######
link "$DOTFILES/w3m" "$HOME/.w3m"

###########
# Latexmk #
###########
link "$DOTFILES/latex/.latexmkrc" "$HOME/.latexmkrc"

echo "Setting up Neovim"

if [ -x "$HOME/.local/bin/nvim" ]; then
  echo "Running Neovim install scripts..."
  bash "$DOTFILES/nvim/install-scripts/lsp-install.sh"
  bash "$DOTFILES/nvim/install-scripts/plugins-install.sh"
else
  bash "$DOTFILES/nvim/install-scripts/nvim-install.sh"
  bash "$DOTFILES/nvim/install-scripts/lsp-install.sh"
  bash "$DOTFILES/nvim/install-scripts/plugins-install.sh"
  exit 1
fi

echo "Dotfiles installation complete."
