#!/bin/bash
#
# setup-pyenv - setup a pyenv Python virtual environment on macOS using Homebrew

have_brew=$(type -p brew)
[ "${have_brew}" ] || {
  echo "Homebrew required. Exiting."
  exit 1
}

[ -f ~/.zshrc ] || {
  echo "Zsh initialization file $HOME/.zshrc required. Exiting."
  exit 1
}

brew install pyenv

grep PYENV_ROOT ~/.zshrc > /dev/null || {
  echo '[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo '[ -d $HOME/.pyenv/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo -e 'if command -v pyenv > /dev/null; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.zshrc
}

echo "Python virtual environment setup in $HOME/.pyenv"
echo "Logout and login or run 'source $HOME/.zshrc'"
echo "Run 'pyenv install --list' to list available Python versions"
