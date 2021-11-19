#!/bin/bash

BDIR="$HOME/.config/pcmanfm/LXDE-pi"
FAVS="$HOME/Pictures/Backgrounds"

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
    foundit=
    for favdir in ${FAVS}/*
    do
        [ "${favdir}" == "${FAVS}/*" ] && continue
        [ -f ${favdir}/${IMG} ] && {
            echo "${BG_NAM} already exists in $favdir"
            foundit=1
            break
        }
    done
    [ "${foundit}" ] || echo "${BG_NAM} not in Backgrounds"
done
