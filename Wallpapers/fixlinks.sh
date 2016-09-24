#!/bin/bash

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
