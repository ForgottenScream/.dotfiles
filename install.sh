# This script will create the symbolic links between the dotfiles in this directory and the locations where they are meant to be in.

########
# nvim #
########
rm -rf "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"

#######
# X11 #
#######
rm -rf "$HOME/.config/X11"
rm -rf "$HOME/.xinitrc"
ln -s "$HOME/.dotfiles/X11/" "$HOME/.config/X11"
ln -s "$HOME/.dotfiles/X11/.xinitrc" "$HOME/.xinitrc"
rm -rf "$HOME/.Xresources"
ln -s "$HOME/.dotfiles/X11/.Xresources" "$HOME/.Xresources"

######
# i3 #
######
rm -rf "$HOME/.config/i3"
ln -s "$HOME/.dotfiles/i3" "$HOME/.config/i3"

########
# Bash #
########
rm -rf "$HOME/.bashrc"
ln -sf "$HOME/.dotfiles/bash/.bashrc" "$HOME/.bashrc"
rm -rf "$HOME/.bash_aliases"
ln -sf "$HOME/.dotfiles/bash/.bash_aliases" "$HOME/.bash_aliases"
rm -rf "$HOME/.bash_paths"
ln -sf "$HOME/.dotfiles/bash/.bash_paths" "$HOME/.bash_paths"
rm -rf "$HOME/.bash_functions"
ln -sf "$HOME/.dotfiles/bash/.bash_functions" "$HOME/.bash_functions"
rm -rf "$HOME/.bash_prompt"
ln -sf "$HOME/.dotfiles/bash/.bash_prompt" "$HOME/.bash_prompt"
rm -rf "$HOME/.bash_profile"
ln -sf "$HOME/.dotfiles/bash/.bash_profile" "$HOME/.bash_profile"
rm -rf "$HOME/.bash_dashboard"
ln -sf "$HOME/.dotfiles/bash/.bash_dashboard" "$HOME/.bash_dashboard"

#######
# ZSH #
#######
rm -rf "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh" "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$HOME/.dotfiles/zsh/.path" "$HOME/.path"

########
# TMUX #
########
rm -rf "$HOME/.config/tmux"
ln -sf "$HOME/.dotfiles/tmux" "$HOME/.config/tmux"

#########
# Picom #
#########
rm -rf "$HOME/.config/picom"
ln -sf "$HOME/.dotfiles/picom" "$HOME/.config/picom"

#########
# dunst #
#########
rm -rf "$HOME/.config/dunst"
ln -sf "$HOME/.dotfiles/dunst" "$HOME/.config/dunst"

############
# Newsboat #
############
rm -rf "$HOME/.newsboat"
mkdir -p "$HOME/.newsboat"
ln -sf "$HOME/.dotfiles/newsboat/urls" "$HOME/.newsboat/urls"
ln -sf "$HOME/.dotfiles/newsboat/config" "$HOME/.newsboat/config"

###########
# Latexmk #
###########
ln -sf "$HOME/.dotfiles/latex/.latexmkrc" "$HOME/.latexmkrc"
