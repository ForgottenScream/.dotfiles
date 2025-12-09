# .bashrc

# Load custom aliases
if [ -f "$DOTFILES/bash/.bash_aliases" ]; then
    source "$DOTFILES/bash/.bash_aliases"
fi

# Load custom paths
if [ -f "$DOTFILES/bash/.bash_paths" ]; then
    source "$DOTFILES/bash/.bash_paths"
fi

# Load custom functions
if [ -f "$DOTFILES/bash/.bash_functions" ]; then
    source "$DOTFILES/bash/.bash_functions"
fi

# Load custom prompt settings
if [ -f "$DOTFILES/bash/.bash_prompt" ]; then
    source "$DOTFILES/bash/.bash_prompt"
fi

# Add any other global settings or configurations here
