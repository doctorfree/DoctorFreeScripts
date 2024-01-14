#!/usr/bin/env bash
#

install_borg() {
  API_URL="https://api.github.com/repos/borgbackup/borg/releases/latest"
  DL_URL=
  DL_URL=$(curl --silent ${AUTH_HEADER} "${API_URL}" \
    | jq --raw-output '.assets | .[]?.browser_download_url' \
    | grep "borg-linux64$")

  [ "${DL_URL}" ] && {
    printf "\n\tInstalling Borg ..."
    wget --quiet -O /tmp/borg$$ "${DL_URL}"
    chmod 644 /tmp/borg$$
    SUDO=sudo
    if [ "${EUID}" ]; then
      [ ${EUID} -eq 0 ] && SUDO=
    else
      uid=$(id -u)
      [ ${uid} -eq 0 ] && SUDO=
    fi
    [ -d /usr/local/bin ] || ${SUDO} mkdir -p /usr/local/bin
    ${SUDO} cp /tmp/borg$$ /usr/local/bin/borg
    ${SUDO} chown root:root /usr/local/bin/borg
    ${SUDO} chmod 755 /usr/local/bin/borg
    ${SUDO} ln -s /usr/local/bin/borg /usr/local/bin/borgfs
    rm -f /tmp/borg$$
    printf " done"
  }
}

if [ "${GH_TOKEN}" ]; then
  AUTH_HEADER="-H \"Authorization: Bearer ${GH_TOKEN}\""
else
  AUTH_HEADER=
fi

install_borg
