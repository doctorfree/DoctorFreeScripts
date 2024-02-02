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

brief_usage() {
  printf "\nUsage: kitty-control [-a] [-b /path/to/image] [-f] [-m <match>] [-t <match>]"
  printf "\n                     [-s /path/to/socket] [-u | -h] [back <color>] [fore <color>]"
  printf "\n                     [dark | font [num] | list | load [subdir] | tran [opacity]]"
  [ "$1" == "noexit" ] || {
    printf "\n\nFor a full usage message run 'kitty-control -u'\n\n"
    exit 1
  }
}

usage() {
  brief_usage noexit
  printf "\nWhere:"
  printf "\n    'back color' Sets the background color to 'color'"
  printf "\n           If 'color' is 'reset' restores foreground and background to startup value"
  printf "\n    'dark' Sets the Kitty background opacity to 1.0 (fully opaque)"
  printf "\n           Can use 'dark' or 'opaque'"
  printf "\n    'font num' Sets the font pointsize to 'num'"
  printf "\n           Can use 'font', 'fontsize', 'fontminus', or 'fontplus'"
  printf "\n           The second argument specifies the font size, either absolute, +, or -"
  printf "\n           e.g. 'kitty-control fontsize 24' would set the font size to 24 points"
  printf "\n                'kitty-control font +2' would increase the font size by 2 points"
  printf "\n                'kitty-control font' without argument resets the font size to default"
  printf "\n    'fore color' Sets the foreground color to 'color'"
  printf "\n           If 'color' is 'reset' restores foreground and background to startup value"
  printf "\n    'list' Displays information on Kitty windows"
  printf "\n    'load [subdir]' Reloads the Kitty configuration in ~/.config/kitty/kitty.conf"
  printf "\n           Can use 'load' or 'reload'"
  printf "\n           Specify a second argument to load ~/.config/kitty/<subdir>/kitty.conf"
  printf "\n           e.g. 'kitty-control load tv' would load ~/.config/kitty/tv/kitty.conf"
  printf "\n           'kitty-control load default' restores the kitty.conf used to start this instance"
  printf "\n    'tran [opacity]' Sets the Kitty background opacity to 0.8"
  printf "\n           Can use 'tran', 'opacity', 'trans' or 'transparent'"
  printf "\n           Specify a second argument to set a custom background opacity:"
  printf "\n           e.g. 'kitty-control transparent 0.9'"
  printf "\n    '-a' Indicates modify all windows rather than just the currently active OS window"
  printf "\n    '-b /path/to/image' sets the background image for the specified Kitty windows"
  printf "\n        If /path/to/image is 'none' then any existing image will be removed"
  printf "\n    '-f' Indicates toggle fullscreen"
  printf "\n    '-m <match>' Specifies the window to match"
  printf "\n    '-t <match>' Specifies the tab to match"
  printf "\n        Window/Tab matching can be used in conjunction with most kitty-control commands"
  printf "\n        If <match> is 'help' the Kitty documentation URL for matching will be displayed"
  printf "\n    '-s /path/to/socket' Specifies the socket Kitty is listening on if enabled"
  printf "\n        If /path/to/socket is 'help' some help on configuring a Kitty socket is provided"
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

kitty-background() {
  kitty @ ${SOCKET} set-background-image ${OPTS} $1
}

kitty-opacity() {
  kitty @ ${SOCKET} set-background-opacity ${OPTS} $1
}

set-background() {
  if [ "$1" == "reset" ]; then
    kitty @ ${SOCKET} set-colors ${OPTS} --reset
  else
    kitty @ ${SOCKET} set-colors ${OPTS} background=$1
  fi
}

set-foreground() {
  if [ "$1" == "reset" ]; then
    kitty @ ${SOCKET} set-colors ${OPTS} --reset
  else
    kitty @ ${SOCKET} set-colors ${OPTS} foreground=$1
  fi
}

[ "$1" ] || brief_usage
while getopts ":ab:fm:s:t:hu" flag; do
  case $flag in
    a)
      OPTS="$OPTS -a"
      ;;
    b)
      if [ "${OPTARG}" == "none" ]; then
        kitty-background "${OPTARG}"
      else
        if [ -f "${OPTARG}" ]; then
          kitty-background "${OPTARG}"
        else
          printf "\nSpecified Kitty background image ${OPTARG} not found\n"
          exit 1
        fi
      fi
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
      if [ "${OPTARG}" == "help" ]; then
        printf "\nStart kitty as:"
        printf "\n\tkitty -o allow_remote_control=yes --listen-on unix:/tmp/mykitty"
        printf "\nThe kitty '--listen-on' option tells kitty to listen for control messages"
        printf "\nat the specified UNIX-domain socket. See kitty --help for details.\n"
        printf "\nNow you can control this instance of kitty using the"
        printf "\n\tkitten @ --to command line argument to kitten @. For example:"
        printf "\n\tkitten @ --to unix:/tmp/mykitty ls"
        printf "\nRemote control via a socket can be enabled in kitty.conf by setting:"
        printf "\n\tallow_remote_control yes"
        printf "\n\tlisten_on unix:/tmp/mykitty\n"
        printf "\nTo use this with kitty-control set SOCKET=\"--to unix:/tmp/mykitty\""
        printf "\nin kitty-control or invoke kitty-control with '-s /tmp/mykitty'."
        printf "\nFor example: kitty-control -s /tmp/mykitty fontsize 24\n\n"
        exit 0
      else
        SOCKET="--to unix:$OPTARG"
      fi
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

while [ "$1" ]
do
  case $1 in
    back*)
      set-background "$2"
      shift 2
      ;;
    fore*)
      set-foreground "$2"
      shift 2
      ;;
    list|ls)
      kitty-list
      shift
      ;;
    load|reload)
      if [ "$2" ]; then
        if [ -f "${CONFDIR}/$2/kitty.conf" ]; then
          kitty-reload "$2"
          shift 2
        else
          [ "$2" == "default" ] || {
            printf "\n ${CONFDIR}/$2/kitty.conf does not exist\n"
            shift
          }
        fi
      else
        kitty-reload
        shift
      fi
      ;;
    dark|opaque)
      kitty-opacity "1.0"
      shift
      ;;
    fontmin*|fontdec*)
      if [ "$2" ]; then
        kitty-fontminus "$2"
        shift 2
      else
        kitty-fontminus 1
        shift
      fi
      ;;
    fontplus|fontinc*)
      if [ "$2" ]; then
        kitty-fontplus "$2"
        shift 2
      else
        kitty-fontplus 1
        shift
      fi
      ;;
    font*)
      if [ "$2" ]; then
        kitty-fontsize "$2"
        shift 2
      else
        kitty-fontsize 0
        shift
      fi
      ;;
    opacity|tran*)
      if [ "$2" ]; then
        OPACITY="$2"
        shift 2
      else
        shift
      fi
      kitty-opacity "${OPACITY}"
      ;;
    *)
      printf "\nUnsupported Kitty control command: $1"
      usage
      ;;
  esac
done
