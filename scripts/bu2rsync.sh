#!/bin/bash
#       _             ____
#      | |__   _   _ |___ \  _ __  ___  _   _  _ __    ___
#      | '_ \ | | | |  __) || '__|/ __|| | | || '_ \  / __|
#      | |_) || |_| | / __/ | |   \__ \| |_| || | | || (__
#      |_.__/  \__,_||_____||_|   |___/ \__, ||_| |_| \___|
#                                       |___/
#
# Manage backups/storage on rsync.net
# Usage: bu2rsync -u
#
# Written 2024-01-14 by Ronald Joe Record <ronaldrecord@gmail.com>
# See: https://www.rsync.net/resources/howto/unix.html
#
# ========================= Customize ==============================
# Modify 'user' and 'host' with your rsync.net username and hostname
user="<rsync.net username>"
host="<host>.rsync.net"
# ======================= End Customize ============================
myhost="$(hostname)"
bdir="backups"
mntpt="/mnt/borg"
borg=
cmd=
dryrun=
list=
quota=
recurse=
remove=
src=
tybu="create"
dudf=
verbose=

usage() {
  printf "\nUsage: bu2rsync [-b init|check|create|delete|info|list|mount|umount]"
  printf "\n                [-c cmd] [-d dir] [-lLn] [-m mnt] [-U user] [-H host]"
  printf "\n                [-qQruv] [-t default|full|home|logs] folder"
  printf "\nWhere:"
  printf "\n\t-b 'init' initializes a borg backup system on rsync.net"
  printf "\n\t-b 'check' verifies the consistency of the borg backup repository"
  printf "\n\t-b 'create' creates a borg backup to rsync.net"
  printf "\n\t   combine with '-t default|full|home|logs' (default: default)"
  printf "\n\t   -t 'default' performs a borg backup of /home /var and /etc"
  printf "\n\t   -t 'full' performs a full borg backup to rsync.net"
  printf "\n\t   -t 'home' performs a borg backup of only /home to rsync.net"
  printf "\n\t   -t 'logs' performs a borg backup of only /var/log to rsync.net"
  printf "\n\t-b 'delete' deletes the borg backup repository on rsync.net"
  printf "\n\t-b 'info' displays detailed information about the borg backup repository"
  printf "\n\t-b 'list' lists all archives in the borg backup repository"
  printf "\n\t-b 'mount' mounts the borg backup repository on ${mntpt}"
  printf "\n\t-b 'umount' unmounts the borg backup repository from ${mntpt}"
  printf "\n\t-c 'cmd' runs command 'cmd' on rsync.net"
  printf "\n\t-d 'dir' specifies a borg backup directory (default: 'backups'"
  printf "\n\t-l indicates list the contents of the backup folder"
  printf "\n\t-L indicates recursively list the contents of the backup folder"
  printf "\n\t-m 'mnt' specifies the mount point for the borg repo (default: /mnt/borg)"
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

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }

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
  [ "${BORG_PASSPHRASE}" ] || {
    printf "\nWARNING: No Borg passphrase detected."
    printf "\nExport your passphrase in the environment variable:"
    printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
  }

  trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

  info "Starting backup"

  if [ "$1" == "full" ]; then
    ${SUDO} borg create                           \
      --verbose                                   \
      --filter AME                                \
      --list                                      \
      --stats                                     \
      --show-rc                                   \
      --compression lz4                           \
      --one-file-system                           \
      --exclude-caches                            \
      --exclude-if-present '.nobackup'            \
      --keep-exclude-tags                         \
      --exclude '/root/.cache'                    \
      --exclude '/home/*/.cache'                  \
      --exclude '/home/*/.local/share/Daedalus'   \
      --exclude '/home/*/Music/*'                 \
      --exclude '/home/*/transfers/*'             \
      --exclude '/home/*/.irssi/irclogs/'         \
      --exclude '/var/tmp/*'                      \
      --exclude '/var/cache'                      \
      --exclude '/var/lib/docker/devicemapper'    \
      --exclude '/var/lock/*'                     \
      --exclude '/var/log/*'                      \
      --exclude '/var/run/*'                      \
      --exclude '/var/tmp/*'                      \
      --exclude '/var/backups/*'                  \
      --exclude '/var/spool/*'                    \
      --exclude '*/.Trash-*'                      \
      --exclude '*/[Cc]ache/*'                    \
      --exclude '*/.bitcoin/blocks/*'             \
      --exclude '*.vmdk'                          \
      --exclude '/tmp/*'                          \
      --exclude '*/build-area/*'                  \
      --exclude '/proc/*'                         \
      --exclude '/dev/*'                          \
      --exclude '/sys/*'                          \
      --exclude '*.pyc'                           \
                                                  \
      ::'{hostname}-full-{now}'                   \
      /                                           \
      /boot                                       \
      /home                                       \
      /root                                       \
      /usr                                        \
      /var
  else
    if [ "$1" == "home" ]; then
      ${SUDO} borg create                           \
        --verbose                                   \
        --filter AME                                \
        --list                                      \
        --stats                                     \
        --show-rc                                   \
        --compression lz4                           \
        --one-file-system                           \
        --exclude-caches                            \
        --exclude '/home/*/.cache/*'                \
        --exclude '/home/*/.local/share/Daedalus'   \
        --exclude '/home/*/Music/*'                 \
        --exclude '/home/*/transfers/*'             \
        --exclude '*.pyc'                           \
                                                    \
        ::'{hostname}-home-{now}'                   \
        /home
    else
      if [ "$1" == "logs" ]; then
        ${SUDO} borg create                          \
          --verbose                                  \
          --stats                                    \
          ::'{hostname}-logs-{now}'                  \
          /var/log/
      else
        ${SUDO} borg create                           \
          --verbose                                   \
          --filter AME                                \
          --list                                      \
          --stats                                     \
          --show-rc                                   \
          --compression lz4                           \
          --one-file-system                           \
          --exclude-caches                            \
          --exclude '/root/.cache'                    \
          --exclude '/home/*/.cache/*'                \
          --exclude '/home/*/.local/share/Daedalus'   \
          --exclude '/home/*/Music/*'                 \
          --exclude '/home/*/transfers/*'             \
          --exclude '/var/tmp/*'                      \
          --exclude '/var/cache'                      \
          --exclude '/var/lib/docker/devicemapper'    \
          --exclude '/var/lock/*'                     \
          --exclude '/var/log/*'                      \
          --exclude '/var/run/*'                      \
          --exclude '/var/tmp/*'                      \
          --exclude '/var/backups/*'                  \
          --exclude '/var/spool/*'                    \
          --exclude '*/.Trash-*'                      \
          --exclude '*/[Cc]ache/*'                    \
          --exclude '*/.bitcoin/blocks/*'             \
          --exclude '*.vmdk'                          \
          --exclude '*.pyc'                           \
                                                      \
          ::'{hostname}-{now}'                        \
          /etc                                        \
          /home                                       \
          /root                                       \
          /var
      fi
    fi
  fi

  backup_exit=$?

  info "Pruning repository"

  ${SUDO} borg prune                \
    --list                          \
    --glob-archives '{hostname}-*'  \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  3

  prune_exit=$?

  # free repo disk space by compacting segments
  info "Compacting repository"

  ${SUDO} borg compact

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
while getopts ":b:c:d:hHlLm:nqQrt:vuU" flag; do
  case $flag in
    b)
      borg="${OPTARG}"
      ;;
    c)
      cmd="${OPTARG}"
      ;;
    d)
      bdir="${OPTARG}"
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
    m)
      mntpt="${OPTARG}"
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
    t)
      tybu="${OPTARG}"
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

uid=$(id -u)
gid=$(id -g)
SUDO="sudo -E"
if [ "${EUID}" ]; then
  [ ${EUID} -eq 0 ] && SUDO=
else
  [ ${uid} -eq 0 ] && SUDO=
fi

[ "${BORG_PASSPHRASE}" ] || {
  [ -f ${HOME}/.private ] && source ${HOME}/.private
}

export BORG_REMOTE_PATH=/usr/loca/bin/borg1/borg1
export BORG_REPO=${user}@${host}:${myhost}/${bdir}

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
  have_borg=$(type -p borg)
  [ "${have_borg}" ] || install_borg
  case "${borg}" in
    init|initialize)
      ${SUDO} borg init --encryption=keyfile ${user}@${host}:${myhost}/${bdir} 2>/dev/null
      printf "\nExport your passphrase with:"
      printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
      ;;
    check)
      ${SUDO} borg check ${user}@${host}:${myhost}/${bdir} 2>/dev/null
      ;;
    create)
      [ "${BORG_PASSPHRASE}" ] || {
        printf "\nWARNING: No Borg passphrase detected."
        printf "\nExport your passphrase in the environment variable:"
        printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
      }
      ${SUDO} borg check --repository-only ${user}@${host}:${myhost}/${bdir} 2>/dev/null
      [ $? -eq 2 ] && {
        ${SUDO} borg init ${user}@${host}:${myhost}/${bdir} 2>/dev/null
        printf "\nExport your passphrase with:"
        printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
      }
      have_create=$(command -v borg-create)
      if [ "${have_create}" ]; then
        ${SUDO} ${have_create} ${bdir} ${tybu}
      else
        borg_create ${tybu}
      fi
      ;;
    delete)
      info "Deleting repository ${myhost}/${bdir}"
      ${SUDO} borg delete ${user}@${host}:${myhost}/${bdir}
      info "Compacting repository ${myhost}/${bdir}"
      ${SUDO} borg compact ${user}@${host}:${myhost}/${bdir} 2>/dev/null
      ;;
    info|information)
      ${SUDO} borg info ${user}@${host}:${myhost}/${bdir} 2>/dev/null
      ;;
    list)
      ${SUDO} borg list ${user}@${host}:${myhost}/${bdir} 2>/dev/null
      ;;
    mount)
      [ -d ${mntpt} ] || ${SUDO} mkdir -p ${mntpt}
      ${SUDO} chown ${uid}:${gid} ${mntpt}
      ${SUDO} borg mount ${user}@${host}:${myhost}/${bdir} ${mntpt} 2>/dev/null
      ;;
    umount|unmount)
      ${SUDO} borg umount ${mntpt}
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
