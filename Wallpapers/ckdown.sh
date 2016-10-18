#!/bin/bash
#
## @file Wallpapers/ckdown.sh
## @brief Check for missing files listed in downloaded.txt
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

[ -d "$1" ] || {
    echo "$1 not a directory. Exiting."
    exit 1
}

cd $1

missing="$1-missing.txt"
rm -f ../$missing
touch ../$missing
if [ "$1" = "People" ] || [ "$1" = "Models" ] || [ "$1" = "Photographers" ]
then
    while read num
    do
        found=
        for subdir in *
        do
            [ -d "${subdir}" ] || continue
            if [ -r $subdir/wallhaven-$num.jpg ]
            then
                found=1
                break
            else
                if [ -r $subdir/wallhaven-$num.png ]
                then
                    found=1
                    break
                fi
            fi
        done
        [ -r wallhaven-$num.jpg ] && found=1
        [ -r wallhaven-$num.png ] && found=1
        [ "$found" ] || echo "$num" >> ../$missing
    done < downloaded.txt
else
    while read num
    do
        [ -r wallhaven-$num.jpg ] || {
            [ -r wallhaven-$num.png ] || {
                echo "$num" >> ../$missing
            }
        }
    done < downloaded.txt
fi
