#!/bin/bash
#
# mntdrive - lists/mounts/unmounts an rclone drive
#            Usage: mntdrive [-ahlLu] [-d drive-name]
#                            [-m /path/to/mount/point] [-M /path/to/mount]
#            Defaults: '/mnt/gdrive' mount point, 'gdrive:' drive name
#
# The default desired mount point directory
# Use '-M /path/to/mount' to specify an alternate mount directory
MNT="/mnt"
# The default desired mount point, directory will be created if it doesn't exist
# Use '-m /path/to/mount/point' to specify an alternate mount point
MNTPT="${MNT}/gdrive"
# The default name of the rclone drive to mount
# Use '-d drive-name' to specify an alternate rclone drive name
DRIVE="gdrive:"

usage() {
  printf "\nUsage: mntdrive [-ahlLu] [-d drive-name]"
  printf "\n                [-m /path/to/mount/point] [-M /path/to/mount]"
  printf "\nWhere:"
  printf "\n\t-a indicates mount/unmount all configured rclone remotes"
  printf "\n\t   mount points will be in ${MNT} named after the remote name"
  printf "\n\t-d drive-name specifies the rclone drive to mount (default: ${DRIVE})"
  printf "\n\t-l lists configured rclone remotes by name and type then exits"
  printf "\n\t-L lists configured rclone remotes with info about each if available"
  printf "\n\t   if combined with '-d drive-name' only display info for that remote"
  printf "\n\t-m /path/to/mount/point specifies the mount point (default: ${MNTPT})"
  printf "\n\t-M /path/to/mount specifies the mount directory (default: ${MNT})"
  printf "\n\t-u indicates unmount the specified drive, all if combined with -a"
  printf "\n\t-h displays this usage message and exits\n"
  printf "\nExamples:"
  printf "\n\tMount a Google Photos rclone drive named 'gphoto' on /mnt/gphotos"
  printf "\n\t\tmntdrive -d gphoto -m /mnt/gphotos"
  printf "\n\tMount a Google Drive rclone drive named 'gdrive' on /mnt/google"
  printf "\n\t\tmntdrive -d gdrive -m /mnt/google"
  printf "\n\tMount all configured rclone remotes in ${HOME}/rclone"
  printf "\n\t\tmntdrive -a -M ${HOME}/rclone"
  printf "\n\tUnmount all mounted rclone remotes"
  printf "\n\t\tmntdrive -a -u"
  printf "\n\tList all configured rclone remotes with info on each if available"
  printf "\n\t\tmntdrive -L\n"
  exit 1
}

mount_rclone() {
  drive="$1"
  mntpt="$2"
  [ -d ${mntpt} ] || mkdir -p ${mntpt} 2>/dev/null
  [ -d ${mntpt} ] || {
    sudo mkdir -p ${mntpt}
    sudo chown $(id -un):$(id -gn) ${mntpt}
  }
  rclone mount ${drive}/ ${mntpt} --daemon
}

unmount=
darg=
list=
info=
all=
while getopts ":ad:hlLm:M:u" flag; do
  case $flag in
    a)
      all=1
      ;;
    u)
      unmount=1
      ;;
    d)
      DRIVE="$OPTARG"
      echo "${DRIVE}" | grep :$ > /dev/null || {
        DRIVE="${DRIVE}:"
      }
      darg=1
      ;;
    l)
      list=1
      ;;
    L)
      list=1
      info=1
      ;;
    m)
      MNTPT="$OPTARG"
      ;;
    M)
      MNT="$OPTARG"
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

[ "${list}" ] && {
  if [ "${info}" ]; then
    if [ "${darg}" ]; then
      rclone listremotes | grep ${DRIVE} > /dev/null || {
        printf "\nNo configured rclone remote named ${DRIVE}\n"
        exit 1
      }
      printf "\nInfo for rclone remote ${DRIVE}"
      printf "\n------------------------------\n"
      rclone about ${DRIVE} 2>/dev/null || {
        type=$(rclone listremotes --long | grep ^${DRIVE} | awk -F ':' '{ print $2 }')
        printf "The rclone${type} backend does not support 'about'\n"
      }
      MNTPT=$(mount | grep fuse.rclone | grep ${DRIVE} | awk '{ print $3 }')
      if [ "${MNTPT}" ]; then
        printf "Mounted on ${MNTPT}\n"
      else
        printf "Not mounted\n"
      fi
    else
      printf "\nConfigured rclone remotes:\n"
      printf "\nName:   Type"
      printf "\n-----   ----\n"
      rclone listremotes --long
      printf "\n==============================\n"
      rclone listremotes | while read remote
      do
        printf "\nInfo for rclone remote ${remote}"
        printf "\n------------------------------\n"
        rclone about ${remote} 2>/dev/null || {
          type=$(rclone listremotes --long | grep ^${remote} | awk -F ':' '{ print $2 }')
          printf "The rclone${type} backend does not support 'about'\n"
        }
        MNTPT=$(mount | grep fuse.rclone | grep ${remote} | awk '{ print $3 }')
        if [ "${MNTPT}" ]; then
          printf "Mounted on ${MNTPT}\n"
        else
          printf "Not mounted\n"
        fi
      done
      printf "\n"
    fi
  else
    printf "\nConfigured rclone remotes:\n"
    printf "\nName:   Type"
    printf "\n-----   ----\n"
    rclone listremotes --long
  fi
  exit 0
}

if [ "${unmount}" ]; then
  if [ "${all}" ]; then
    mount | grep fuse.rclone | while read entry
    do
      [ "${entry}" ] || continue
      MNTPT=$(echo ${entry} | awk '{ print $3 }')
      [ -d ${MNTPT} ] && fusermount -u ${MNTPT}
    done
  else
    [ -d ${MNTPT} ] && fusermount -u ${MNTPT}
  fi
else
  if [ "${all}" ]; then
    rclone listremotes | while read DRIVE
    do
      MNTPT=$(echo ${DRIVE} | sed -e "s/:$//")
      mount_rclone ${DRIVE} ${MNT}/${MNTPT}
    done
  else
    rclone listremotes | grep ${DRIVE} > /dev/null || {
      printf "\nNo configured rclone remote named ${DRIVE}\n"
      exit 1
    }
    mount_rclone ${DRIVE} ${MNTPT}
  fi
fi
