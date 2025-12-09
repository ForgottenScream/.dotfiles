# This script will create the symbolic links between the dotfiles in this directory and the locations where they are meant to be in.

########
# nvim #
########
rm -rf "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim" "$XDG_CONFIG_HOME/nvim"

#######
# X11 #
#######
rm -rf "$XDG_CONFIG_HOME/X11"
rm -rf "$HOME/.xinitrc"
ln -s "$DOTFILES/X11/" "$XDG_CONFIG_HOME/X11"
ln -s "$DOTFILES/X11/.xinitrc" "$HOME/.xinitrc"

######
# i3 #
######
rm -rf "$XDG_CONFIG_HOME/i3"
ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME/i3"

########
# Bash #
########
rm -rf "$HOME/.bashrc"
ln -sf "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
rm -rf "$HOME/.bash_aliases"
ln -sf "$DOTFILES/bash/bash_aliases" "$HOME/.bash_aliases"
rm -rf "$HOME/.bash_paths"
ln -sf "$DOTFILES/bash/bash_paths" "$HOME/.bash_paths"
rm -rf "$HOME/.bash_functions"
ln -sf "$DOTFILES/.bash_functions" "$HOME/.bash_functions"
rm -rf "$HOME/.bash_prompt"
ln -sf "$DOTFILES/bash/.bash_prompt" "$HOME/.bash_prompt"
rm -rf "$HOME/.bash_profile"
ln -sf "$DOTFILES/bash/.bash_profile"
rm -rf "$HOME/.bash_dashboard"
ln -sf "$DOTFILES/bash/.bash_dashboard" "$HOME/.bash_dashboard"

#######
# ZSH #
#######
rm -rf "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/.path" "$HOME/.path"

########
# TMUX #
########
rm -rf "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux" "$XDG_CONFIG_HOME/tmux"

#########
# Picom #
#########
rm -rf "$XDG_CONFIG_HOME/picom"
ln -sf "$DOTFILES/picom" "$XDG_CONFIG_HOME/picom"

#########
# dunst #
#########
rm -rf "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst" "$XDG_CONFIG_HOME/dunst"

#########
# Fonts #
#########
rm -rf "$HOME/.local/share/fonts/"
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
