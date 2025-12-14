# .bash_profile

xrdb -merge ~/.dotfiles/X11/.Xresources

# Autostart i3
if [ "$(tty)" = "/dev/tty1" ];
then
    exec startx &>/dev/null
fi

# Get everything from .bashrc
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
