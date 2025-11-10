#!/usr/bin/env zsh
source "$HOME/.config/zsh/aliases"

export VISUAL=nvim
export EDITOR=nvim

setopt AUTO_PARAM_SLASH
unsetopt CASE_GLOB

autoload -Uz compinit; compinit

#Autocomplete hidden files
_comp_options+=(globdots)
source ~/.dotfiles/zsh/external/completion.zsh

fpath=($ZDOTDIR/external $fpath)

if [ $(command -v "fzf") ]; then
#    source /usr/share/fzf/completion.zsh
#    source /usr/share/fzf/key-bindings.zsh
fi

# Auto start i3
if [ "$(tty)" = "/dev/tty1" ];
then
    pgrep i3 || exec startx &>/dev/null "$XDG_CONFIG_HOME/X11/.xinitrc"
fi

# Auto start tmux
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]]; then
	tmux attach-session -t default 2>/dev/null || tmux new-session -s default
fi

[ -f "/home/n/.ghcup/env" ] && . "/home/n/.ghcup/env" # ghcup-env

#export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
#export PATH=$JAVA_HOME/bin:$PATH

xrdb -merge ~/.dotfiles/X11/.Xresources

###################################################################
#Needs to be sourced last so everything else needs to be above ^^^#
###################################################################
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
