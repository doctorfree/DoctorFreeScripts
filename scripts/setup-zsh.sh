#!/bin/bash

have_apt=$(type -p apt)
[ "${have_apt}" ] || {
  echo "Unsupported platform: apt not found"
  echo "This script requires Debian based OS with the apt package manager"
  exit 1
}

# Update and install zsh
sudo apt update
sudo apt install -y zsh fzf fonts-powerline

# Change default shell to zsh
chsh -s $(which zsh)

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Backup current .zshrc if it exists
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc$$
# Update .zshrc
cat <<EOL >> ~/.zshrc

# Set the theme
ZSH_THEME="agnoster"

# Add plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z colored-man-pages fzf)

# Set FZF_BASE directory
export FZF_BASE=/usr/share/fzf

# Source Oh My Zsh
source \$ZSH/oh-my-zsh.sh
EOL

# Source the .zshrc file
source ~/.zshrc

echo "Zsh and Oh-My-Zsh have been installed and configured! Please restart your terminal."
