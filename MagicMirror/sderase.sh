#!/bin/bash

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

diskutil unmountDisk ${DEVICE}
sudo diskutil eraseDisk FAT32 RASPBIAN MBRFormat ${DEVICE}
