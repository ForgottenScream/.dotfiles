#!/usr/bin/env zsh
# ~/.config/zsh/.zshrc

# --- Shell Options ---
setopt AUTO_PARAM_SLASH
unsetopt CASE_GLOB
unset HISTFILE
HISTSIZE=0
SAVEHIST=0
setopt NO_HIST_BEEP
setopt NO_HIST_VERIFY

# --- Completion ---
autoload -Uz compinit; compinit
_comp_options+=(globdots)

# --- Prompt ---
fpath=("$ZDOTDIR/external" $fpath)
autoload -Uz promptinit; promptinit
autoload -Uz prompt_purification_setup && prompt_purification_setup

# --- Aliases ---
source "$ZDOTDIR/aliases"

# --- Fzf ---
if command -v fzf &>/dev/null; then
    source /usr/share/fzf/key-bindings.zsh
fi

# --- X Resources ---
xrdb -merge "$DOTFILES/X11/.Xresources" &>/dev/null

# --- Auto-start i3 (on tty1) ---
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep i3 || exec startx "$XDG_CONFIG_HOME/X11/.xinitrc" &>/dev/null
fi

# --- Auto-start tmux ---
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]]; then
    tmux attach-session -t default 2>/dev/null || tmux new-session -s default
fi

# --- Plugins (must be last) ---
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
