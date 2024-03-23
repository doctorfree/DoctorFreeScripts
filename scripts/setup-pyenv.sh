#!/bin/bash
#
# setup-pyenv - setup a pyenv Python virtual environment on macOS using Homebrew

have_brew=$(type -p brew)
have_apt=$(type -p apt)
have_dnf=$(type -p dnf)
# Set the Python executable name
PYTHON=
have_python3=$(type -p python3)
if [ "${have_python3}" ]; then
  PYTHON=python3
else
  have_python=$(type -p python)
  [ "${have_python}" ] && PYTHON=python
fi

mod_install() {
  ${PYTHON} -m pip install --user $1
}

plat_install() {
  if [ "${have_brew}" ]; then
    brew install $1
  else
    if [ "${have_apt}" ]; then
      sudo apt install $1 -q -y
    else
      [ "${have_dnf}" ] && sudo dnf install $1 -y
    fi
  fi
}

[ -f ~/.zshrc ] || {
  echo "Zsh initialization file $HOME/.zshrc required. Exiting."
  exit 1
}

[ -d ${HOME}/.pyenv ] && {
  echo "Moving existing $HOME/.pyenv to $HOME/.pyenv$$"
  mv ${HOME}/.pyenv ${HOME}/.pyenv$$
  echo "Remove $HOME/.pyenv$$ after setup completes"
  echo "Press <Enter> to continue"
  read -r yn
}

if [ "${have_brew}" ]; then
  brew install pyenv
else
  have_curl=$(type -p curl)
  [ "${have_curl}" ] || sudo apt install curl -q -y
  curl --silent https://pyenv.run | bash
fi

grep PYENV_ROOT ~/.zshrc > /dev/null || {
  echo '[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo '[ -d $HOME/.pyenv/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo -e 'if command -v pyenv > /dev/null; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.zshrc
}
[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv"
[ -d $HOME/.pyenv/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv > /dev/null; then
  eval "$(pyenv init --path)"
fi

[ "${have_brew}" ] || {
  sudo apt install build-essential libssl-dev zlib1g-dev \
                   libbz2-dev libreadline-dev libsqlite3-dev \
                   libncursesw5-dev xz-utils tk-dev libxml2-dev \
                   libxmlsec1-dev libffi-dev liblzma-dev -q -y
}

have_pyenv=$(type -p pyenv)
if [ "${have_pyenv}" ]; then
  pyenv install 3.12.2
  pyenv global 3.12.2
else
  echo "WARNING: pyenv not found. Check the pyenv installation and ~/.zshrc"
fi

[ "${have_brew}" ] && brew install pyenv-virtualenv
plat_install pipx
have_pipx=$(type -p pipx)
[ "${have_pipx}" ] || {
  mod_install pipx
}

have_pipx=$(type -p pipx)
if [ "${have_pipx}" ]; then
  pipx ensurepath
else
  echo "WARNING: pipx not found. Check the pipx installation and PATH"
fi

echo "Python virtual environment setup in $HOME/.pyenv"
echo "Logout and login or run 'source $HOME/.zshrc'"
echo "Run 'pyenv install --list' to list available Python versions"
