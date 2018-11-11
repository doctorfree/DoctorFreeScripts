#!/bin/bash

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
    if [ "$dir" == "$FMJY" ]
    then
        flag="f"
    else
        if [ "$dir" == "$WHVN" ]
        then
            flag="w"
        else
            flag="x"
        fi
    fi
    for subdir in *
    do
        [ "$subdir" == "All" ] && continue
        [ "$subdir" == "Favs" ] && continue
        [ "$subdir" == "*" ] && continue
        [ -d $subdir ] || continue
        rm -rf "$subdir"
        saver -$flag -b "$subdir"
    done
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
    ./mkfavs -$flag
done
