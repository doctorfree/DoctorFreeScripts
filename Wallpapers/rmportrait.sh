#!/bin/bash
#
## @file Wallpapers/rmportrait.sh
## @brief Remove all image files in current dir whose height is larger than their width
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2018, Ronald Joe Record, all rights reserved.
## @date Written 16-Oct-2018
## @version 1.0.1
##

for i in *.jpg *.png
do
    [ "$i" == "*.jpg" ] && continue
    [ "$i" == "*.png" ] && continue
    GEO=`identify $i | awk ' { print $3 } '`
    W=`echo $GEO | awk -F "x" ' { print $1 } '`
    H=`echo $GEO | awk -F "x" ' { print $2 } '`
    [ $H -gt $W ] && {
        rm -f $i
    }
done
