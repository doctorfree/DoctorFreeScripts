#!/usr/bin/env bash
#
# ffetch - Display a randomly selected fastfetch configuration
#          Assumes configs are named 'config-*` in ~/.config/fastfetch/
#          If fastfetch not found, use neofetch if available

FETCH="fastfetch"
have_fetch=$(type -p fastfetch)
[ "${have_fetch}" ] || {
  have_fetch=$(type -p neofetch)
  if [ "${have_fetch}" ]; then
    FETCH="neofetch"
  else
    echo "Cannot locate fastfetch. Exiting."
    exit 1
  fi
}

CONFDIR="${HOME}/.config/${FETCH}"

tput clear
export TERM=xterm-kitty

# We use Bash for the array manipulation
configs=()
for conf in ${CONFDIR}/config-*
do
  [ "${conf}" == "${CONFDIR}/config-*" ] && continue
  configs+=("${conf}")
done

# Seed random generator
RANDOM=$$$(date +%s)
USE_CONFIG=${configs[$RANDOM % ${#configs[@]}]}
# Use exec to pickup the user's login shell
if [ "${USE_CONFIG}" ]; then
  exec ${FETCH} --config ${USE_CONFIG} $*
else
  exec ${FETCH} $*
fi
