#!/usr/bin/env zsh
# ~/.zshenv

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export DOTFILES="$XDG_CONFIG_HOME/dotfiles"

# Editors
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Paths
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="$HOME/Grayjay:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
