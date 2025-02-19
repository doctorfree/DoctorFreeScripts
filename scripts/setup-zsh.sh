#!/bin/bash

have_apt=$(type -p apt)
[ "${have_apt}" ] || {
  echo "Unsupported platform: apt not found"
  echo "This script requires Debian based OS with the apt package manager"
  exit 1
}

# Update and install zsh
sudo apt update
sudo apt install -y zsh fonts-powerline

# Install fzf fuzzy finder
[ -f ${HOME}/.local/bin/fzf ] && {
  mv ${HOME}/.local/bin/fzf ${HOME}/.local/bin/fzf-bak$$
}
printf "\nInstalling fzf fuzzy finder\n"
[ -d ${HOME}/.fzf ] && mv ${HOME}/.fzf ${HOME}/.fzf$$
git clone --depth 1 https://github.com/junegunn/fzf.git \
    ${HOME}/.fzf >/dev/null 2>&1
[ -f ${HOME}/.fzf/install ] && chmod 755 ${HOME}/.fzf/install
[ -x ${HOME}/.fzf/install ] && ${HOME}/.fzf/install --all >/dev/null 2>&1
if [ -f ${HOME}/.fzf/bin/fzf ]; then
  ln -s ${HOME}/.fzf/bin/fzf ${HOME}/.local/bin/fzf
  rm -f ${HOME}/.local/bin/fzf-bak$$
else
  [ -f ${HOME}/.local/bin/fzf-bak$$ ] && {
    mv ${HOME}/.local/bin/fzf-bak$$ ${HOME}/.local/bin/fzf
  }
fi
if [ -d ${HOME}/.fzf ]; then
  rm -rf ${HOME}/.fzf$$
else
  [ -d ${HOME}/.fzf$$ ] && mv ${HOME}/.fzf$$ ${HOME}/.fzf
fi

# Change default shell to zsh
chsh -s $(which zsh)

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# Forgit interactive git with fzf. See https://github.com/wfxr/forgit
git clone https://github.com/wfxr/forgit.git $ZSH_CUSTOM/plugins/forgit

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

echo "Zsh, fzf, and Oh-My-Zsh have been installed and configured! Please restart your terminal."
