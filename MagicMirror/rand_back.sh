#!/bin/bash

PIC_DIR=$HOME/Pictures
BACKG_DIR=${PIC_DIR}/Fractals

[ "$1" == "-n" ] && BACKG_DIR=${PIC_DIR}/Wallhaven/Nature
[ "$1" == "-w" ] && BACKG_DIR=${PIC_DIR}/Wallhaven/Waterfall
[ "$1" == "-f" ] && BACKG_DIR=${PIC_DIR}/Wallhaven/Fractals

[ -d $BACKG_DIR ] || {
    echo "$BACKG_DIR does not exist or is not a directory. Exiting."
    exit 1
}

pm2 stop mm
sleep 5
cd $BACKG_DIR
a=( * )
((j=RANDOM%${#a[@]}))
randf="${a[j]}"
#echo "Using $BACKG_DIR/$randf for background"
DISPLAY=:0 pcmanfm --set-wallpaper="$BACKG_DIR/$randf"
sleep 10
pm2 start mm
