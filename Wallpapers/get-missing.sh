#!/bin/bash
#
## @file Wallpapers/get-missing.sh
## @brief Download missing Wallhaven wallpapers by number
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./utils ] && . ./utils
fi
[ -d "$1" ] || {
    echo "$1 not a directory. Exiting."
    exit 1
}
missing="$1-missing.txt"
[ -f "$missing" ] || {
    echo "$missing not a plain file or does not exist. Exiting."
    exit 1
}
numpics=`cat "$missing" | wc -l`
completed=0

download() {
    url="https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven"
    client="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.99 Safari/537.36"
    wget -q -U "$client" $url-$1.jpg
    wget -q -U "$client" $url-$1.png
}

cd $1
if [ "$1" = "People" ]
then
    while read num
    do
        found=
        completed=`expr $completed + 1`
        progress $totalpics $completed
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
        [ "$found" ] || download "$num"
    done < ../"$missing"
else
    while read num
    do
        completed=`expr $completed + 1`
        progress $totalpics $completed
        [ -r wallhaven-$num.jpg ] || {
            [ -r wallhaven-$num.png ] || {
                download "$num"
            }
        }
    done < ../"$missing"
fi
printf "\n"
