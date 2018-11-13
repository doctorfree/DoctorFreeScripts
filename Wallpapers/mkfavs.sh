#!/bin/bash

BDIR="$HOME/Pictures/Backgrounds"

FDIRS="Carisha Corinna Dasha_G Dasha_M Jasmine_A Kacie Kalinka Niemira"
SDIRS="Album_Covers Fractals Space Dragonflies"
WDIRS="Alisa_I Carisha Corinna Mila_A Sakimichan Sybil_A Tuigirl Natalia_Andreeva"
XDIRS="Anneli Baby Leah_Gotti Sybil Tiffany"

FMJY="Femjoy"
SAFE="Safe"
WHVN="Wallhaven"
XART="X-Art"

[ "$1" == "-f" ] && {
    SAFE=
    WHVN=
    XART=
}
[ "$1" == "-s" ] && {
    FMJY=
    WHVN=
    XART=
}
[ "$1" == "-w" ] && {
    SAFE=
    FMJY=
    XART=
}
[ "$1" == "-x" ] && {
    SAFE=
    WHVN=
    FMJY=
}

[ -d $BDIR ] || {
    echo "$BDIR does not exist or is not a directory. Exiting."
    exit 1
}
cd $BDIR

DIRS="$FMJY $SAFE $WHVN $XART"
for dir in $DIRS
do
    [ -d $dir ] || {
        echo "$dir does not exist or is not a directory. Skipping."
        continue
    }
    cd $dir
    [ -d Favs ] || mkdir Favs
    cd Favs
    rm -f *

    if [ "$dir" == "$FMJY" ]
    then
        LDIRS="$FDIRS"
    else
        if [ "$dir" == "$WHVN" ]
        then
            LDIRS="$WDIRS"
        else
            if [ "$dir" == "$SAFE" ]
            then
                LDIRS="$SDIRS"
            else
                LDIRS="$XDIRS"
            fi
        fi
    fi
    for d in $LDIRS 
    do
        [ "../$d" == "../All" ] && continue
        [ "../$d" == "../Favs" ] && continue
        [ "../$d" == "../*" ] && continue
        [ -d ../"$d" ] || continue
        for pic in ../"$d"/*
        do
            link=`basename "$pic"`
            [ -L "$link" ] && continue
            ln -s "$pic" .
        done
    done
    cd ../..
done
