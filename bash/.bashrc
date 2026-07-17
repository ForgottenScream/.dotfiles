# ~/.bashrc

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

######################################
# Environment
export EDITOR='vim'
export GREP_COLORS='m=1;36'
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

######################################
# XDG Base Directories + PATH
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

case ":$PATH:" in
  *:"$HOME/.local/bin":*) ;;
  *) PATH="$HOME/.local/bin:$PATH" ;;
esac

case ":$PATH:" in
  *:"$HOME/bin":*) ;;
  *) PATH="$HOME/bin:$PATH" ;;
esac

export PATH


xrdb -merge ~/.Xresources

######################################
# Prompt
CYAN="\[\e[36m\]"
RESET="\[\e[0m\]"

PROMPT_COMMAND='[ -n "$PS1" ] && printf "\n"'
PS1='\w '"$CYAN"'> '"$RESET"

######################################
# Aliases
alias l='ls -1t --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias shred='shred -vfzu'

alias aliases='vim ~/.bashrc'

alias tool='
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL https://christitus.com/linux | sh
  else
    echo "Error: curl not found."
    return 1
  fi
'

# i3 based aliases
alias i3config='nvim "${DOTFILES:-$HOME/.dotfiles}/i3/config"'
alias i3status='nvim "${DOTFILES:-$HOME/.dotfiles}/i3/i3status.conf"'

# Music File Manipulation Aliases
alias removepicflac='metaflac --remove --block-type=PICTURE,PADDING --dont-use-padding'
alias removepicmp3='eyeD3 --remove-all-images'

# Keyboard Aliases
alias cm='setxkbmap gb -variant colemak'
alias pt='setxkbmap pt'

######################################
# Functions

copytodom0() {
  local src_vm="$1"
  local src_path="$2"
  local dest_path="$3"

  if [[ -z "$src_vm" || -z "$src_path" || -z "$dest_path" ]]; then
    echo "Usage: copytodom0 <src-vm> <path/in/src-vm> <dest/path/in/dom0>"
    return 1
  fi

  if ! command -v qvm-run >/dev/null 2>&1; then
    echo "Error: qvm-run not found."
    return 1
  fi

  qvm-run --pass-io "$src_vm" "cat $(printf '%q' "$src_path")" > "$dest_path"
}

rootTerminal() {
  local vm="$1"

  if [[ -z "$vm" ]]; then
    echo "Usage: rootTerminal <vm>"
    return 1
  fi

  if ! command -v qvm-run >/dev/null 2>&1 || ! command -v qubes-run-terminal >/dev/null 2>&1; then
    echo "Error: Qubes tools not found."
    return 1
  fi

  qvm-run -u root "$vm" qubes-run-terminal
}

######################################
# Dashboard
echo

# Run calendar first
cal

system_summary() {
  echo "--------------------------------"
  if command -v uptime >/dev/null 2>&1; then
    echo " Uptime:  $(uptime -p)"
  fi

  if command -v df >/dev/null 2>&1 && command -v awk >/dev/null 2>&1; then
    df -h / | awk 'NR==2 {print " Root FS: " $3 "/" $2 " used (" $5 ")"}'
  fi

  if command -v free >/dev/null 2>&1 && command -v awk >/dev/null 2>&1; then
    free -h | awk '/Mem:/ {print " RAM:     " $3 " / " $2}'
  fi

  echo "--------------------------------"
}

system_summary

echo

if command -v qvm-ls >/dev/null 2>&1; then
  running_vms=$(qvm-ls --running --raw-list 2>/dev/null)
  if [[ -n "$running_vms" ]]; then
    echo "Running Qubes VMs:"
    printf '%s\n' "$running_vms" | sed 's/^/  - /'
    echo
  fi
fi

######################################
# Completions
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

######################################
# Bash options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob

# bash version >= 4
shopt -s autocd 2>/dev/null || true
shopt -s dirspell 2>/dev/null || true

######################################
# History
HISTCONTROL=ignoreboth
export HISTSIZE=20
export HISTFILESIZE=0
export HISTFILE=/dev/null
