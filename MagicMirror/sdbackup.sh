#!/bin/bash

NUMBACK=`date "+%Y%m%d"`
OUT_DIR="/Volumes/Seagate_8TB/Raspberry_Pi/Backups"
OUT_FILE="Raspbian-MagicMirror-${NUMBACK}.iso"
DEVNAM="disk5"
[ "$1" ] && DEVNAM="$1"
DEVICE="/dev/r${DEVNAM}"

FOUND=`diskutil list | grep Windows_FAT_32 | awk ' { print $6 } ' | cut -c 1-5`

[ "${FOUND}" == "${DEVNAM}" ] || {
    echo "Discovered SD card on ${FOUND} does not match configured device ${DEVNAM}"
    echo "Use 'diskutil list' or Disk Utility to verify correct device node"
    echo "Exiting"
    exit 1
}

sudo dd if=${DEVICE} | gzip -9 > ${OUT_DIR}/${OUT_FILE}.gz
