#!/bin/bash

BDIR="$HOME/.config/pcmanfm/lubuntu"
FAVS="$HOME/Pictures/Backgrounds/Favs"

[ -d "$BDIR" ] || {
    echo "$BDIR does not exist or is not a directory. Exiting."
    exit 1
}

cd "$BDIR"
for i in desktop-items*.conf
do
    BGPATH=`grep wallpaper= $i`
    echo "$BGPATH"
    BG=`echo $BGPATH | awk -F "=" ' { print $2 } '`
    BG_NAM=`basename ${BG}`
    IMG=`basename ${BG_NAM}`
    if [ -L ${FAVS}/${IMG} ]
    then
        echo "Symbolic link for ${BG_NAM} already exists."
    else
        echo "${BG_NAM} not in Favs"
    fi
done
