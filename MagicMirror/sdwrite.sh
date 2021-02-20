#!/bin/bash
#
# sdwrite - write an image to an SD card
#
# Written February 2020 by Ronald Joe Record <rr at ronrecord dot com>
#
# Change this to be the target device on which the SD card is mounted
# or use the "-d disk" option to specify the desired target device
DEVNAM="disk2"

INP_DIR="/Volumes/Seagate_8TB/Raspberry_Pi"
INP_IMG=

usage() {
    echo "Usage: sdwrite [-n] [-i filename] [-d disk#]"
    exit 1
}

while getopts d:ni:u flag; do
    case $flag in
        d)
            DEVNAM="$OPTARG"
            ;;
        i)
            INP_IMG="$OPTARG"
            ;;
        n)
            TELL=1
            ;;
        u)
            usage
            ;;
        *)
            echo "Unrecognized argument: $flag"
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$INP_IMG" ] || {
    echo "Input file name required. Use -i filename command argument. Exiting."
    usage
}
INP="${INP_DIR}/${INP_IMG}"
DEVICE="/dev/r${DEVNAM}"

FOUND=`diskutil list | grep _FAT_32 | awk ' { print $6 } ' | cut -c 1-5`

[ "${FOUND}" == "${DEVNAM}" ] || {
    echo "Discovered SD card on /dev/${FOUND} does not match specified device ${DEVNAM}"
    echo "Use 'diskutil list' or Disk Utility to verify correct device node"
    echo "Exiting"
    usage
}

if [ -f ${INP} ]
then
    # We found an uncompressed ISO image
    if [ "${TELL}" ]
    then
        echo "diskutil unmountDisk ${DEVICE}"
        echo "sudo diskutil eraseDisk FAT32 ${BACK_NAM} MBRFormat ${DEVICE}"
        echo "diskutil unmountDisk ${DEVICE}"
        echo "sudo dd if=${INP} of=${DEVICE} bs=1M"
    else
        diskutil unmountDisk ${DEVICE}
        sudo diskutil eraseDisk FAT32 ${BACK_NAM} MBRFormat ${DEVICE}
        diskutil unmountDisk ${DEVICE}
        printf "\nWriting ${INP_IMG} on ${DEVICE} ... "
        sudo dd if=${INP} of=${DEVICE} bs=1M
        printf "\nDone\n"
    fi
else
    if [ -f ${INP}.gz ]
    then
    # We found a gzip compressed ISO image
        if [ "${TELL}" ]
        then
            echo "diskutil unmountDisk ${DEVICE}"
            echo "sudo diskutil eraseDisk FAT32 ${BACK_NAM} MBRFormat ${DEVICE}"
            echo "diskutil unmountDisk ${DEVICE}"
            echo "sudo gzcat ${INP}.gz | dd of=${DEVICE} bs=1M"
        else
            diskutil unmountDisk ${DEVICE}
            sudo diskutil eraseDisk FAT32 ${BACK_NAM} MBRFormat ${DEVICE}
            diskutil unmountDisk ${DEVICE}
            printf "\nWriting ${INP_IMG}.gz on ${DEVICE} ... "
            sudo gzcat ${INP}.gz | dd of=${DEVICE} bs=1M
            printf "\nDone\n"
        fi
    else
        if [ -f ${INP}.zip ]
        then
        # We found a zip compressed ISO image
            if [ "${TELL}" ]
            then
                echo "diskutil unmountDisk ${DEVICE}"
                echo "sudo diskutil eraseDisk FAT32 ${BACK_NAM} MBRFormat ${DEVICE}"
                echo "diskutil unmountDisk ${DEVICE}"
                echo "sudo zcat ${INP}.zip | dd of=${DEVICE} bs=1M"
            else
                diskutil unmountDisk ${DEVICE}
                sudo diskutil eraseDisk FAT32 ${BACK_NAM} MBRFormat ${DEVICE}
                diskutil unmountDisk ${DEVICE}
                printf "\nWriting ${INP_IMG}.zip on ${DEVICE} ... "
                sudo zcat ${INP}.zip | dd of=${DEVICE} bs=1M
                printf "\nDone\n"
            fi
        else
            printf "\nCould not locate SD card image\n\t${INP_IMG},"
            printf "\n\t${INP_IMG}.zip,"
            printf "\nor\n\t${INP_IMG}.gz"
            printf "\nin directory\n\t${INP_DIR}"
            printf "\n\nExiting.\n\n"
            usage
        fi
    fi
fi
