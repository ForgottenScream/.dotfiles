# This script will create the symbolic links between the dotfiles in this directory and the locations where they are meant to be in.
#######
# X11 #
#######
rm -rf "$HOME/.config/X11"
ln -s "$HOME/.dotfiles/X11" "$HOME/.config"
#ln -s "$HOME/.dotfiles/X11/.xinitrc" "$HOME"
#ln -s "$HOME/.dotfiles/X11/.Xresources" "$HOME"

######
# i3 #
######
rm -rf "$HOME/.config/i3"
ln -s "$HOME/.dotfiles/i3" "$HOME/.config"

#######
# ZSH #
#######
mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/.dotfiles/zsh/aliases" "$HOME/.config/zsh/aliases"
rm -rf "$HOME/.config/zsh/external"
ln -sf "$HOME/.dotfiles/zsh/external" "$HOME/.config/zsh"

########
# TMUX #
########
#mkdir -p "$HOME/.config/tmux"
#ln -sf "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

#########
# dunst #
#########
mkdir -p "$HOME/.config/dunst"
ln -sf "$HOME/.dotfiles/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"

#########
# Fonts #
#########
# mkdir -p "$XDG_DATA_HOME"
# cp -rf "$HOME/.dotfiles/fonts" "$XDG_DATA_HOME"
