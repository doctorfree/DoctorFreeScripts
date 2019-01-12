#!/bin/bash

TOP="/Volumes/Seagate_BPH_8TB/Pictures/Work"
EB_TOP="${TOP}/Elite_Babes"
JP_TOP="${TOP}/JP_Erotica"
DES="Description.txt"

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
