#!/bin/bash
#
# Modify 'user' and 'host' with your rsync.net username and hostname
user="<rsync.net username>"
host="<host>.rsync.net"
myhost="$(hostname)"
borg=
cmd=
dryrun=
list=
recurse=
remove=
src=
name=
quota=
verbose=

usage() {
  printf "\nUsage: bu2rsync [-b init|create] [-c command] [-lL] [-n] [-q] [-r] [-v] directory"
  printf "\nWhere:"
  printf "\n\t-b 'init' initializes a borg backup system on rsync.net"
  printf "\n\t-b 'create' creates a borg backup to rsync.net"
  printf "\n\t-c 'command' runs 'command' on rsync.net"
  printf "\n\t-l indicates list the contents of the backup folder"
  printf "\n\t-L indicates recursively list the contents of the backup folder"
  printf "\n\t-n indicates perform a dry run, don't make any changes"
  printf "\n\t-q indicates see how much space your account uses with the quota command"
  printf "\n\t-r indicates remove remote backup"
  printf "\n\t-v indicates verbose mode"
  printf "\n\t-u displays this usage message and exits\n"
  exit 1
}

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
    [ -d /usr/local/bin ] || sudo mkdir -p /usr/local/bin
    sudo cp /tmp/borg$$ /usr/local/bin/borg
    sudo chown root:root /usr/local/bin/borg
    sudo chmod 755 /usr/local/bin/borg
    sudo ln -s /usr/local/bin/borg /usr/local/bin/borgfs
    rm -f /tmp/borg$$
    printf " done"
  }
}

borg_create() {
  REPOSITORY=${user}@${host}:${myhost}/backups
  export BORG_REMOTE_PATH=/usr/loca/bin/borg1/borg1

  # Backup all of /home and /var/www except a few
  # excluded directories
  borg create -v --stats                        \
    $REPOSITORY::'{hostname}-{now:%Y-%m-%d}'    \
    /home                                       \
    /var/www                                    \
    --exclude "${HOME}/.cache"                  \
    --exclude "${HOME}/Music"                   \
    --exclude '*.pyc'

  # Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
  # archives of THIS machine. The '{hostname}-' prefix is very important to
  # limit prune's operation to this machine's archives and not apply to
  # other machine's archives also.
  borg prune -v --list $REPOSITORY --prefix '{hostname}-' \
    --keep-daily=7 --keep-weekly=4 --keep-monthly=6
}

if [ "${GH_TOKEN}" ]; then
  AUTH_HEADER="-H \"Authorization: Bearer ${GH_TOKEN}\""
else
  AUTH_HEADER=
fi
export PATH="/usr/local/bin:$PATH"
have_borg=$(type -p borg)
while getopts ":b:c:lLnqrvu" flag; do
  case $flag in
    b)
      borg="${OPTARG}"
      ;;
    c)
      cmd="${OPTARG}"
      ;;
    l)
      list=1
      ;;
    L)
      list=1
      recurse=1
      ;;
    n)
      dryrun="nv"
      ;;
    q)
      quota=1
      ;;
    r)
      remove=1
      ;;
    v)
      verbose="v"
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

[ "${cmd}" ] && {
  printf "\nCommand: ${cmd}\n"
  if [ "${dryrun}" ]; then
    printf "\nssh ${user}@${host} ${cmd}\n"
  else
    ssh ${user}@${host} ${cmd}
  fi
  exit 0
}

[ "${quota}" ] && {
  if [ "${dryrun}" ]; then
    printf "\nCommand: quota\n\n"
    printf "\n\nCommand: df -h\n\n"
    printf "\n\nCommand: du -h -d 0 *\n\n"
  else
    printf "\nCommand: quota\n\n"
    ssh ${user}@${host} quota
    printf "\n\nCommand: df -h\n\n"
    ssh ${user}@${host} df -h
    printf "\n\nCommand: du -h -d 0 *\n\n"
    ssh ${user}@${host} du -h -d 0 \*
  fi
  exit 0
}

[ "${borg}" ] && {
  case "${borg}" in
    init|initialize)
      [ "${have_borg}" ] || install_borg
      borg init ${user}@${host}:${myhost}/backups
      printf "\nExport your passphrase with:"
      printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
      ;;
    create)
      [ "${BORG_PASSPHRASE}" ] || {
        printf "\nWARNING: No Borg passphrase detected."
        printf "\nExport your passphrase in the environment variable:"
        printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
      }
      [ "${have_borg}" ] || {
        install_borg
        borg init ${user}@${host}:${myhost}/backups
        printf "\nExport your passphrase with:"
        printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
      }
      have_create=$(type -p borg-create)
      if [ "${have_create}" ]; then
        borg-create
      else
        borg_create
      fi
      ;;
    *)
      usage
      ;;
  esac
  exit 0
}

[ "$1" ] || {
  if [ "${list}" ]; then
    src="."
  else
    printf "\nDirectory argument required to upload or remove folders\n"
    printf "\nCurrent rsync.net ${myhost} directory listing:\n"
    ssh ${user}@${host} ls -la "${myhost}"
    usage
  fi
}
[ "${list}" ] || {
  [ "${remove}" ] || {
    [ "${quota}" ] || {
      [ -d "$1" ] || {
        printf "\nERROR: $1 does not exist or is not a directory\n"
        usage
      }
    }
  }
}

[ "${src}" ] || src="$(realpath "$1" | sed -e "s%/$%%")"
name="$(echo "${src}" | sed -e "s%/%_%g" | sed -e "s/^_//")"

if [ "${list}" ]; then
  if [ "${recurse}" ]; then
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} ls -lRa ${myhost}/${name}\n"
    else
      ssh ${user}@${host} ls -lRa "${myhost}/${name}"
    fi
  else
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} ls -la ${myhost}/${name}\n"
    else
      ssh ${user}@${host} ls -la "${myhost}/${name}"
    fi
  fi
else
  if [ "${remove}" ]; then
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} rm -rf${verbose} ${myhost}/${name}\n"
    else
      ssh ${user}@${host} rm -rf${verbose} "${myhost}/${name}"
    fi
  else
    # Create directory if it does not exist
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} mkdir -p${verbose} ${myhost}\n"
    else
      ssh ${user}@${host} mkdir -p${verbose} ${myhost}
    fi

    # Backup specified directory
    rsync -aHh${dryrun}${verbose} \
      --delete \
      --delete-excluded \
      --exclude='.DS_Store' \
      "${src}/" \
      ${user}@${host}:"${myhost}/${name}"
    [ "${dryrun}" ] || {
      printf "\nListing of rsync.net backup folder ${myhost}/${name}:\n"
      ssh ${user}@${host} ls -a "${myhost}/${name}"
    }
  fi
fi
