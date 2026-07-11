# ~/.bash_profile
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


if [ "$(tty)" = "/dev/tty1" ]; then
  exec startx &>/dev/null
fi
