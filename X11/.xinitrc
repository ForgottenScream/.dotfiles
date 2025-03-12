urxvtd -o -q -f
udiskie &
xrdb -merge ~/.config/X11/.Xresources

setxkbmap gb -variant colemak

xcape -e 'Shift_L=Escape'&
 
##############################
# Needs to be at end of file #
##############################
exec i3
