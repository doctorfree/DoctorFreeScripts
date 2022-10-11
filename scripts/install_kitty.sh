#!/bin/bash

have_kitty=`type -p kitty`
have_curl=`type -p curl`
insecure=
quiet=

install_kitty() {
  [ "${have_kitty}" ] || {
    [ "${quiet}" ] || {
      printf "\n\tInstalling Kitty terminal emulator ..."
    }
    [ "${have_curl}" ] || {
      printf "\n\nCould not locate required curl command. Exiting."
      exit 1
    }
    curl ${insecure} --silent --location \
      https://sw.kovidgoyal.net/kitty/installer.sh > /tmp/kitty-$$.sh
    if [ -s /tmp/kitty-$$.sh ]
    then
      have_stow=`type -p stow`
      if [ "${have_stow}" ]
      then
        sh /tmp/kitty-$$.sh launch=n dest=~/.local/stow > /dev/null 2>&1
        cd ~/.local/stow
        stow kitty.app
        LOCAL=".local/stow"
      else
        sh /tmp/kitty-$$.sh launch=n > /dev/null 2>&1
        LOCAL=".local"
      fi
      rm -f /tmp/kitty-$$.sh
      # Create a symbolic link to add kitty to PATH
      # (assuming ~/.local/bin is in your system-wide PATH)
      [ -d ~/.local/bin ] || mkdir -p ~/.local/bin
      [ -x ~/.local/bin/kitty ] || {
        ln -s ~/${LOCAL}/kitty.app/bin/kitty ~/.local/bin/
      }
      # Link the kitty man pages somewhere it can be found by the man command
      [ -d ~/.local/share/man/man1 ] || mkdir -p ~/.local/share/man/man1
      [ -f ~/.local/share/man/man1/kitty.1 ] || {
        [ -d ${HOME}/.local/share/man/man1 ] || \
          mkdir -p ${HOME}/.local/share/man/man1
        ln -s ~/${LOCAL}/kitty.app/share/man/man1/kitty.1 \
           ~/.local/share/man/man1/
      }
      [ -d ~/.local/share/man/man5 ] || mkdir -p ~/.local/share/man/man5
      [ -f ~/.local/share/man/man5/kitty.conf.5 ] || {
        [ -d ${HOME}/.local/share/man/man5 ] || \
          mkdir -p ${HOME}/.local/share/man/man5
        ln -s ~/${LOCAL}/kitty.app/share/man/man5/kitty.conf.5 \
           ~/.local/share/man/man5/
      }
      # Place the kitty.desktop file somewhere it can be found by the OS
      [ -d ~/.local/share/applications ] || mkdir -p ~/.local/share/applications
      [ -f ~/.local/share/applications/kitty.desktop ] || {
        cp ~/${LOCAL}/kitty.app/share/applications/kitty.desktop \
           ~/.local/share/applications/
      }
      # If you want to open text files and images in kitty via your file manager
      # also add the kitty-open.desktop file
      [ -f ~/.local/share/applications/kitty-open.desktop ] || {
        cp ~/${LOCAL}/kitty.app/share/applications/kitty-open.desktop \
           ~/.local/share/applications/
      }
      # Update the paths to the kitty and its icon in the kitty.desktop file(s)
      sed -i "s|Icon=kitty|Icon=/home/${MPP_USER}/${LOCAL}/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
      sed -i "s|Exec=kitty|Exec=/home/${MPP_USER}/${LOCAL}/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
      # Install the Kitty terminfo entry
      [ -f "${HOME}/.terminfo/x/xterm-kitty" ] || {
        [ -f "${HOME}/${LOCAL}/lib/kitty/terminfo/kitty.terminfo" ] && {
          have_tic=`type -p tic`
          [ "${have_tic}" ] && {
            [ -d ${HOME}/.terminfo ] || mkdir -p ${HOME}/.terminfo
            [ -d ${HOME}/.terminfo/x ] || mkdir -p ${HOME}/.terminfo/x
            tic -x -o ${HOME}/.terminfo \
              "${HOME}/${LOCAL}/lib/kitty/terminfo/kitty.terminfo" > /dev/null 2>&1
          }
        }
      }
      [ "${quiet}" ] || printf " done!\n"
    else
      printf "\n\n${BOLD}ERROR:${NORM} Download of Kitty installation script failed"
      printf "\nSee https://sw.kovidgoyal.net/kitty/binary/#manually-installing"
      printf "\nto manually install the Kitty terminal emulator\n"
      exit 1
    fi
  }
}

remove_kitty() {
  rm -rf ~/.local/kitty.app
  rm -f ~/.local/bin/kitty
  rm -f ~/.local/share/applications/kitty.desktop
  rm -f ~/.local/share/applications/kitty-open.desktop
  rm -f ~/.local/share/man/man1/kitty.1
  rm -f ~/.local/share/man/man5/kitty.conf.5
  have_kitty=
}

argument="$1"
[ "${argument}" == "insecure" ] || [ "${argument}" == "-k" ] && {
  insecure="--insecure"
  argument="$2"
}

[ "${argument}" == "remove" ] || [ "${argument}" == "-r" ] && {
  printf "\nRemoving Kitty terminal emulator.\n\n"
  while true
  do
    read -p "Do you wish to continue with Kitty removal ? (y/n) " yn
    case $yn in
        [Yy]* )
              break
              ;;
        [Nn]* )
              printf "\nKitty removal aborted."
              printf "\nExiting.\n\n"
              exit 0
              ;;
            * ) echo "Please answer yes or no."
              ;;
    esac
  done
  remove_kitty
  printf "\n${BOLD}Kitty removed${NORM}"
  printf "\nTo re-install Kitty run ${BOLD}'install_kitty'${NORM}\n\n"
  exit 0
}

[ "${quiet}" ] || {
  printf "\nInstalling Kitty terminal emulator\n"
}

while true
do
  read -p "Do you wish to continue with Kitty installation ? (y/n) " yn
  case $yn in
    [Yy]* )
          break
          ;;
    [Nn]* )
          printf "\nKitty installation aborted."
          printf "\nExiting.\n\n"
          exit 0
          ;;
        * ) echo "Please answer yes or no."
          ;;
  esac
done
install_kitty
[ "${quiet}" ] || {
  printf "\n\n${BOLD}Kitty terminal emulator installed${NORM}\n"
}
exit 0
