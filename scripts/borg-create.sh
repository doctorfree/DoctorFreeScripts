#!/bin/bash
#   _                                                        _
#  | |__    ___   _ __  __ _          ___  _ __  ___   __ _ | |_  ___
#  | '_ \  / _ \ | '__|/ _` | _____  / __|| '__|/ _ \ / _` || __|/ _ \
#  | |_) || (_) || |  | (_| ||_____|| (__ | |  |  __/| (_| || |_|  __/
#  |_.__/  \___/ |_|   \__, |        \___||_|   \___| \__,_| \__|\___|
#                      |___/
#
# Create borg remote backups on rsync.net
# Run nightly as root with a crontab entry like:
# 0 23 * * * /bin/bash -lc '/path/to/borg-create'
#
# Written 2024-01-14 by Ronald Joe Record <ronaldrecord@gmail.com>
# See: https://borgbackup.readthedocs.io/en/stable/index.html
#
# ========================= Customize ==============================
# Modify 'user' and 'host' with your rsync.net username and hostname
user="<rsync.net username>"
host="<host>.rsync.net"
# ======================= End Customize ============================
myhost="$(hostname)"

export BORG_REMOTE_PATH=/usr/loca/bin/borg1/borg1
export BORG_REPO=${user}@${host}:${myhost}/backups

[ "${BORG_PASSPHRASE}" ] || {
  [ -f ${HOME}/.private ] && source ${HOME}/.private
  [ "${BORG_PASSPHRASE}" ] || {
    printf "\nWARNING: No Borg passphrase detected."
    printf "\nExport your passphrase in the environment variable:"
    printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
  }
}

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

borg create                                     \
    --verbose                                   \
    --filter AME                                \
    --list                                      \
    --stats                                     \
    --show-rc                                   \
    --compression lz4                           \
    --exclude-caches                            \
    --exclude '/root/.cache'                    \
    --exclude '/home/*/.cache/*'                \
    --exclude '/home/*/.local/share/Daedalus'   \
    --exclude '/home/*/Music/*'                 \
    --exclude '/var/tmp/*'                      \
    --exclude '/var/cache'                      \
    --exclude '/var/lib/docker/devicemapper'    \
    --exclude '/var/lock/*'                     \
    --exclude '/var/log/*'                      \
    --exclude '/var/run/*'                      \
    --exclude '/var/tmp/*'                      \
    --exclude '/var/backups/*'                  \
    --exclude '/var/spool/*'                    \
    --exclude '*.pyc'                           \
                                                \
    ::'{hostname}-{now}'                        \
    /etc                                        \
    /home                                       \
    /root                                       \
    /var

backup_exit=$?

info "Pruning repository"

borg prune                          \
    --list                          \
    --glob-archives '{hostname}-*'  \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  3

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
