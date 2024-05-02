#!/usr/bin/env bash
#
# ffetch - Display system info using fastfetch or neofetch
#          Random configuration selection assumes configs are named:
#            'config-*` in ~/.config/fastfetch/ or ~/.config/neofetch/
#          Use fastfetch if found, otherwise use neofetch
#
# Author: Ronald Joe Record <ronaldrecord@gmail.com>
#
# Usage: ffetch [-c config] [-r] [-u]
# Where:
# 	-c 'config' specifies a configuration file to use
# 	  'config' can be the full path or name of a configuration
# 	-r indicates select configuration file randomly
# 	-u displays this usage messge and exits

FETCH="fastfetch"
have_fetch=$(type -p fastfetch)
[ "${have_fetch}" ] || {
  have_fetch=$(type -p neofetch)
  if [ "${have_fetch}" ]; then
    FETCH="neofetch"
  else
    printf "\nCannot locate fastfetch. Exiting.\n\n"
    exit 1
  fi
}

CONFDIR="${HOME}/.config/${FETCH}"

usage() {
  printf "\nUsage: ffetch [-c config] [-r] [-u]"
  printf "\nWhere:"
  printf "\n\t-c 'config' specifies a configuration file to use"
  printf "\n\t   'config' can be the full path or name of a configuration"
  printf "\n\t-r indicates select configuration file randomly"
  printf "\n\t-u displays this usage messge and exits\n\n"
  exit 1
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

USE_RANDOM=
USE_CONFIG=
while getopts ":c:ru" flag; do
  case $flag in
    r)
      USE_RANDOM=1
      ;;
    c)
      USE_CONFIG="$OPTARG"
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
  exec ${FETCH} --config ${USE_CONFIG} $*
else
  exec ${FETCH} $*
fi
