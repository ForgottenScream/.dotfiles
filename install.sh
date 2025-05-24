# This script will create the symbolic links between the dotfiles in this directory and the locations where they are meant to be in.

########
# nvim #
########
rm -rf "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim" "$HOME/.config"

#######
# X11 #
#######
rm -rf "$HOME/.config/X11"
rm -rf "$HOME/.xinitrc"
ln -s "$HOME/.dotfiles/X11/" "$HOME/.config/X11"
ln -s "$HOME/.dotfiles/X11/.xinitrc" "$HOME"

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
mkdir -p "$HOME/.config/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

#########
# Picom #
#########
mkdir -p "$HOME/.config/picom"
ln -sf "$DOTFILES/picom/picom.conf" "$HOME/.config/picom/picom.conf"
#########
# dunst #
#########
mkdir -p "$HOME/.config/dunst"
ln -sf "$HOME/.dotfiles/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"

#########
# Fonts #
#########
 mkdir -p "$HOME/.config/local/share"
 cp -rf "$HOME/.dotfiles/fonts" "$HOME/.config/local/share"

############
# Newsboat #
############
rm -rf "$HOME/.newsboat"
mkdir -p "$HOME/.newsboat"
ln -sf "$DOTFILES/newsboat/urls" "$HOME/.newsboat/urls"

################
# Task Warrior #
################
mkdir -p "$HOME/.config/task"
ln -sf "$HOME/.dotfiles/task/.taskrc" "$HOME/.config/task/taskrc"
