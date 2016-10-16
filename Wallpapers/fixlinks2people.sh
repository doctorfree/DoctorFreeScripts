#!/bin/bash
#
## @file Wallpapers/fixlinks2people.sh
## @brief Repair broken symbolic links to files in  the People subdirs
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
    echo $lsl | grep /People/ > /dev/null && {
        target=`basename $broken`
        found=
        for sub in 0 1 2 3 4 5 6 7 8 9
        do
            [ -f People/$sub/$target ] && {
                [ ! -L People/$sub/$target ] && {
                    newtarget="People/$sub/$target"
                    found=1
                    break
                }
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
