#!/bin/bash
#
# sdbackup - Backup an SD card to an image file
#
# Written February 2020 by Ronald Joe Record <rr at ronrecord dot com>
#

NUMBACK=`date "+%Y%m%d"`
OUT_DIR="/Volumes/Seagate_8TB/Raspberry_Pi/Backups"
OUT_FILE="Raspbian-MagicMirror-${NUMBACK}.iso"
DEVNAM="disk3"
TELL=
ZIP=

usage() {
    echo "Usage: sdbackup [-n] [-o filename] [-z] [-d disk#]"
    exit 1
}

while getopts d:no:uz flag; do
    case $flag in
        d)
            DEVNAM="$OPTARG"
            ;;
        o)
            OUT_FILE="$OPTARG"-${NUMBACK}.iso
            ;;
        n)
            TELL=1
            ;;
        z)
            ZIP=1
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
    echo "Discovered SD card on ${FOUND} does not match specified device ${DEVNAM}"
    echo "Use 'diskutil list' or Disk Utility to verify correct device node"
    echo "Exiting"
    usage
}

[ -d "${OUT_DIR}" ] || mkdir -p "${OUT_DIR}"
cd "${OUT_DIR}"
if [ "${ZIP}" ]
then
    if [ "${TELL}" ]
    then
        echo "sudo dd if=${DEVICE} | zip ${OUT_FILE}.zip -"
    else
        sudo dd if=${DEVICE} | zip ${OUT_FILE}.zip -
    fi
else
    if [ "${TELL}" ]
    then
        echo "sudo dd if=${DEVICE} of=${OUT_FILE}"
    else
        sudo dd if=${DEVICE} of=${OUT_FILE}
    fi
fi
