#!/bin/bash
#
## @file Wallpapers/get-number.sh
## @brief Download Wallhaven wallpaper by number
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

[ "${PICROOT}" ] || PICROOT=/u/pictures

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi
[ "$WHDIR" ] || WHDIR="${PICROOT}/Wallhaven"

if [ "${subdir}" ]
then
    DDIR="${WHDIR}/${subdir}"
else
    DDIR="${WHDIR}/Misc"
fi

[ "$numdown" ] || numdown=480
[ "$categories" ] || categories=001
[ "$filters" ] || filters=001

[ -d "${DDIR}" ] || mkdir -p "${DDIR}"
cd "${DDIR}"

url="https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven"
client="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.99 Safari/537.36"
[ -r wallhaven-$numdown.jpg ] || {
    [ -r wallhaven-$numdown.png ] || {
        wget -q -U "$client" $url-$numdown.jpg
        wget -q -U "$client" $url-$numdown.png
        if [ -r wallhaven-$numdown.jpg ]
        then
            echo "$numdown" >> downloaded.txt
        else
            [ -r wallhaven-$numdown.png ] && {
                echo "$numdown" >> downloaded.txt
            }
        fi
    }
}
