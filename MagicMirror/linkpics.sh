#!/bin/bash

SLIDES_DIR="$HOME/MagicMirror/modules/MMM-BackgroundSlideshow/pics"

mksym () {
    PDIR="${LNDIR}/$1"
    if [ -d $PDIR ]
    then
        [ -L $2 ] || ln -s $PDIR $2
    else
        echo "$PDIR does not exist or is not a directory. Skipping."
    fi
}

[ -d ${SLIDES_DIR} ] || {
    echo "${SLIDES_DIR} does not exist or is not a directory. Exiting."
    exit 1
}

cd "${SLIDES_DIR}"
LNDIR="../../../../Pictures"

mksym Beach beach
mksym Celebrity celebrity
mksym Choker choker
mksym Czech czech
mksym Fictional_Character fictional
mksym Fractals fractals
mksym Horse horse
mksym Natural_Boobs boobs
mksym Nuts_Magazine nuts
mksym Original_Characters original
mksym Owls owls
mksym River river
mksym Russian russian
mksym Sakimichan sakimichan
mksym Touhou touhou
mksym Tuigirl tuigirl
mksym Ukrainian ukrainian
mksym Waterfall waterfall

[ -d gif ] || mkdir gif
cd gif
LNDIR="../../../../../Pictures"

for i in Nature Portal Smoke
do
    mksym Gif/$i $i
done
