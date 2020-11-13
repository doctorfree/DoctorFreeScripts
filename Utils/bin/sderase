#!/bin/bash
#
# sderase - Erase an SD card
#
# Written February 2020 by Ronald Joe Record <rr at ronrecord dot com>
#

DEVNAM="disk3"
TELL=

usage() {
    echo "Usage: sderase [-n] [-d disk#]"
    exit 1
}

while getopts d:nu flag; do
    case $flag in
        d)
            DEVNAM="$OPTARG"
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
DEVICE="/dev/r${DEVNAM}"

FOUND=`diskutil list | grep Windows_FAT_32 | awk ' { print $6 } ' | cut -c 1-5`

[ "${FOUND}" == "${DEVNAM}" ] || {
    echo "Discovered SD card on /dev/${FOUND} does not match specified device ${DEVNAM}"
    echo "Use 'diskutil list' or Disk Utility to verify correct device node"
    echo "Exiting"
    usage
}

if [ "${TELL}" ]
then
    echo "diskutil unmountDisk ${DEVICE}"
    echo "sudo diskutil eraseDisk FAT32 RASPBIAN MBRFormat ${DEVICE}"
else
    diskutil unmountDisk ${DEVICE}
    sudo diskutil eraseDisk FAT32 RASPBIAN MBRFormat ${DEVICE}
fi
