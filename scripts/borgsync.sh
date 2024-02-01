#!/bin/bash
#      _                                                 
#     | |__    ___   _ __  __ _  ___  _   _  _ __    ___ 
#     | '_ \  / _ \ | '__|/ _` |/ __|| | | || '_ \  / __|
#     | |_) || (_) || |  | (_| |\__ \| |_| || | | || (__ 
#     |_.__/  \___/ |_|   \__, ||___/ \__, ||_| |_| \___|
#                         |___/       |___/              
#
# Manage backups/storage on BorgBase, rsync.net, or ssh server
# Usage: borgsync -u
#
# Written 2024-01-14 by Ronald Joe Record <ronaldrecord@gmail.com>
#
# See: https://www.rsync.net/resources/howto/unix.html
# And: https://borgbase.com/
# And: https://www.borgbackup.org/
#
# ========================= Configure =====================================
# Set the remote username and hostname in /etc/borgsync/base
# REMOTE_USER="<rsync.net username>"
# REMOTE_HOST="<host>.rsync.net"
#
# Override any setting in /etc/borgsync/base in ~/.config/borgsync/base
#
# Set and export BORG_PASSPHRASE in the environment
# export BORG_PASSPHRASE="longandcomplexpassphrase"
# ====================== End Configure ====================================
myhost="$(hostname)"
bdir="backups"
mntpt="/mnt/borg"
allconf=
archive=
borg=
cmd=
debug=
dryrun=
dudf=
list=
quota=
recurse=
remove=
src=
tybu=
update=
verbose=

usage() {
  if [ "${have_rich}" ]; then
    rich "[bold]Usage:[/] [bold italic green]borgsync[/] [cyan]\[[/][yellow]-b init|check|create|delete|export|extract|info|list|mount|umount[/][cyan]][/]" --print
    rich "                [cyan]\[[/][yellow]-a archive[/][cyan]] \[-B] \[[/][yellow]-C config[/][cyan]] \[[/][yellow]-c cmd[/][cyan]] \[[/][yellow]-d dir[/][cyan]] \[-DlLn] \[[/][yellow]-m mnt[/][cyan]][/]" --print
    rich "                [cyan]\[[/][yellow]-U user[/][cyan]] \[[/][yellow]-H host[/][cyan]] \[-qQruvV] \[[/][yellow]-t all|<conf>[/][cyan]] \[[/][yellow]folder[/][cyan]][/]" --print
    rich "[bold]Where:[/]" --print
    rich "  [cyan]-a[/] [yellow]archive[/] [italic]specifies the borg repository archive name to use[/]" --print
    rich "  [cyan]-B[/] indicates [italic]download and update the latest borgsync and borg binary[/]" --print
    rich "  [cyan]-b[/] [yellow]init[/] [italic]initializes a borg backup repository[/]" --print
    rich "  [cyan]-b[/] [yellow]check[/] [italic]verifies the consistency of the borg backup repository[/]" --print
    rich "  [cyan]-b[/] [yellow]create[/] [italic]creates a borg backup on remote storage[/]" --print
    rich "     combine with [cyan]-t[/] [yellow]base|full|home|logs|photos[/] (default: [yellow]base[/])" --print
    rich "  [cyan]-b[/] [yellow]delete[/] [italic]deletes the borg backup repository on remote storage[/]" --print
    rich "  [cyan]-b[/] [yellow]export[/] [italic]exports the borg backup repository key[/]" --print
    rich "  [cyan]-b[/] [yellow]extract[/] [italic]lists what would be extracted and provides a command to extract[/]" --print
    rich "     use the [yellow]folder[/] argument to provide a pattern to match for extraction" --print
    rich "  [cyan]-b[/] [yellow]info[/] [italic]displays detailed information about the borg backup repository[/]" --print
    rich "  [cyan]-b[/] [yellow]list[/] [italic]lists all archives in the borg backup repository[/]" --print
    rich "  [cyan]-b[/] [yellow]mount[/] [italic]mounts the borg backup repository on[/] [yellow]${mntpt}[/]" --print
    rich "  [cyan]-b[/] [yellow]umount[/] [italic]unmounts the borg backup repository from[/] [yellow]${mntpt}[/]" --print
    rich "  [cyan]-C[/] [yellow]path/to/config[/] [italic]specifies the base config file[/] (default: [yellow]${CONFIG}[/])" --print
    rich "  [cyan]-c[/] [yellow]cmd[/] [italic]runs command [yellow]cmd[/] on the remote storage host[/]" --print
    rich "  [cyan]-d[/] [yellow]dir[/] [italic]specifies a borg backup directory[/] (default: [yellow]${bdir}[/])" --print
    rich "  [cyan]-D[/] indicates [italic]enable debug borg output[/]" --print
    rich "  [cyan]-l[/] indicates [italic]list the contents of the backup folder[/]" --print
    rich "  [cyan]-L[/] indicates [italic]recursively list the contents of the backup folder[/]" --print
    rich "  [cyan]-m[/] [yellow]mnt[/] [italic]specifies the mount point for the borg repo[/] (default: [yellow]${mntpt}[/])" --print
    rich "  [cyan]-n[/] indicates [italic]perform a dry run, don't make any changes[/]" --print
    rich "  [cyan]-q[/] indicates [italic]see how much space your account uses with the quota/df commands[/]" --print
    rich "  [cyan]-Q[/] indicates [italic]see how much space your account uses with the quota/df/du commands[/]" --print
    rich "  [cyan]-r[/] indicates [italic]remove remote backup[/]" --print
    rich "  [cyan]-t[/] [yellow]conf[/] [italic]specifies an alternate borgsync config file to use[/]" --print
    rich "     [cyan]-t[/] [yellow]fubar[/] will use the borgsync config file [yellow]${SYSCONFDIR}/fubar[/]" --print
    rich "     [cyan]-t[/] [yellow]all[/] performs the borg command on all configs in [yellow]${SYSCONFDIR}[/]" --print
    rich "  [cyan]-v[/] indicates [italic]verbose mode[/]" --print
    rich "  [cyan]-V[/] [italic]displays the borgsync version and exits[/]" --print
    rich "  [cyan]-U[/] [yellow]user[/] [italic]sets the remote storage user to[/] [yellow]user[/]" --print
    rich "  [cyan]-H[/] [yellow]host[/] [italic]sets the remote storage host to[/] [yellow]host[/]" --print
    rich "  [cyan]-u[/] [italic]displays this usage message and exits[/]" --print
    rich "The [yellow]folder[/] argument indicates the remote storage folder to sync/list/remove" --print
    rich "Without arguments borgsync performs the default borg backup" --print
    printf "\n"
    rich "Currently using [yellow]${user}@${host}[/] for [yellow]${myhost}[/]" --print
  else
    printf "\nUsage: borgsync [-b init|check|create|delete|export|extract|info|list|mount|umount]"
    printf "\n                [-a archive] [-B] [-C config] [-c cmd] [-d dir] [-DlLn] [-m mnt]"
    printf "\n                [-U user] [-H host] [-qQruvV] [-t all|<conf> ] folder"
    printf "\nWhere:"
    printf "\n\t-a 'archive' specifies the borg repository archive name to use"
    printf "\n\t-B indicates download and update the latest borgsync and borg binary"
    printf "\n\t-b 'init' initializes a borg backup repository"
    printf "\n\t-b 'check' verifies the consistency of the borg backup repository"
    printf "\n\t-b 'create' creates a borg backup on remote storage"
    printf "\n\t   combine with '-t base|full|home|logs|photos' (default: base)"
    printf "\n\t-b 'delete' deletes the borg backup repository on remote storage"
    printf "\n\t-b 'export' exports the borg backup repository key"
    printf "\n\t-b 'extract' lists what would be extracted and provides a command to extract"
    printf "\n\t   use the 'folder' argument to provide a pattern to match for extraction"
    printf "\n\t-b 'info' displays detailed information about the borg backup repository"
    printf "\n\t-b 'list' lists all archives in the borg backup repository"
    printf "\n\t-b 'mount' mounts the borg backup repository in ${mntpt}"
    printf "\n\t-b 'umount' unmounts the borg backup repository from ${mntpt}"
    printf "\n\t-C '/path/to/config' specifies the base config file (default: ${CONFIG})"
    printf "\n\t-c 'cmd' runs command 'cmd' on the remote storage host"
    printf "\n\t-d 'dir' specifies a borg backup directory (default: ${bdir})"
    printf "\n\t-D indicates enable debug borg output"
    printf "\n\t-l indicates list the contents of the backup folder"
    printf "\n\t-L indicates recursively list the contents of the backup folder"
    printf "\n\t-m 'mnt' specifies the mount point folder for the borg repo (default: ${mntpt})"
    printf "\n\t-n indicates perform a dry run, don't make any changes"
    printf "\n\t-q indicates see how much space your account uses with the quota/df commands"
    printf "\n\t-Q indicates see how much space your account uses with the quota/df/du commands"
    printf "\n\t-r indicates remove remote backup"
    printf "\n\t-t 'conf' specifies an alternate borgsync config file to use"
    printf "\n\t   '-t fubar' will use the borgsync config file ${SYSCONFDIR}/fubar"
    printf "\n\t   '-t all' performs the borg command on all configs in ${SYSCONFDIR}"
    printf "\n\t-v indicates verbose mode"
    printf "\n\t-V displays the borgsync version and exits"
    printf "\n\t-U 'user' sets the remote storage user to 'user'"
    printf "\n\t-H 'host' sets the remote storage host to 'host'"
    printf "\n\t-u displays this usage message and exits\n"
    printf "\nThe 'folder' argument indicates the remote storage folder to sync/list/remove"
    printf "\nWithout arguments borgsync performs the default borg backup\n"
    printf "\nCurrently using ${user}@${host} for ${myhost}\n"
  fi
  exit 1
}

install_borg() {
  # Releases:
  #   borg-freebsd64
  #   borg-linux64
  #   borg-macos64
  # Currently borgsync only supports macos and linux
  relname="linux64"
  [ "$platform" == "Darwin" ] && relname="macos64"
  API_URL="https://api.github.com/repos/borgbackup/borg/releases/latest"
  DL_URL=
  DL_URL=$(curl --silent ${AUTH_HEADER} "${API_URL}" \
    | jq --raw-output '.assets | .[]?.browser_download_url' \
    | grep "borg-${relname}$")

  [ "${DL_URL}" ] && {
    printf "\n\tInstalling Borg ..."
    wget --quiet -O /tmp/borg$$ "${DL_URL}"
    chmod 644 /tmp/borg$$
    [ -d /usr/local/bin ] || ${SUDO} mkdir -p /usr/local/bin
    ${SUDO} cp /tmp/borg$$ /usr/local/bin/borg
    ${SUDO} chown root:${group} /usr/local/bin/borg
    ${SUDO} chmod 755 /usr/local/bin/borg
    ${SUDO} ln -s /usr/local/bin/borg /usr/local/bin/borgfs
    rm -f /tmp/borg$$
    printf " done"
  }
}

borg_check() {
  if [[ -z ${BORG_CHECK_ARGS[@]} ]]; then
    BORG_CHECK_ARGS=(
      --info
    )
  fi
  [ "${debug}" ] && BORG_CHECK_ARGS+=( --debug )
  [ "${verbose}" ] && BORG_CHECK_ARGS+=( --verbose )

  printf "\nChecking ${BORG_REPO}\n"

  if [ "${dryrun}" ]; then
    printf "\n${SUDO} ${BORG} check %s %s\n" "${BORG_CHECK_ARGS[*]}" "${BORG_REPO}"
  else
    if [ "${verbose}" ]; then
      ${SUDO} ${BORG} check "${BORG_CHECK_ARGS[@]}" "${BORG_REPO}"
    else
      ${SUDO} ${BORG} check "${BORG_CHECK_ARGS[@]}" "${BORG_REPO}" 2>/dev/null
    fi
  fi
}

borg_init() {
  if [[ -z ${BORG_INIT_ARGS[@]} ]]; then
    BORG_INIT_ARGS=(
      --encryption repokey-blake2
    )
  fi
  [ "${debug}" ] && BORG_INIT_ARGS+=( --debug )
  [ "${verbose}" ] && BORG_INIT_ARGS+=( --verbose )

  printf "\nInitializing ${BORG_REPO}"
  if [ "${verbose}" ]; then
    printf " with:\n  ${SUDO} ${BORG} init %s %s\n" "${BORG_INIT_ARGS[*]}" "${BORG_REPO}"
  else
    printf "\n"
  fi
  if [ "${dryrun}" ]; then
    if [[ ${SSH_SUPPORT} == true ]]; then
      printf "\n${SUDO} ssh %s %s mkdir -p%s %s" "${SSH_ARGS[*]}" \
                                                 "${user}@${host}" \
                                                 "${verbose}" \
                                                 "${myhost}"
      printf "\n${SUDO} ssh %s %s mkdir -p%s %s" "${SSH_ARGS[*]}" \
                                                 "${user}@${host}" \
                                                 "${verbose}" \
                                                 "${myhost}/${bdir}"
    else
      printf "\nSSH commands disabled on ${host}\n"
    fi
    printf "\n${SUDO} ${BORG} init %s %s\n" "${BORG_INIT_ARGS[*]}" "${BORG_REPO}"
  else
    if [[ ${SSH_SUPPORT} == true ]]; then
      ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} mkdir -p${verbose} ${myhost}
      ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} mkdir -p${verbose} ${myhost}/${bdir}
    else
      printf "\nSSH commands disabled on ${host}\n"
    fi
    if [ "${verbose}" ]; then
      ${SUDO} ${BORG} init "${BORG_INIT_ARGS[@]}" "${BORG_REPO}"
    else
      ${SUDO} ${BORG} init "${BORG_INIT_ARGS[@]}" "${BORG_REPO}" 2>/dev/null
    fi
  fi
  [ "${BORG_PASSPHRASE}" ] || {
    printf "\nExport your passphrase with:"
    printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
  }
}

borg_create() {
  [ "${BORG_PASSPHRASE}" ] || {
    printf "\nWARNING: No Borg passphrase detected."
    printf "\nExport your passphrase in the environment variable:"
    printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
  }

  trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

  printf "\nStarting backup to ${BORG_REPO}\n"

  if [ "${dryrun}" ]; then
    BORG_CREATE_ARGS+=( --dry-run )
  else
    BORG_CREATE_ARGS+=( --stats )
  fi
  [ "${debug}" ] && BORG_CREATE_ARGS+=( --debug )
  [ "${verbose}" ] && BORG_CREATE_ARGS+=( --verbose )

  EXCLUDE_ARGS=()
  for EXCLUDE in "${EXCLUDES[@]}"; do
    EXCLUDE_ARGS+=( --exclude "${EXCLUDE}" )
  done
  INCLUDE_ARGS=()
  for INCLUDE in "${INCLUDES[@]}"; do
    INCLUDE_ARGS+=( --pattern=+${INCLUDE} )
  done

  [ "${verbose}" ] && printf "\n${SUDO} ${BORG} create %s %s %s %s %s\n" \
                                        "${BORG_CREATE_ARGS[@]}" \
                                        "${EXCLUDE_ARGS[@]}" \
                                        "${INCLUDE_ARGS[@]}" \
                                        "${BORG_REPO}"::'{hostname}-{now}' \
                                        "${PATHS[@]}"
  ${SUDO} ${BORG} create                 \
    "${BORG_CREATE_ARGS[@]}"             \
    "${EXCLUDE_ARGS[@]}"                 \
    "${INCLUDE_ARGS[@]}"                 \
    "${BORG_REPO}"::'{hostname}-{now}'   \
    "${PATHS[@]}"

  backup_exit=$?

  printf "\nPruning repository\n"
  if [[ -z ${BORG_PRUNE_ARGS[@]} ]]; then
    BORG_PRUNE_ARGS=(
      --info
      --list
    )
  fi
  if [ "${dryrun}" ]; then
    BORG_PRUNE_ARGS+=( --dry-run )
  else
    BORG_PRUNE_ARGS+=( --stats )
  fi

  ${SUDO} ${BORG} prune \
    "${BORG_PRUNE_ARGS[@]}" \
    --glob-archives '{hostname}-*' \
    --keep-hourly=${KEEP_HOURLY:-0} \
    --keep-daily=${KEEP_DAILY:-0} \
    --keep-weekly=${KEEP_WEEKLY:-0} \
    --keep-monthly=${KEEP_MONTHLY:-0} \
    --keep-yearly=${KEEP_YEARLY:-0} \
    "${BORG_REPO}"

  prune_exit=$?

  # free repo disk space by compacting segments
  printf "\nCompacting repository\n"

  if [ "${dryrun}" ]; then
    printf "\n${SUDO} ${BORG} compact\n"
  else
    ${SUDO} ${BORG} compact
  fi

  compact_exit=$?

  # use highest exit code as global exit code
  global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
  global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

  if [ ${global_exit} -eq 0 ]; then
    printf "\nBackup, Prune, and Compact finished successfully\n"
  elif [ ${global_exit} -eq 1 ]; then
    printf "\nBackup, Prune, and/or Compact finished with warnings\n"
  else
    printf "\nBackup, Prune, and/or Compact finished with errors\n"
  fi
  [ "${dryrun}" ] && printf "\nThis was a dry run, no changes were made\n"

  exit ${global_exit}
}

install_borgsync() {
  have_git=$(type -p git)
  [ "${have_git}" ] || {
    printf "\nERROR: git command not found. Install git. Exiting.\n"
    exit 1
  }
  git clone https://github.com/doctorfree/borgsync /tmp/borgsync$$
  /tmp/borgsync$$/install
  rm -rf /tmp/borgsync$$
}

load_config() {
  [ -f "${CONFIG}" ] && {
    source "${CONFIG}"
  }
  [ -f "${MYCONF}" ] && {
    source "${MYCONF}"
  }
  [ "${BORG}" ] && [ -x "${BORG}" ] || BORG=$(command -v borg)
  [ "${BORG}" ] || {
    [ -x /usr/local/bin/borg ] && BORG="/usr/local/bin/borg"
  }
  [ "${BORG}" ] || {
    install_borg
    BORG=$(command -v borg)
  }
}

init_config() {
  [ "${REMOTE_USER}" ] && user="${REMOTE_USER}"
  [ "${REMOTE_HOST}" ] && host="${REMOTE_HOST}"
  [ "${BACK_HOST}" ] && myhost="${BACK_HOST}"
  [ "${BACK_DIR}" ] && bdir="${BACK_DIR}"
  [ "${SSH_SUPPORT}" == "" ] && SSH_SUPPORT=true

  [ "${BORG_REMOTE_PATH}" ] || BORG_REMOTE_PATH=/usr/loca/bin/borg1/borg1
  export BORG_REMOTE_PATH
  [ "${BORG_REPO}" ] || BORG_REPO=${user}@${host}:${myhost}/${bdir}
  export BORG_REPO
}

mount_repo() {
  mntrepo="$1"
  if [ "${dryrun}" ]; then
    printf "\n${SUDO} mkdir -p ${mntpt}"
    printf "\n${SUDO} mkdir -p ${mntpt}/${mntrepo}"
    printf "\n${SUDO} chown ${uid}:${gid} ${mntpt}/${mntrepo}"
    printf "\n${SUDO} ${BORG} mount ${BORG_REPO} ${mntpt}/${mntrepo}\n"
  else
    [ -d ${mntpt} ] || ${SUDO} mkdir -p ${mntpt}
    [ -d ${mntpt}/${mntrepo} ] || ${SUDO} mkdir -p ${mntpt}/${mntrepo}
    ${SUDO} chown ${uid}:${gid} ${mntpt}/${mntrepo}
    ${SUDO} ${BORG} mount ${BORG_REPO} ${mntpt}/${mntrepo} 2>/dev/null
  fi
}

unmount_repo() {
  umntrepo="$1"
  if [ "${dryrun}" ]; then
    printf "\n${SUDO} ${BORG} umount ${mntpt}/${umntrepo}\n"
  else
    ${SUDO} ${BORG} umount ${mntpt}/${umntrepo}
  fi
}

show_extract() {
  [ "${archive}" ] || {
    printf "\nArchives in ${BORG_REPO}:\n"
    ${SUDO} ${BORG} list ${BORG_REPO} 2>/dev/null
    archive=$(${SUDO} ${BORG} list --sort timestamp  --format '{time}{TAB}{name}{NEWLINE}' ${BORG_REPO} | grep -v '\.checkpoint$' | tail -1 |  cut -f 2)
  }
  if [ "${archive}" ]; then
    printf "\nLast successful archive in ${BORG_REPO}:\n\t${archive}\n"
    printf "\nList ${archive} with the command:\n"
    printf "\n${SUDO} ${BORG} extract --dry-run --list ${BORG_REPO}::${archive} ${folderargs}\n"
    printf "\nDue to the --dry-run and --list arguments this won't actually restore any files.\n"
    printf "\nExtract ${archive} to the current directory with:\n"
    printf "\n${SUDO} ${BORG} extract --list ${BORG_REPO}::${archive} ${folderargs}\n"
  else
    printf "\nCould not locate an archive in ${BORG_REPO}:\n"
  fi
  [ "${folderargs}" ] && {
    printf "\nThe last part of the command gives the path you're looking to restore."
    printf "\nIf you pass no paths, then all the data will be restored. To extract a"
    printf "\nparticular directory without its full path, add --strip-components n,"
    printf "\nwith n being the number of directories you would like to be stripped.\n"
  }
}

show_info() {
  printf "\nInfo for borg repository:"
  printf "\n========================"
  printf "\nRepository name: ${BORG_REPO}\n"
  if [ "${dryrun}" ]; then
    printf "\n${SUDO} ${BORG} info ${BORG_REPO}\n"
  else
    ${SUDO} ${BORG} info ${BORG_REPO} 2>/dev/null
  fi
  [ "${archive}" ] || {
    archive=$(${SUDO} ${BORG} list --sort timestamp  --format '{time}{TAB}{name}{NEWLINE}' ${BORG_REPO} | grep -v '\.checkpoint$' | tail -1 |  cut -f 2)
  }
  if [ "${archive}" ]; then
    printf "\nInfo for last successful archive:"
    printf "\n================================\n"
    if [ "${dryrun}" ]; then
      printf "\n${SUDO} ${BORG} info ${BORG_REPO}::${archive}\n"
    else
      ${SUDO} ${BORG} info ${BORG_REPO}::${archive} 2>/dev/null
    fi
  else
    printf "\nCould not locate an archive in ${BORG_REPO}:\n"
  fi
}

show_list() {
  if [ "${archive}" ]; then
    printf "\nListing of contents for borg repository archive:"
    printf "\n==============================================="
    printf "\nRepository name: ${BORG_REPO}"
    printf "\nArchive name: ${archive}\n"
    if [ "${dryrun}" ]; then
      printf "\n${SUDO} ${BORG} list ${BORG_REPO}::${archive}\n"
    else
      ${SUDO} ${BORG} list ${BORG_REPO}::${archive} 2>/dev/null
    fi
  else
    printf "\nListing of contents for borg repository:"
    printf "\n======================================="
    printf "\nRepository name: ${BORG_REPO}\n"
    if [ "${dryrun}" ]; then
      printf "\n${SUDO} ${BORG} list ${BORG_REPO}\n"
    else
      ${SUDO} ${BORG} list ${BORG_REPO} 2>/dev/null
    fi
  fi
}

doall() {
  action="$1"
  for conf in ${SYSCONFDIR}/* ${USRCONFDIR}/*
  do
    [ "${conf}" == "${SYSCONFDIR}/*" ] && continue
    [ "${conf}" == "${USRCONFDIR}/*" ] && continue
    inits=()
    cfgbase=$(basename "${conf}")
    case ${cfgbase} in
      base|VERSION|README.md)
          continue
          ;;
      *)
          if [[ " ${inits[*]} " =~ " ${cfgbase} " ]]; then
            continue
          else
            load_config
            [ -f ${SYSCONFDIR}/${cfgbase} ] && source ${SYSCONFDIR}/${cfgbase}
            [ -f ${USRCONFDIR}/${cfgbase} ] && source ${USRCONFDIR}/${cfgbase}
            init_config
            case ${action} in
              check)
                borg_check
                ;;
              create)
                BORG_CHECK_ARGS=(
                  --repository-only
                )
                borg_check
                if [ $? -eq 2 ]; then
                  printf "\nRepository configured in ${conf} is not initialized\n"
                else
                  borg_create
                fi
                ;;
              delete)
                printf "\nDeleting repository ${BORG_REPO}\n"
                if [ "${dryrun}" ]; then
                  printf "\n${SUDO} ${BORG} delete ${BORG_REPO}"
                else
                  ${SUDO} ${BORG} delete ${BORG_REPO}
                fi
                printf "\nCompacting repository ${BORG_REPO}\n"
                if [ "${dryrun}" ]; then
                  printf "\n${SUDO} ${BORG} compact ${BORG_REPO}\n"
                else
                  ${SUDO} ${BORG} compact ${BORG_REPO} 2>/dev/null
                fi
                ;;
              export)
                printf "\nExporting repository key for ${BORG_REPO}\n"
                ${SUDO} ${BORG} key export "${BORG_EXPORT_ARGS[@]}" ${BORG_REPO}
                ;;
              extract)
                show_extract
                ;;
              info)
                show_info
                ;;
              init)
                borg_init
                ;;
              list)
                show_list
                ;;
              mount)
                prefix="dot"
                [ "${BACK_HOST}" == "." ] || prefix="${BACK_HOST}"
                mount_repo "${prefix}_${BACK_DIR}"
                ;;
              unmount)
                prefix="dot"
                [ "${BACK_HOST}" == "." ] || prefix="${BACK_HOST}"
                unmount_repo "${prefix}_${BACK_DIR}"
                ;;
              *)
                printf "\nUnknown action: ${action}\n"
                ;;
            esac
            inits+=("${cfgbase}")
          fi
          ;;
    esac
  done
}

if [ "${GH_TOKEN}" ]; then
  AUTH_HEADER="-H \"Authorization: Bearer ${GH_TOKEN}\""
else
  AUTH_HEADER=
fi
export PATH="/usr/local/bin:$PATH"
[ -x ${HOME}/.local/bin/borgsync ] && {
  export PATH="$HOME/.local/bin:$PATH"
}

have_rich=$(type -p rich)
platform=$(uname -s)
group="root"
[ "${platform}" == "Darwin" ] && group="wheel"

SYSCONFDIR="/etc/borgsync"
USRCONFDIR="${HOME}/.config/borgsync"
CONFIG="${SYSCONFDIR}/base"
MYCONF="${USRCONFDIR}/base"
VERSION="unknown"
RELEASE="unknown"
if [ -f ${SYSCONFDIR}/VERSION ]; then
  . ${SYSCONFDIR}/VERSION
else
  if [ -f ${USRCONFDIR}/VERSION ]; then
    . ${USRCONFDIR}/VERSION
  else
    printf "\n\nMissing borgsync VERSION file!"
    printf "\nBorgsync installation incomplete"
    printf "\nWould you like to repair/install borgsync now?\n"

    while true
    do
      read -p "Repair/install borgsync ? (y/n) " yn
      case $yn in
        [Yy]* )
          install_borgsync
          if [ -f ${SYSCONFDIR}/VERSION ]; then
            . ${SYSCONFDIR}/VERSION
          else
            printf "\nMissing ${SYSCONFDIR}/VERSION file! Exiting.\n"
            exit 1
          fi
          break
          ;;
        [Nn]* )
          printf "\nLeaving borgsync unrepaired/uninstalled\n"
          break
          ;;
        * ) echo "Please answer yes or no."
          ;;
      esac
    done
  fi
fi

load_config
init_config

[ $# -eq 0 ] && borg="create"
while getopts ":a:Bb:c:C:d:DhHlLm:nqQrt:vVuU" flag; do
  case $flag in
    a)
      archive="${OPTARG}"
      ;;
    B)
      update=1
      ;;
    b)
      borg="${OPTARG}"
      ;;
    c)
      cmd="${OPTARG}"
      ;;
    C)
      [ -f "${OPTARG}" ] || {
        printf "\nERROR: Specified base config file ${OPTARG} does not exist\n"
        exit 1
      }
      CONFIG="${OPTARG}"
      load_config
      ;;
    d)
      BACK_DIR="${OPTARG}"
      bdir="${BACK_DIR}"
      ;;
    D)
      debug=1
      ;;
    h)
      have_rich=
      usage
      ;;
    H)
      REMOTE_HOST="${OPTARG}"
      host="${REMOTE_HOST}"
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
      [ "${tybu}" == "all" ] && allconf=1
      ;;
    U)
      REMOTE_USER="${OPTARG}"
      user="${REMOTE_USER}"
      ;;
    v)
      verbose="v"
      ;;
    V)
      printf "Borgsync version ${VERSION} release ${RELEASE}\n"
      exit 0
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

[ "${update}" ] && {
  install_borg
  install_borgsync
  printf "\nBorgsync and Borg updated. Re-run borgsync.\n"
  exit 0
}

[ "${tybu}" ] && {
  if [ "${allconf}" ]; then
    ambconf=
    [ -f ${SYSCONFDIR}/all ] && ambconf="${SYSCONFDIR}/all"
    [ -f ${USRCONFDIR}/all ] && ambconf="${USRCONFDIR}/all"
    [ "${ambconf}" ] && {
      printf "\nERROR: ambiguous command line argument '-t all'"
      printf "\nA borgsync configuration file ${ambconf} exists"
      printf "\nRename the ${ambconf} configuration file, 'all' is a reserved keyword"
      printf "\nExiting\n"
      exit 1
    }
  else
    if [ -f ${SYSCONFDIR}/${tybu} ]; then
      source ${SYSCONFDIR}/${tybu}
      [ -f "${USRCONFDIR}/${tybu}" ] && {
        source "${USRCONFDIR}/${tybu}"
      }
    else
      if [ -f "${USRCONFDIR}/${tybu}" ]; then
        source "${USRCONFDIR}/${tybu}"
      else
        printf "\nERROR: specified backup type ${tybu} does not exist in ${SYSCONFDIR}/"
        printf "\nExiting\n"
        exit 1
      fi
    fi
  fi
}
init_config

[ "${user}" == "<your_remote_user>" ] || \
[ "${host}" == "<your_remote_host>" ] || \
[ "${user}" == "<your_borgbase_remote_user>" ] || \
[ "${host}" == "<your_borgbase_remote_host>" ] && {
  printf "\nERROR: user and host variables must be set to remote storage account values\n"
  printf "\nSet REMOTE_USER and REMOTE_HOST in ${SYSCONFDIR}/base\n"
  exit 1
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

folderargs=
[ "$1" ] && folderargs="$*"

[ "${cmd}" ] && {
  printf "\nCommand: ${cmd}\n"
  if [ "${dryrun}" ]; then
    if [[ ${SSH_SUPPORT} == true ]]; then
      printf "\n${SUDO} ssh %s %s %s\n" "${SSH_ARGS[*]}" "${user}@${host}" "${cmd}"
    else
      printf "\nSSH commands disabled on ${host}\n"
    fi
  else
    if [[ ${SSH_SUPPORT} == true ]]; then
      ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} ${cmd}
    else
      printf "\nSSH commands disabled on ${host}\n"
    fi
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
    if [[ ${SSH_SUPPORT} == true ]]; then
      printf "\nCommand: quota\n\n"
      ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} quota
      printf "\n\nCommand: df -h\n\n"
      ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} df -h
      [ "${dudf}" ] && {
        printf "\n\nCommand: du -h -d 0 *\n\n"
        ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} du -h -d 0 \*
      }
    else
      printf "\nSSH commands disabled on ${host}\n"
    fi
  fi
  exit 0
}

[ "${borg}" ] && {
  have_borg=$(type -p borg)
  [ "${have_borg}" ] || {
    install_borg
    BORG=$(command -v borg)
  }
  case "${borg}" in
    init|initialize)
      borg_init
      [ "${allconf}" ] && doall init
      ;;
    check|verify)
      borg_check
      [ "${allconf}" ] && doall check
      ;;
    backup|create)
      [ "${BORG_PASSPHRASE}" ] || {
        printf "\nWARNING: No Borg passphrase detected."
        printf "\nExport your passphrase in the environment variable:"
        printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
      }
      BORG_CHECK_ARGS=(
        --repository-only
      )
      borg_check
      [ $? -eq 2 ] && borg_init
      borg_create
      [ "${allconf}" ] && doall create
      ;;
    delete|remove)
      printf "\nDeleting repository ${BORG_REPO}\n"
      if [ "${dryrun}" ]; then
        printf "\n${SUDO} ${BORG} delete ${BORG_REPO}"
      else
        ${SUDO} ${BORG} delete ${BORG_REPO}
      fi
      printf "\nCompacting repository ${BORG_REPO}\n"
      if [ "${dryrun}" ]; then
        printf "\n${SUDO} ${BORG} compact ${BORG_REPO}\n"
      else
        ${SUDO} ${BORG} compact ${BORG_REPO} 2>/dev/null
      fi
      [ "${allconf}" ] && doall delete
      ;;
    export|key)
      printf "\nExporting repository key for ${BORG_REPO}\n"
      ${SUDO} ${BORG} key export "${BORG_EXPORT_ARGS[@]}" ${BORG_REPO}
      [ "${allconf}" ] && doall export
      ;;
    extract|restore)
      show_extract
      [ "${allconf}" ] && doall extract
      ;;
    info|information)
      show_info
      [ "${allconf}" ] && doall info
      ;;
    list|show)
      show_list
      [ "${allconf}" ] && doall list
      ;;
    mount)
      prefix="dot"
      [ "${BACK_HOST}" == "." ] || prefix="${BACK_HOST}"
      mount_repo "${prefix}_${BACK_DIR}"
      [ "${allconf}" ] && doall mount
      ;;
    umount|unmount)
      prefix="dot"
      [ "${BACK_HOST}" == "." ] || prefix="${BACK_HOST}"
      unmount_repo "${prefix}_${BACK_DIR}"
      [ "${allconf}" ] && doall unmount
      ;;
    *)
      usage
      ;;
  esac
  exit 0
}

[ "${folderargs}" ] || {
  if [ "${list}" ]; then
    src="/."
  else
    if [[ ${SSH_SUPPORT} == true ]]; then
      printf "\nDirectory argument required to upload or remove folders\n"
      printf "\nCurrent remote storage ${myhost} directory listing:\n"
      ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} ls -la "${myhost}"
    else
      printf "\nSSH commands disabled on ${host}\n"
    fi
    usage
  fi
}
[ "${list}" ] || {
  [ "${remove}" ] || {
    [ "${quota}" ] || {
      [ -d "${folderargs}" ] || {
        printf "\nERROR: $1 does not exist or is not a directory\n"
        usage
      }
    }
  }
}

[ "${src}" ] || src="$(realpath "${folderargs}" | sed -e "s%/$%%")"

if [ "${list}" ]; then
  if [ "${recurse}" ]; then
    if [ "${dryrun}" ]; then
      if [[ ${SSH_SUPPORT} == true ]]; then
        printf "\n${SUDO} ssh %s %s ls -lRa %s\n" "${SSH_ARGS[*]}" "${user}@${host}" "${myhost}${src}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    else
      if [[ ${SSH_SUPPORT} == true ]]; then
        ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} ls -lRa "${myhost}${src}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    fi
  else
    if [ "${dryrun}" ]; then
      if [[ ${SSH_SUPPORT} == true ]]; then
        printf "\n${SUDO} ssh %s %s ls -la %s\n" "${SSH_ARGS[*]}" "${user}@${host}" "${myhost}${src}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    else
      if [[ ${SSH_SUPPORT} == true ]]; then
        ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} ls -la "${myhost}${src}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    fi
  fi
else
  if [ "${remove}" ]; then
    if [ "${dryrun}" ]; then
      if [[ ${SSH_SUPPORT} == true ]]; then
        printf "\n${SUDO} ssh %s %s rm -rf%s %s\n" "${SSH_ARGS[*]}" "${user}@${host}" "${verbose}" "${myhost}${src}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    else
      if [[ ${SSH_SUPPORT} == true ]]; then
        ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} rm -rf${verbose} "${myhost}${src}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    fi
  else
    # Create directory if it does not exist
    top=$(dirname ${myhost}${src})
    if [ "${dryrun}" ]; then
      if [[ ${SSH_SUPPORT} == true ]]; then
        printf "\n${SUDO} ssh %s %s mkdir -p%s %s\n" "${SSH_ARGS[*]}" \
                                                     "${user}@${host}" \
                                                     "${verbose}" \
                                                     "${myhost}"
        printf "\n${SUDO} ssh %s %s mkdir -p%s %s\n" "${SSH_ARGS[*]}" \
                                                     "${user}@${host}" \
                                                     "${verbose}" \
                                                     "${top}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    else
      if [[ ${SSH_SUPPORT} == true ]]; then
        ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} mkdir -p${verbose} ${myhost}
        ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} mkdir -p${verbose} ${top}
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    fi

    # Backup specified directory
    rsync -aHh${dryrun}${verbose} \
      --delete \
      --delete-excluded \
      --exclude='.DS_Store' \
      "${src}/" \
      ${user}@${host}:"${myhost}${src}"
    [ "${dryrun}" ] || {
      if [[ ${SSH_SUPPORT} == true ]]; then
        printf "\nListing of remote storage backup folder ${myhost}${src}:\n"
        ${SUDO} ssh "${SSH_ARGS[@]}" ${user}@${host} ls -a "${myhost}${src}"
      else
        printf "\nSSH commands disabled on ${host}\n"
      fi
    }
  fi
fi
