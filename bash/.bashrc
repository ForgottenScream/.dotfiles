# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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

# Add any other global settings or configurations here

# Autostart i3
if [ "$(tty)" = "/dev/tty1" ];
then
    exec startx &>/dev/null
fi

xrdb -merge ~/.Xresources
