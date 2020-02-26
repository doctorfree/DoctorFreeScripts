#!/bin/bash

NUMBACK="00"
INP_DIR="/Volumes/Seagate_8TB/Raspberry_Pi/Backups"
INP_FILE="Raspbian-MagicMirror-${NUMBACK}.iso"
INP="${INP_DIR}/${INP_FILE}"
DEVNAM="disk3"
DEVICE="/dev/r${DEVNAM}"

FOUND=`diskutil list | grep Windows_FAT_32 | awk ' { print $6 } ' | cut -c 1-5`

[ "${FOUND}" == "${DEVNAM}" ] || {
    echo "Discovered SD card on ${FOUND} does not match configured device ${DEVNAM}"
    echo "Use 'diskutil list' or Disk Utility to verify correct device node"
    echo "Exiting"
    exit 1
}

diskutil unmountDisk ${DEVICE}
#sudo newfs_msdos -F 16 ${DEVICE}
sudo diskutil eraseDisk FAT32 RASPBIAN MBRFormat ${DEVICE}

if [ -f ${INP} ]
then
    # We found an uncompressed ISO image
    sudo dd if=${INP} of=${DEVICE}
else
    if [ -f ${INP}.gz ]
    then
        # We found a compressed ISO image
        sudo gzcat ${INP}.gz | dd of=${DEVICE}
    else
        echo "Could not locate SD card image ${INP} or ${INP}.gz"
        echo "Exiting"
        exit 1
    fi
fi
