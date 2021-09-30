#!/bin/bash

#TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven/Models"
TOP="../../Wallhaven"
ART="${TOP}/Artists"
MOD="${TOP}/Models"
PHO="${TOP}/Photographers"
PLA="${MOD}/Playboy"
PEN="${MOD}/Penthouse"
DRO="${MOD}/Photodromm"
KND="../../KindGirls"

for folder in *
do
    [ -d $folder ] || continue
    cd $folder
    for img in *
    do
        [ -L $img ] && continue
        for subdir in ${TOP} ${ART} ${MOD} ${PHO} ${PLA} ${PEN} ${DRO} ${KND}
        do
            [ -f $subdir/$folder/$img ] && {
                rm -f $img
                ln -s $TOP/$folder/$img .
                break
            }
        done
    done
    cd ..
done
