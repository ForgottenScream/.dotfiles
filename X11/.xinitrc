udiskie &
xrdb -merge ~/.config/X11/.Xresources

setxkbmap -layout gb,gb -variant colemak, -option grp:alt_shift_toggle'

xcape -e 'Shift_L=Escape'&
 
##############################
# Needs to be at end of file #
##############################
exec i3
