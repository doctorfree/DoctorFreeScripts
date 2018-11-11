#!/bin/bash

FDIRS="Carisha Corinna Dasha_G Dasha_M Jasmine_A"
WDIRS="Alisa_I Carisha Corinna Mila_A Sakimichan Tuigirl Natalia_Andreeva"
XDIRS="Baby Leah_Gotti Sybil"

FMJY="Femjoy"
WHVN="Wallhaven"
XART="X-Art"

[ "$1" == "-f" ] && {
    WHVN=
    XART=
}
[ "$1" == "-w" ] && {
    FMJY=
    XART=
}
[ "$1" == "-x" ] && {
    WHVN=
    FMJY=
}
DIRS="$FMJY $WHVN $XART"
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
            LDIRS="$XDIRS"
        fi
    fi
    for d in $LDIRS 
    do
        [ "../$d" == "../All" ] && continue
        [ "../$d" == "../Favs" ] && continue
        [ "../$d" == "../*" ] && continue
        [ -d ../$d ] || continue
        ln -s ../$d/* .
    done
    cd ../..
done
