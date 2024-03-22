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
      sudo apt install $1
    else
      [ "${have_dnf}" ] && sudo dnf install $1
    fi
  fi
}

[ -f ~/.zshrc ] || {
  echo "Zsh initialization file $HOME/.zshrc required. Exiting."
  exit 1
}

if [ "${have_brew}" ]; then
  brew install pyenv
else
  curl https://pyenv.run | bash
fi

grep PYENV_ROOT ~/.zshrc > /dev/null || {
  echo '[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo '[ -d $HOME/.pyenv/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo -e 'if command -v pyenv > /dev/null; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.zshrc
}

source ~/.zshrc

have_pyenv=$(type -p pyenv)
if [ "${have_pyenv}" ]; then
  pyenv install 3.12.2
  pyenv global 3.12.2
else
  echo "WARNING: pyenv not found. Check the pyenv installation and ~/.zshrc"
fi

plat_install pyenv-virtualenv
have_pyvirt=$(type -p pyenv-virtualenv)
[ "${have_pyvirt}" ] || {
  mod_install pyenv-virtualenv
}
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
