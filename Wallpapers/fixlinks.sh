#!/bin/bash
#
## @file Wallpapers/fixlinks.sh
## @brief Repair broken symbolic links listed in broken.txt
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
WALL=`basename "$HERE"`
# Create a list of symbolic links and a sorted uniq'd list of those symlinks
LINKLIST="${HERE}/linklist.txt"
SORTLINK="${HERE}/sortlink.txt"
NEWLINKS="${HERE}/newbroken.txt"
rm -f "${NEWLINKS}"
touch "${NEWLINKS}"

[ -f "${LINKLIST}" ] || {
    printf "\nCreating list of symbolic links ..."
    find . -type l -name wallhaven-\* > ${LINKLIST}
    printf " done.\n"
}
numlink=`cat ${LINKLIST} | wc -l`

mksortlink() {
    printf "\nCreating sorted uniq list of symbolic links ...\n"
    rm -f /tmp/links$$
    touch /tmp/links$$
    completed=0
    cat ${LINKLIST} | while read wallpath
    do
        filename=`basename "$wallpath"`
        echo "$filename" >> /tmp/links$$
        completed=`expr $completed + 1`
        progress $numlink $completed
    done
    printf "\n"
    prevperc=
    cat /tmp/links$$ | sort | uniq > ${SORTLINK}
    rm -f /tmp/links$$
    printf " done.\n"
}

[ -f "${SORTLINK}" ] || mksortlink

numbroke=`cat broken.txt | wc -l`
completed=0

printf "\nRepairing broken symbolic links in $HERE\n"
while read broken
do
    completed=`expr $completed + 1`
    progress $numbroke $completed
    target=`basename $broken`
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
        # Check for a plain file in People, Photographers, and Models subdirs
        for dir in Models/* People/* Photographers/*
        do
            [ -f "$dir"/$target ] && {
                [ ! -L "$dir"/$target ] && {
                    found="$dir/$target"
                    break
                }
            }
        done
    }
    [ "$found" ] || {
        echo $broken >> "${NEWLINKS}"
        continue
    }
#   printf "Removing and relinking $broken to $found\n"
    rm -f "$broken"
    sdir=`dirname $broken`
    cd "$sdir"
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
done < broken.txt
printf "\n"
