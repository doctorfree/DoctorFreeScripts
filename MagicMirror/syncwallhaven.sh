#!/bin/bash
#

TOP="/home/pi/Pictures"
FLD="$1"
HST="doctorwhen@10.0.1.51"
SRC="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"

[ "$1" ] || {
    echo "Argument required. Exiting."
    exit 1
}

[ -d $HOME/Pictures/Wallhaven/$1 ] || {
    echo "No Wallhaven directory for $1. Exiting."
    exit 1
}

[ -d $TOP ] || {
    echo "$TOP does not exist or is not a directory. Exiting."
    exit 1
}
cd $TOP
[ -d $FLD ] || mkdir $FLD
rsync -qkaL --delete --max-size=4G $HST:$SRC/$FLD $TOP/
