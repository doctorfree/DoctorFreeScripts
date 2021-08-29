#!/bin/bash

TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven/Models"

for folder in *
do
    [ -d $folder ] || continue
    cd $folder
    for img in *
    do
        [ -L $img ] && continue
        [ -f $TOP/$folder/$img ] && {
            rm -f $img
            ln -s $TOP/$folder/$img .
        }
    done
    cd ..
done
