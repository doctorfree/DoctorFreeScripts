#!/bin/bash
#  __ _  __  ____  ____  _  _       ___  __   __ _  ____  ____   __   __   
# (  / )(  )(_  _)(_  _)( \/ )___  / __)/  \ (  ( \(_  _)(  _ \ /  \ (  )  
#  )  (  )(   )(    )(   )  /(___)( (__(  O )/    /  )(   )   /(  O )/ (_/\
# (__\_)(__) (__)  (__) (__/       \___)\__/ \_)__) (__) (__\_) \__/ \____/
#
# kitty-control - control the Kitty terminal emulator from the command line
#
# Written Feb 1, 2024 by Ronald Joe Record <ronaldrecord@gmail.com>
#
# The Kitty configuration directory
CONFDIR="${HOME}/.config/kitty"
# The default background opacity for transparency
OPACITY="0.8"
# The socket Kitty is listening on if configured
# Set here to avoid needing to pass -s /path/to/socket every time
# The format of this setting is:
# SOCKET="--to unix:/path/to/socket"
# Leave blank if no listen socket configured or to specify with -s /path/to/socket
SOCKET=
# Kitty remote control options are used to specify which windows/tabs to modify
OPTS=

usage() {
  printf "\nUsage: kitty-control [ dark | font [num] | list | load [subdir] | tran [opacity]]"
  printf "\n                     [-a] [-f] [-m <match>] [-t <match>] [ -h | -u ] [-s /path/to/socket]"
  printf "\nWhere:"
  printf "\n    'dark' Sets the Kitty background opacity to 1.0 (fully opaque)"
  printf "\n           Can use 'dark' or 'opaque'"
  printf "\n    'font' Sets the font size to 'num'"
  printf "\n           Can use 'font', 'fontsize', 'fontminus', or 'fontplus'"
  printf "\n           The second argument specifies the font size, either absolute, +, or -"
  printf "\n           e.g. 'kitty-control font 24' would set the font size to 24 points"
  printf "\n                'kitty-control font +2' would increase the font size by 2 points"
  printf "\n                'kitty-control font' without argument resets the font size to default"
  printf "\n    'list' Displays information on Kitty windows"
  printf "\n           Can be used in conjunction with '-m <match>' and '-t <match> to limit the output"
  printf "\n    'load' Reloads the Kitty configuration in ~/.config/kitty/kitty.conf"
  printf "\n           Can use 'load', 'reset', or 'reload'"
  printf "\n           Specify a second argument to load ~/.config/kitty/<subdir>/kitty.conf"
  printf "\n           e.g. 'kitty-control load tv' would load ~/.config/kitty/tv/kitty.conf"
  printf "\n           'kitty-control load default' restores the kitty.conf used to start this instance"
  printf "\n    'tran' Sets the Kitty background opacity to 0.8"
  printf "\n           Can use 'tran', 'trans' or 'transparent'"
  printf "\n           Specify a second argument to set a custom background opacity:"
  printf "\n           e.g. 'kitty-control transparent 0.9'"
  printf "\n    '-a' Indicates modify all windows rather than just the currently active OS window"
  printf "\n    '-f' Indicates toggle fullscreen"
  printf "\n    '-m <match>' Specifies the window to match"
  printf "\n    '-t <match>' Specifies the tab to match"
  printf "\n        If <match> is 'help' the Kitty documentation URL for matching will be displayed"
  printf "\n    '-s /path/to/socket' Specifies the socket Kitty is listening on if enabled"
  printf "\n    '-u or -h' Displays this usage message and exits"
  printf "\nAdjusting the background opacity or font size requires the original kitty.conf"
  printf "\nthat was used for this instance of Kitty to have enabled the following:"
  printf "\n    'dynamic_background_opacity yes' and 'allow_remote_control yes'"
  printf "\nSee https://sw.kovidgoyal.net/kitty/remote-control/#control-kitty-from-scripts\n"
  exit 1
}

kitty-fontminus() {
  size="$1"
  first_size=${size::1}
  if [[ "${first_size}" == "-" ]]; then
    kitty @ ${SOCKET} set-font-size ${OPTS} -- $size
  else
    kitty @ ${SOCKET} set-font-size ${OPTS} -- -$size
  fi
}

kitty-fontplus() {
  size="$1"
  first_size=${size::1}
  if [[ "${first_size}" == "+" ]]; then
    kitty @ ${SOCKET} set-font-size ${OPTS} $size
  else
    kitty @ ${SOCKET} set-font-size ${OPTS} +$size
  fi
}

kitty-fontsize() {
  size="$1"
  first_size=${size::1}
  if [[ "${first_size}" == "-" ]]; then
    kitty @ ${SOCKET} set-font-size ${OPTS} -- $size
  else
    kitty @ ${SOCKET} set-font-size ${OPTS} $size
  fi
}

toggle-fullscreen() {
  kitty @ ${SOCKET} resize-os-window --action toggle-fullscreen ${OPTS}
}

kitty-list() {
  kitty @ ${SOCKET} ls ${OPTS}
}

kitty-reload() {
  [ "$1" ] && {
    [ -f "${CONFDIR}/default/kitty.conf" ] || {
      [ -d "${CONFDIR}/default" ] || mkdir -p "${CONFDIR}/default"
      cp "${CONFDIR}/kitty.conf" "${CONFDIR}/default/kitty.conf"
    }
    cp "${CONFDIR}/$1/kitty.conf" "${CONFDIR}/kitty.conf"
  }
  kill -SIGUSR1 $(pidof kitty)
}

kitty-opaque() {
  kitty @ ${SOCKET} set-background-opacity ${OPTS} 1.0
}

kitty-transparent() {
  kitty @ ${SOCKET} set-background-opacity ${OPTS} $1
}

[ "$1" ] || usage
while getopts ":afm:s:t:hu" flag; do
  case $flag in
    a)
      OPTS="$OPTS -a"
      ;;
    f)
      toggle-fullscreen
      ;;
    m)
      if [ "${OPTARG}" == "help" ]; then
        printf "\nSee https://sw.kovidgoyal.net/kitty/remote-control/#matching-windows-and-tabs\n\n"
        exit 0
      else
        OPTS="$OPTS -m ${OPTARG}"
      fi
      ;;
    s)
      SOCKET="--to unix:$OPTARG"
      ;;
    t)
      if [ "${OPTARG}" == "help" ]; then
        printf "\nSee https://sw.kovidgoyal.net/kitty/remote-control/#matching-windows-and-tabs\n\n"
        exit 0
      else
        OPTS="$OPTS -t ${OPTARG}"
      fi
      ;;
    h|u)
      usage
      ;;
    \?)
      echo "Invalid option: $flag"
      usage
      ;;
  esac
done
shift $(( OPTIND - 1 ))

case $1 in
  list|ls)
      kitty-list
      ;;
  load|reload|reset)
      if [ "$2" ]; then
        if [ -f "${CONFDIR}/$2/kitty.conf" ]; then
          kitty-reload "$2"
        else
          [ "$2" == "default" ] || {
            printf "\n ${CONFDIR}/$2/kitty.conf does not exist\n"
          }
        fi
      else
        kitty-reload
      fi
      ;;
  dark|opaque)
      kitty-opaque
      ;;
  fontmin*|fontdec*)
      if [ "$2" ]; then
        kitty-fontminus "$2"
      else
        printf "\nFont size decrement must be specified with the 'fontminus' argument"
        usage
      fi
      ;;
  fontplus|fontinc*)
      if [ "$2" ]; then
        kitty-fontplus "$2"
      else
        printf "\nFont size increment must be specified with the 'fontplus' argument"
        usage
      fi
      ;;
  font*)
      if [ "$2" ]; then
        kitty-fontsize "$2"
      else
        kitty-fontsize 0
      fi
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
