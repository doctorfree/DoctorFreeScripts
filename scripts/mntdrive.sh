#!/bin/bash
#
# mntdrive - mounts/unmounts an rclone drive
#            Usage: mntdrive [-u] [-m /path/to/mount/point] [-d drive-name]
#            Defaults: '/mnt/drive' mount point, 'gdrive' drive name
#
# Modify the following two default settings accordingly:
#
# The desired mount point, directory will be created if it does not exist
MNTPT="/mnt/drive"
# The name of the rclone drive to mount
DRIVE="gdrive"

usage() {
  printf "\nUsage: mntdrive [-u] [-d drive-name] [-m /path/to/mount/point]"
  printf "\nWhere:"
  printf "\n\t-d drive-name specifies the rclone drive to mount (default: gdrive)"
  printf "\n\t-m /path/to/mount specifies the mount point (default: /mnt/drive)"
  printf "\n\t-u indicates unmount the specified drive"
  printf "\n\t-h displays this usage message and exits\n"
  exit 1
}

unmount=
while getopts ":d:hm:u" flag; do
  case $flag in
    u)
      unmount=1
      ;;
    d)
      DRIVE="$OPTARG"
      ;;
    m)
      MNTPT="$OPTARG"
      ;;
    h)
      usage
      ;;
    \?)
      echo "Invalid option: $flag"
      usage
      ;;
  esac
done
shift $(( OPTIND - 1 ))

if [ "${unmount}" ]; then
  fusermount -u ${MNTPT}
else
  [ -d ${MNTPT} ] || mkdir -p ${MNTPT}
  rclone mount ${DRIVE}:/ ${MNTPT} --daemon
fi
