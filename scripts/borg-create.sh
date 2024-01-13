#!/bin/bash
#
# Modify 'user' and 'host' with your rsync.net username and hostname
user="<rsync.net username>"
host="<host>.rsync.net"
myhost="$(hostname)"

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
