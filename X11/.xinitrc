[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

udiskie &

 
##############################
# Needs to be at end of file #
##############################
exec i3
