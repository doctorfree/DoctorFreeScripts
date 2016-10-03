#!/bin/bash
#
## @file Wallpapers/fixlinks2models.sh
## @brief Repair broken symbolic links to files in  the Models subdirs
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

rm -f newbroken.txt
touch newbroken.txt
H=`pwd`
numbroke=`cat broken.txt | wc -l`
completed=0
while read broken
do
    completed=`expr $completed + 1`
    progress $numbroke $completed
    lsl=`ls -l $broken`
    echo $lsl | grep /Models/ > /dev/null && {
        target=`basename $broken`
        found=
        for sub in Models/*
        do
            [ -f $sub/$target ] && {
                newtarget="$sub/$target"
                found=1
                break
            }
        done
        [ "$found" ] || {
            echo $broken >> newbroken.txt
            continue
        }
        sdir=`dirname $broken`
        cd "$sdir"
        [ -f ../$newtarget ] && {
            rm -f $target
            ln -s ../$newtarget .
        }
        cd "$H"
    }
done < broken.txt
printf "\n"
