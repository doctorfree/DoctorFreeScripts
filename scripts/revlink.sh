#!/bin/bash
#
## @file revlink.sh
## @brief Reverse direction of symbolic links
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

ALL=
HERE=`pwd`

[ "$1" == "-a" ] && ALL=1

find . -type l | while read i
do
    [ -d "$i" ] && {
        echo "$i links to a directory. Skipping."
        continue
    }
    type stat > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        target=`stat -f %Y "$i"`
    else
        target=`ls -l "$i" | awk -F '-> ' ' { print $2 } '`
    fi
    [ "$target" ] || {
        echo "Target for $i is empty. Skipping."
        continue
    }
    [ "$ALL" ] || {
        echo "$target" | grep /Libraries/ > /dev/null || {
            echo "Target for $i is not a Photos library file. Skipping."
            continue
        }
    }
    idir=`dirname "$i"`
    bnam=`basename "$i"`
    cd "$idir"
    [ -d "$target" ] && {
        echo "Target for $i is a directory. Skipping."
        cd "$HERE"
        continue
    }
    [ -L "$target" ] && {
        echo "Target for $i is a symbolic link too. Skipping."
        cd "$HERE"
        continue
    }
    [ -f "$target" ] || {
        echo "Target for $i does not exist or is not a plain file. Skipping."
        cd "$HERE"
        continue
    }
    rm -f "$bnam"
    cp "$target" "$bnam"
    rm -f "$target"
    tardir=`dirname "$target"`
    cd "$tardir"
    j=`echo "$i" | sed -e "s/\.\///"`
    b=`basename "$target"`
    ln -s "${HERE}"/"$j" "$b"
    cd "$HERE"
done
