#!/bin/bash

TOP="/Volumes/Seagate_8TB/Pictures/Work"
OTOP="/u/pictures/Work"
NTOP="/mac/pictures/Work"
DES="Description.txt"

# Which system are we on?
[ -d "${TOP}" ] || {
    if [ -d "${NTOP}" ]
    then
        TOP="${NTOP}"
    else
        if [ -d "${OTOP}" ]
        then
            TOP="${OTOP}"
        else
            echo "Cannot determine top-level photo dir. Exiting."
            exit 1
        fi
    fi
}

EB_TOP="${TOP}/Elite_Babes"
JP_TOP="${TOP}/JP_Erotica"

for model in "${EB_TOP}"/* "${JP_TOP}"/*
do
    [ "$model" == "${EB_TOP}/*" ] && continue
    [ "$model" == "${JP_TOP}/*" ] && continue
    [ -d "$model" ] || continue
    [ -f "$model"/"$DES" ] || {
        MOD=`basename $model`
        VIT=
        for TODO in ${TOP}/*/todo
        do
            [ "$TODO" == "${TOP}/*/todo" ] && continue
            grep $MOD $TODO > /dev/null && VIT=$TODO
        done
        if [ "$VIT" ]
        then
            vi "$model"/"$DES" "$VIT"
        else
            vi "$model"/"$DES"
        fi
    }
done
