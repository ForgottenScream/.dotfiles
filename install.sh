# This script will create the symbolic links between the dotfiles in this directory and the locations where they are meant to be in.
#######
# X11 #
#######
rm -rf "$HOME/.config/X11"
ln -s "$DOTFILES/X11" "$HOME/.config"
#ln -s "$DOTFILES/X11/.xinitrc" "$HOME"
#ln -s "$DOTFILES/X11/.Xresources" "$HOME"

######
# i3 #
######
rm -rf "$HOME/.config/i3"
ln -s "$DOTFILES/i3" "$HOME/.config"

#######
# ZSH #
#######
mkdir -p "$HOME/.config/zsh"
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.config/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/aliases" "$HOME/.config/zsh/aliases"
rm -rf "$HOME/.config/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$HOME/.config/zsh"

########
# TMUX #
########
#mkdir -p "$HOME/.config/tmux"
#ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

#########
# dunst #
#########
mkdir -p "$HOME/.config/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"

#########
# Fonts #
#########
# mkdir -p "$XDG_DATA_HOME"
# cp -rf "$DOTFILES/fonts" "$XDG_DATA_HOME"
