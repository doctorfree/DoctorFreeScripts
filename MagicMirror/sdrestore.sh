#!/bin/bash

NUMBACK="00"
INP_DIR="/Volumes/Seagate_8TB/Raspberry_Pi/Backups"
INP_FILE="Raspbian-MagicMirror-${NUMBACK}.iso"
INP="${INP_DIR}/${INP_FILE}"
DEVICE="/dev/rdisk3"

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
