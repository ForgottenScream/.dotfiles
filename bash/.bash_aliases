#!/usr/bin/env bash
#
# .bash_aliases

# General Terminal Aliases
alias l='ls -1t --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# shred (external tool)
alias shred='shred -vfzu'

# Open/edit your bash aliases file
alias aliases='vim ~/.bash_aliases'

# Distro bootstrap one-liner (still external; guarded)
alias tool='
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL https://christitus.com/linux | sh
  else
    echo "Error: curl not found."
    return 1
  fi
'

# i3 based aliases (guard DOTFILES usage at runtime)
alias i3config='nvim "${DOTFILES:-$HOME/.dotfiles}/i3/config"'
alias i3status='nvim "${DOTFILES:-$HOME/.dotfiles}/i3/i3status.conf"'

# Music File Manipulation Aliases (external tools)
alias removepicflac='metaflac --remove --block-type=PICTURE,PADDING --dont-use-padding'
alias removepicmp3='eyeD3 --remove-all-images'

# Keyboard Aliases
alias cm='setxkbmap gb -variant colemak'
alias pt='setxkbmap pt'
