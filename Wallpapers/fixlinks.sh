#!/bin/bash
#
## @file Wallpapers/fixlinks.sh
## @brief Repair broken symbolic links listed in broken.txt
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

[ -r ./utils ] && . ./utils

rm -f newbroken.txt
touch newbroken.txt
H=`pwd`
numbroke=`cat broken.txt | wc -l`
completed=0
while read broken
do
    lsl=`ls -l $broken`
    echo $lsl | grep /Anime/ > /dev/null && {
        target=`basename $broken`
        [ -f Misc/$target ] || {
            echo $broken >> newbroken.txt
            completed=`expr $completed + 1`
            progress $numbroke $completed
            continue
        }
        rm -f $broken
        sdir=`dirname $broken`
        cd "$sdir"
        [ -f ../Misc/$target ] && ln -s ../Misc/$target .
        cd "$H"
        completed=`expr $completed + 1`
        progress $numbroke $completed
    }
done < broken.txt
