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
missing="$1-missing.txt"
rm -f ../$missing
touch ../$missing
cd $1
if [ "$1" = "People" ]
then
    while read num
    do
        found=
        for subdir in 0 1 2 3 4 5 6 7 8 9
        do
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
