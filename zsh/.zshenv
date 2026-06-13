#!/usr/bin/env zsh
# ~/.zshenv

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export DOTFILES="$HOME/.dotfiles"

# Editors
export EDITOR="nvim"
export VISUAL="$EDITOR"
bindkey -v
export KEYTIMEOUT=1

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export VI_MODE_SET_CURSOR=true

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]]; then
        echo -ne '\e[2 q'
    else
        echo -ne '\e[6 q'
    fi
}
zle -N zle-keymap-select

function zle-line-init() {
    zle -K viins
    echo -ne '\e[6 q'
}
zle -N zle-line-init

function vi-yank-clipboard {
    zle vi-yank
    eecho "$CUTBUFFER" | xsel -ib
}
zle -N vi-yank-clipboard
bindkey -M vicmd 'y' vi-yank-clipboard

# Paths
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
