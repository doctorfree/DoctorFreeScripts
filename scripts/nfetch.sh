#!/usr/bin/env bash
#
# ffetch/nfetch - Display system info using fastfetch or neofetch
#        Random configuration selection assumes configs are named:
#          'config-*` in ~/.config/fastfetch/ or ~/.config/neofetch/
#        Use fastfetch if found, otherwise use neofetch
#
# Author: Ronald Joe Record <ronaldrecord@gmail.com>
#
# Usage: ffetch/nfetch [-a] [-c config] [-r] [-u]
# Where:
#   -a indicates use ascii logo with neofetch
# 	-c 'config' specifies a configuration file to use
# 	  'config' can be the full path or name of a configuration
# 	-r indicates select configuration file randomly
# 	-u displays this usage messge and exits
#
# Link nfetch to ffetch
#
# Change to match your distribution
# IMG="${HOME}/.local/share/icons/hicolor/512x512/apps/apple-logo.png"
IMG="${HOME}/.local/share/icons/hicolor/512x512/apps/ubuntu.png"
FETCHARGS=

prog_name=$(basename "$0")
have_fastfetch=$(type -p fastfetch)
have_neofetch=$(type -p neofetch)

usage() {
  printf "\nUsage: ${prog_name} [-a] [-c config] [-i /path/to/logo] [-r] [-u]"
  printf "\nWhere:"
  printf "\n\t-a indicates use ascii logo with neofetch"
  printf "\n\t-c 'config' specifies a configuration file to use"
  printf "\n\t   'config' can be the full path or name of a configuration"
  printf "\n\t-i '/path/to/logo' specifies an image for neofetch to use"
  printf "\n\t-r indicates select configuration file randomly"
  printf "\n\t-u displays this usage messge and exits\n\n"
  exit 1
}

set_fetch() {
  if [ "${prog_name}" == "nfetch" ]; then
    if [ "${have_neofetch}" ]; then
      FETCH="neofetch"
      [ -f "${IMG}" ] && {
        [ "${USE_ASCII}" ] || FETCHARGS="--kitty ${IMG}"
      }
    else
      if [ "${have_fastfetch}" ]; then
        FETCH="fastfetch"
      else
        printf "\nCannot locate neofetch. Exiting.\n\n"
        exit 1
      fi
    fi
  else
    FETCH="fastfetch"
    [ "${have_fastfetch}" ] || {
      if [ "${have_neofetch}" ]; then
        FETCH="neofetch"
        [ -f "${IMG}" ] && {
          [ "${USE_ASCII}" ] || FETCHARGS="--kitty ${IMG}"
        }
      else
        printf "\nCannot locate fastfetch. Exiting.\n\n"
        exit 1
      fi
    }
  fi
}

get_rand() {
  # We use Bash for the array manipulation
  configs=()
  for conf in ${CONFDIR}/config-*
  do
    [ "${conf}" == "${CONFDIR}/config-*" ] && continue
    configs+=("${conf}")
  done

  # Seed random generator
  seconds=$$$(date +%s)
  USE_CONFIG=${configs[${seconds} % ${#configs[@]}]}
}

USE_ASCII=
USE_RANDOM=
USE_CONFIG=
while getopts ":ac:i:ru" flag; do
  case $flag in
    a)
      USE_ASCII=1
      ;;
    c)
      USE_CONFIG="$OPTARG"
      ;;
    i)
      [ -f "$OPTARG" ] && IMG="$OPTARG"
      ;;
    r)
      USE_RANDOM=1
      ;;
    u)
      usage
      ;;
    \?)
      echo "Invalid option: $flag"
      usage
      ;;
  esac
done
shift $(( OPTIND - 1 ))

[ "${USE_RANDOM}" ] && [ "${USE_CONFIG}" ] && {
  printf "\nIncompatible options: -r cannot be used with -c config. Exiting.\n\n"
  exit 1
}

set_fetch
CONFDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/${FETCH}"

tput clear
export TERM=xterm-kitty

[ "${USE_RANDOM}" ] && get_rand
# Locate the config if specified or randomly selected
[ "${USE_CONFIG}" ] && {
  [ -f "${USE_CONFIG}" ] || {
    if [ -f "${CONFDIR}/${USE_CONFIG}" ]; then
      USE_CONFIG="${CONFDIR}/${USE_CONFIG}"
    else
      if [ -f "${CONFDIR}/${USE_CONFIG}.jsonc" ]; then
        USE_CONFIG="${CONFDIR}/${USE_CONFIG}.jsonc"
      else
        if [ -f "${CONFDIR}/${USE_CONFIG}.conf" ]; then
          USE_CONFIG="${CONFDIR}/${USE_CONFIG}.conf"
        else
          USE_CONFIG=
        fi
      fi
    fi
  }
}

# Use exec to pickup the user's login shell
if [ "${USE_CONFIG}" ]; then
  exec ${FETCH} --config ${USE_CONFIG} ${FETCHARGS} $*
else
  exec ${FETCH} ${FETCHARGS} $*
fi
