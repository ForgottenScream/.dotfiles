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
link "$DOTFILES/.gitconfig" "$HOME/.gitconfig"

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
link "$DOTFILES/zsh/.path" "$HOME/.path"

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
mkdir -p "$HOME/.config/newsboat"
link "$DOTFILES/newsboat/urls" "$HOME/.config/newsboat/urls"
link "$DOTFILES/newsboat/config" "$HOME/.config/newsboat/config"

#######
# w3m #
#######
mkdir -p "$HOME/.w3m"
link "$DOTFILES/w3m/config" "$HOME/.w3m/config"
link "$DOTFILES/w3m/keymap" "$HOME/.w3m/keymap"
link "$DOTFILES/w3m/menu" "$HOME/.w3m/menu"
link "$DOTFILES/w3m/bookmark.html" "$HOME/.w3m/bookmark.html"

###########
# Latexmk #
###########
link "$DOTFILES/latex/.latexmkrc" "$HOME/.latexmkrc"

echo "Setting up Neovim plugins..."

if command -v nvim >/dev/null 2>&1; then
  bash "$DOTFILES/nvim/install-scripts/lsp-install.sh"
  bash "$DOTFILES/nvim/install-scripts/plugins-install.sh"
else
  echo "Neovim not installed. Skipping nvim setup."
fi

echo "Dotfiles installation complete."
