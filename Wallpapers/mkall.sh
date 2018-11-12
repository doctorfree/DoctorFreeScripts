#!/bin/bash

BDIR="$HOME/Pictures/Backgrounds"

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
    [ -d All ] || mkdir All
    cd All
    rm -f *
    for d in ../*
    do
        [ "$d" == "../All" ] && continue
        [ "$d" == "../Favs" ] && continue
        [ "$d" == "../*" ] && continue
        [ -d $d ] || continue
        ln -s $d/* .
    done
    cd ../..
done
