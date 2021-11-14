#!/bin/bash
#
## @file chkrel.sh
## @brief Check for symbolic links that are not relative (begin with ../)
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

find . -type l | while read i
do
    target=`ls -l "$i" | awk ' { print $11 } '`
    rel=`echo $target | awk -F "/" ' { print $1 } '`
    [ "$rel" = ".." ] || {
        echo "$i target not relative: $target"
    }
done
