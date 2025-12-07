# This script will create the symbolic links between the dotfiles in this directory and the locations where they are meant to be in.

########
# nvim #
########
rm -rf "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim" "$XDG_CONFIG_HOME"

#######
# X11 #
#######
rm -rf "$XDG_CONFIG_HOME/X11"
rm -rf "$HOME/.xinitrc"
ln -s "$DOTFILES/X11/" "$XDG_CONFIG_HOME/X11"
ln -s "$DOTFILES/X11/.xinitrc" "$HOME"

######
# i3 #
######
rm -rf "$XDG_CONFIG_HOME/i3"
ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME"

#######
# ZSH #
#######
rm -rf "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh" "$XDG_CONFIG_HOME"
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/.path" "$HOME"

########
# TMUX #
########
rm -rf "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux" "$XDG_CONFIG_HOME/"

#########
# Picom #
#########
rm -rf "$XDG_CONFIG_HOME/picom"
ln -sf "$DOTFILES/picom" "$XDG_CONFIG_HOME"

#########
# dunst #
#########
rm -rf "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst" "$XDG_CONFIG_HOME"

#########
# Fonts #
#########
mkdir -p "$HOME/.local/share/fonts"
cp -rf "$DOTFILES/fonts" "$HOME/.local/share"
fc-cache -f "$HOME/.local/share/fonts"

############
# Newsboat #
############
rm -rf "$HOME/.newsboat"
mkdir -p "$HOME/.newsboat"
ln -sf "$DOTFILES/newsboat/urls" "$HOME/.newsboat/urls"
ln -sf "$DOTFILES/newsboat/config" "$HOME/.newsboat/config"

###########
# Latexmk #
###########
ln -sf "$DOTFILES/latex/.latexmkrc" "$HOME/.latexmkrc"
