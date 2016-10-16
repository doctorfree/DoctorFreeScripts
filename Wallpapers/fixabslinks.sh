#!/bin/bash
#
## @file Wallpapers/fixabslinks.sh
## @brief Repair absolute symbolic links listed in absolute.txt
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
# Create a list of symbolic links and a sorted uniq'd list of those symlinks
LINKLIST="${HERE}/absolute.txt"

download() {
    url="https://wallpapers.wallhaven.cc/wallpapers/full"
    client="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.99 Safari/537.36"
    wget -q -U "$client" $url/$1
}

[ -f "${LINKLIST}" ] || {
    printf "\nCreating list of symbolic links ..."
    rm -f "${LINKLIST}"
    touch "${LINKLIST}"
    find . -type l | while read symlink
    do
        ls -l $symlink | grep /Volumes/ > /dev/null && {
            echo $symlink >> "${LINKLIST}"
        }
    done
    printf " done.\n"
}

numlink=`cat ${LINKLIST} | wc -l`
completed=0

printf "\nRepairing Absolute symbolic links in $HERE\n"
while read absolute
do
    completed=`expr $completed + 1`
    progress $numlink $completed
    target=`basename $absolute`
    sdir=`dirname $absolute`
    rm -f "$absolute"
    found=
    for dir in *
    do
        [ -f "$dir"/$target ] && {
            [ ! -L "$dir"/$target ] && {
                found="$dir/$target"
                break
            }
        }
    done
    [ "$found" ] || {
        # Check for a plain file in People and Models subdirectories
        for dir in Models/* People/*
        do
            [ -f "$dir"/$target ] && {
                [ ! -L "$dir"/$target ] && {
                    found="$dir/$target"
                    break
                }
            }
        done
    }
    cd "$sdir"
    [ "$found" ] || {
        # Cannot find a plain file for this, download it again
        download "$target"
        cd "$HERE"
        continue
    }
#   printf "Removing and relinking $absolute to $found\n"
    relative=""
    numdots=0
    while [ $numdots -lt 4 ]
    do
        relative="../$relative"
        [ -f "${relative}${found}" ] && {
            ln -s "${relative}${found}" .
            break
        }
        numdots=`expr $numdots + 1`
        [ $numdots -eq 4 ] && {
            echo "Could not find $found from $sdir"
        }
    done
    cd "$HERE"
done < "${LINKLIST}"
printf "\n"
