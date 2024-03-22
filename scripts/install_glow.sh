#!/usr/bin/env bash
#
# install_glow.sh - install the glow command line markdown renderer
#
# written 19-Mar-2024 by Ronald Joe Record <ronaldrecord@gmail.com>
#

arch=$(uname -m)
[ "${arch}" == "arm64" ] || arch="amd64"
platform=$(uname -s)
plat="linux"
[ "${platform}" == "Darwin" ] && plat="darwin"

install_glow() {
  API_URL="https://api.github.com/repos/${OWNER}/${PROJECT}/releases/latest"
  if [ "${plat}" == "darwin" ]; then
    suff="Darwin"
  else
    suff="Linux"
  fi
  if [ "${arch}" == "arm64" ]; then
    glow_arch="arm64"
  else
    glow_arch="x86_64"
  fi
  DL_URL=
  DL_URL=$(curl --silent ${AUTH_HEADER} "${API_URL}" \
    | jq --raw-output '.assets | .[]?.browser_download_url' \
    | grep "_${suff}_${glow_arch}.tar.gz$")

  printf "\nInstalling %s\n" "${PROJECT}"
  if [ "${DL_URL}" ]; then
    TEMP_TGZ="$(mktemp --suffix=.${suff})"
    wget --quiet -O "${TEMP_TGZ}" "${DL_URL}"
    chmod 644 "${TEMP_TGZ}"
    mkdir /tmp/glow$$
    tar -C /tmp/glow$$ -xzf "${TEMP_TGZ}"
    [ -f /tmp/glow$$/glow ] && {
      [ -d "${HOME}"/.local/bin ] || mkdir -p "${HOME}"/.local/bin
      cp /tmp/glow$$/glow "${HOME}"/.local/bin/glow
      chmod 755 "${HOME}"/.local/bin/glow
    }
    rm -f "${TEMP_TGZ}"
    rm -rf /tmp/glow$$
  else
    have_brew=$(type -p brew)
    [ "${have_brew}" ] && brew install glow >/dev/null 2>&1
    have_glow=$(type -p glow)
    [ "${have_glow}" ] || {
      [ -x /usr/local/go/bin/go ] && {
        /usr/local/go/bin/go install github.com/charmbracelet/glow@latest
      }
    }
  fi
}

# GH_TOKEN, a GitHub token must be set in the environment
# If it is not already set then the convenience build script will set it
if [ "${GH_TOKEN}" ]; then
  export GH_TOKEN="${GH_TOKEN}"
else
  export GH_TOKEN="__GITHUB_API_TOKEN__"
fi
# Check to make sure
echo "${GH_TOKEN}" | grep __GITHUB_API | grep __TOKEN__ > /dev/null && {
  # It didn't get set right, unset it
  export GH_TOKEN=
}

if [ "${GH_TOKEN}" ]; then
  AUTH_HEADER="-H \"Authorization: Bearer ${GH_TOKEN}\""
else
  AUTH_HEADER=
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

OWNER=charmbracelet
PROJECT=glow
install_glow
