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
quota=
dudf=
verbose=

usage() {
  printf "\nUsage: bu2rsync [-b init|create|mount] [-c command] [-lL] [-n]"
  printf "\n                [-q|Q] [-r] [-u] [-U user] [-H host] [-v] folder"
  printf "\nWhere:"
  printf "\n\t-b 'init' initializes a borg backup system on rsync.net"
  printf "\n\t-b 'create' creates a borg backup to rsync.net"
  printf "\n\t-b 'mount' mounts the borg backup repository on /mnt/borg"
  printf "\n\t-c 'command' runs 'command' on rsync.net"
  printf "\n\t-l indicates list the contents of the backup folder"
  printf "\n\t-L indicates recursively list the contents of the backup folder"
  printf "\n\t-n indicates perform a dry run, don't make any changes"
  printf "\n\t-q indicates see how much space your account uses with the quota/df commands"
  printf "\n\t-Q indicates see how much space your account uses with the quota/df/du commands"
  printf "\n\t-r indicates remove remote backup"
  printf "\n\t-v indicates verbose mode"
  printf "\n\t-U 'user' sets the rsync.net user to 'user'"
  printf "\n\t-H 'host' sets the rsync.net host to 'host'"
  printf "\n\t-u displays this usage message and exits\n"
  printf "\nThe 'folder' argument indicates the folder to sync/list/remove with rsync.net\n"
  printf "\nCurrently using rsync.net user/host:"
  printf "\n\t${user}@${host} for ${myhost}\n"
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
    [ -d /usr/local/bin ] || ${SUDO} mkdir -p /usr/local/bin
    ${SUDO} cp /tmp/borg$$ /usr/local/bin/borg
    ${SUDO} chown root:root /usr/local/bin/borg
    ${SUDO} chmod 755 /usr/local/bin/borg
    ${SUDO} ln -s /usr/local/bin/borg /usr/local/bin/borgfs
    rm -f /tmp/borg$$
    printf " done"
  }
}

borg_create() {
  export BORG_REMOTE_PATH=/usr/loca/bin/borg1/borg1
  export BORG_REPO=${user}@${host}:${myhost}/backups

  [ "${BORG_PASSPHRASE}" ] || {
    printf "\nWARNING: No Borg passphrase detected."
    printf "\nExport your passphrase in the environment variable:"
    printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
  }

  info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
  trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

  info "Starting backup"

  borg create                         \
      --verbose                       \
      --filter AME                    \
      --list                          \
      --stats                         \
      --show-rc                       \
      --compression lz4               \
      --exclude-caches                \
      --exclude 'home/*/.cache/*'     \
      --exclude 'home/*/Music/*'      \
      --exclude 'var/tmp/*'           \
      --exclude '*.pyc'               \
                                      \
      ::'{hostname}-{now}'            \
      /etc                            \
      /home                           \
      /root                           \
      /var

  backup_exit=$?

  info "Pruning repository"

  # Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
  # archives of THIS machine. The '{hostname}-*' matching is very important to
  # limit prune's operation to this machine's archives and not apply to
  # other machines' archives also:
  borg prune                          \
      --list                          \
      --glob-archives '{hostname}-*'  \
      --show-rc                       \
      --keep-daily    7               \
      --keep-weekly   4               \
      --keep-monthly  6

  prune_exit=$?

  # free repo disk space by compacting segments
  info "Compacting repository"

  borg compact

  compact_exit=$?

  # use highest exit code as global exit code
  global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
  global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

  if [ ${global_exit} -eq 0 ]; then
    info "Backup, Prune, and Compact finished successfully"
  elif [ ${global_exit} -eq 1 ]; then
    info "Backup, Prune, and/or Compact finished with warnings"
  else
    info "Backup, Prune, and/or Compact finished with errors"
  fi

  exit ${global_exit}
}

if [ "${GH_TOKEN}" ]; then
  AUTH_HEADER="-H \"Authorization: Bearer ${GH_TOKEN}\""
else
  AUTH_HEADER=
fi
export PATH="/usr/local/bin:$PATH"
have_borg=$(type -p borg)
while getopts ":b:c:hHlLnqQrvuU" flag; do
  case $flag in
    b)
      borg="${OPTARG}"
      ;;
    c)
      cmd="${OPTARG}"
      ;;
    H)
      host="${OPTARG}"
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
    Q)
      quota=1
      dudf=1
      ;;
    r)
      remove=1
      ;;
    U)
      user="${OPTARG}"
      ;;
    v)
      verbose="v"
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

[ "${user}" == "<rsync.net username>" ] || [ "${host}" == "<host>.rsync.net" ] && {
  printf "\nERROR: user and host variables must be set too rsync.net account values\n"
  usage
}

SUDO=sudo
if [ "${EUID}" ]; then
  [ ${EUID} -eq 0 ] && SUDO=
else
  uid=$(id -u)
  [ ${uid} -eq 0 ] && SUDO=
fi

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
    [ "${dudf}" ] && {
      printf "\n\nCommand: du -h -d 0 *\n\n"
    }
  else
    printf "\nCommand: quota\n\n"
    ssh ${user}@${host} quota
    printf "\n\nCommand: df -h\n\n"
    ssh ${user}@${host} df -h
    [ "${dudf}" ] && {
      printf "\n\nCommand: du -h -d 0 *\n\n"
      ssh ${user}@${host} du -h -d 0 \*
    }
  fi
  exit 0
}

[ "${borg}" ] && {
  case "${borg}" in
    init|initialize)
      [ "${have_borg}" ] || install_borg
      borg init --encryption=keyfile ${user}@${host}:${myhost}/backups
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
    mount)
      [ "${have_borg}" ] || install_borg
      [ -d /mnt/borg ] || ${SUDO} mkdir -p /mnt/borg
      borg mount ${user}@${host}:${myhost}/backups /mnt/borg
      ;;
    *)
      usage
      ;;
  esac
  exit 0
}

[ "$1" ] || {
  if [ "${list}" ]; then
    src="/."
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

if [ "${list}" ]; then
  if [ "${recurse}" ]; then
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} ls -lRa ${myhost}${src}\n"
    else
      ssh ${user}@${host} ls -lRa "${myhost}${src}"
    fi
  else
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} ls -la ${myhost}${src}\n"
    else
      ssh ${user}@${host} ls -la "${myhost}${src}"
    fi
  fi
else
  if [ "${remove}" ]; then
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} rm -rf${verbose} ${myhost}${src}\n"
    else
      ssh ${user}@${host} rm -rf${verbose} "${myhost}${src}"
    fi
  else
    # Create directory if it does not exist
    top=$(dirname ${myhost}${src})
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} mkdir -p${verbose} ${myhost}\n"
      printf "\nssh ${user}@${host} mkdir -p${verbose} ${top}\n"
    else
      ssh ${user}@${host} mkdir -p${verbose} ${myhost}
      ssh ${user}@${host} mkdir -p${verbose} ${top}
    fi

    # Backup specified directory
    rsync -aHh${dryrun}${verbose} \
      --delete \
      --delete-excluded \
      --exclude='.DS_Store' \
      "${src}/" \
      ${user}@${host}:"${myhost}${src}"
    [ "${dryrun}" ] || {
      printf "\nListing of rsync.net backup folder ${myhost}${src}:\n"
      ssh ${user}@${host} ls -a "${myhost}${src}"
    }
  fi
fi
