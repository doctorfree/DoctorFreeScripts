#!/bin/bash
#
# Set this to the default website to monitor
URL="https://ronrecord.com"

# If invoked with an argument, use that as the URL for the website
[ "$1" ] && {
  if echo $1 | grep http > /dev/null; then
    URL="$1"
  else
    URL="https://$1"
  fi
}

# Try to find updo, if not found then try to install it
have_updo=$(type -p updo)
[ "${have_updo}" ] || {
  have_go=$(type -p go)
  [ "${have_go}" ] || {
    echo "Cannot locate updo binary or go. Go required to install updo. Exiting."
    exit 1
  }
  go install github.com/Owloops/updo@latest
  have_updo=$(type -p updo)
  [ "${have_updo}" ] || {
    echo "Cannot locate updo binary. Exiting."
    exit 1
  }
}

# See 'updo --help' for additional options
updo --url ${URL} --refresh=10 --should-fail=false
