#!/bin/bash
#
# Modify 'user' and 'host' with your rsync.net username and hostname
user="<rsync.net username>"
host="<host>.rsync.net"
myhost="$(hostname)"

REPOSITORY=${user}@${host}:${myhost}/backups
export BORG_REMOTE_PATH=/usr/loca/bin/borg1/borg1
export BORG_REPO=ssh://${REPOSITORY}

[ "${BORG_PASSPHRASE}" ] || {
  printf "\nWARNING: No Borg passphrase detected."
  printf "\nExport your passphrase in the environment variable:"
  printf "\n\texport BORG_PASSPHRASE='your-pass-phrase'\n"
}

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# borg create -v --stats                        \
#   $REPOSITORY::'{hostname}-{now:%Y-%m-%d}'    \
#   /home                                       \
#   /var/www                                    \
#   --exclude "${HOME}/.cache"                  \
#   --exclude "${HOME}/Music"                   \
#   --exclude '*.pyc'
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
# borg prune -v \
#   --list $REPOSITORY \
#   --prefix '{hostname}-' \
#   --keep-daily=7 \
#   --keep-weekly=4 \
#   --keep-monthly=6
borg prune                          \
    --list                          \
    --glob-archives '{hostname}-*'  \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6

prune_exit=$?

# actually free repo disk space by compacting segments

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
