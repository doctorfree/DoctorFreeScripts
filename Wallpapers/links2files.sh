#!/bin/bash
#
## @file Wallpapers/links2files.sh
## @brief Repair broken symlinks in broken.txt by removing and redownloading
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi

HERE=`pwd`

download() {
    url="https://wallpapers.wallhaven.cc/wallpapers/full"
    client="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.99 Safari/537.36"
    wget -q -U "$client" $url/$1
}

numbroke=`cat broken.txt | wc -l`
completed=0

printf "\nRepairing broken symbolic links in $HERE\n"
while read broken
do
    completed=`expr $completed + 1`
    progress $numbroke $completed
    target=`basename $broken`
    rm -f "$broken"
    sdir=`dirname $broken`
    cd "$sdir"
    download "$target"
    cd "$HERE"
done < broken.txt
printf "\n"
