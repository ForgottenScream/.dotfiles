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
rm -rf "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh" "$HOME/.config"
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME"

########
# TMUX #
########
rm -rf "$HOME/.config/tmux"
ln -sf "$HOME/.dotfiles/tmux" "$HOME/.config/"

#########
# Picom #
#########
rm -rf "$HOME/.config/picom"
ln -sf "$HOME/.dotfiles/picom" "$HOME/.config"

#########
# dunst #
#########
rm -rf "$HOME/.config/dunst"
ln -sf "$HOME/.dotfiles/dunst" "$HOME/.config"

#########
# Fonts #
#########
mkdir -p "$HOME/.local/share/fonts"
cp -rf "$HOME/.dotfiles/fonts" "$HOME/.local/share"
fc-cache -f "$HOME/.local/share/fonts"

############
# Newsboat #
############
rm -rf "$HOME/.newsboat"
mkdir -p "$HOME/.newsboat"
ln -sf "$HOME/.dotfiles/newsboat/urls" "$HOME/.newsboat/urls"

###########
# Latexmk #
###########
ln -sf "$HOME/.dotfiles/latex/.latexmkrc" "$HOME/.latexmkrc"
