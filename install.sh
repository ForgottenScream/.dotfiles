# This script will create the symbolic links between the dotfiles in this directory and the locations where they are meant to be in.

######
# i3 #
######
rm -rf "$HOME/.config/i3"
ln -s "$HOME/.dotfiles/i3" "$HOME/.config"
