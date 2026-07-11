#!/usr/bin/env bash
#
# .bashrc

# Load /etc/bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Only run in interactive shells
[[ -n $PS1 ]] || return
case $- in
    *i*) ;;
    *) return ;;
esac

# Environment
export EDITOR='vim'
export GREP_COLOR='1;36'
export PAGER='less'
export VISUAL='vim'
export LSCOLORS='ExGxbEaECxxEhEhBaDaCaD'

# Support colors in less
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# Load custom aliases
if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

# Load custom paths
if [ -f "$HOME/.bash_paths" ]; then
    source "$HOME/.bash_paths"
fi

# Load custom functions
if [ -f "$HOME/.bash_functions" ]; then
    source "$HOME/.bash_functions"
fi

# Load custom prompt settings
if [ -f "$HOME/.bash_prompt" ]; then
    source "$HOME/.bash_prompt"
fi

# Load custom dashbord
if [ -f "$HOME/.bash_dashboard" ]; then
    source "$HOME/.bash_dashboard"
fi

# Completions
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob

# bash version >= 4
shopt -s autocd 2>/dev/null || true
shopt -s dirspell 2>/dev/null || true

# History
HISTCONTROL=ignoreboth
export HISTSIZE=20
export HISTFILESIZE=0
export HISTFILE=/dev/null
