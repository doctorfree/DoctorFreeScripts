#!/bin/bash
#
# kitty-control - control the Kitty terminal emulator from the command line
#
# Written Feb 1, 2024 by Ronald Joe Record <ronaldrecord@gmail.com>

# The default background opacity for transparency
OPACITY="0.8"

usage() {
  printf "\nUsage: kitty-control [ dark | load [subdir] | tran [opacity]]"
  printf "\nWhere:"
  printf "\n\t'load' reloads the Kitty configuration in ~/.config/kitty/kitty.conf"
  printf "\n\t       can use 'load', 'reset', or 'reload'"
  printf "\n\t       specify a second argument to load ~/.config/kitty/<subdir>/kitty.conf"
  printf "\n\t       e.g. 'kitty-control load tv' would load ~/.config/kitty/tv/kitty.conf"
  printf "\n\t'dark' sets the Kitty background opacity to 1.0 (fully opaque)"
  printf "\n\t       can use 'dark' or 'opaque'"
  printf "\n\t'tran' sets the Kitty background opacity to 0.8"
  printf "\n\t       can use 'tran', 'trans' or 'transparent'"
  printf "\n\t       specify a second argument to set a custom background opacity:"
  printf "\n\t       kitty-control transparent 0.9"
  printf "\nWithout arguments kitty-control displays this usage message and exits\n\n"
  exit 1
}

kitty-reload() {
  [ "$1" ] && export KITTY_CONFIG_DIRECTORY="${HOME}/.config/kitty/$1"
  kill -SIGUSR1 $(pidof kitty)
}

kitty-opaque() {
  kitty @ set-background-opacity 1.0
}

kitty-transparent() {
  kitty @ set-background-opacity $1
}

[ "$1" ] || usage
case $1 in
  reload|reset|load)
      if [ "$2" ]; then
        if [ -f "${HOME}/.config/kitty/$2/kitty.conf" ]; then
          kitty-reload "$2"
        else
          printf "\n ${HOME}/.config/kitty/$2/kitty.conf does not exist\n"
        fi
      else
        kitty-reload
      fi
      ;;
  dark|opaque)
      kitty-opaque
      ;;
  tran*)
      [ "$2" ] && OPACITY="$2"
      kitty-transparent "${OPACITY}"
      ;;
    *)
      printf "\nUnsupported Kitty control command: $1"
      usage
      ;;
esac
