#!/bin/bash
#
## @file findabslinks.sh
## @brief Find absolute symbolic links
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

#
HERE=`pwd`
LINKLIST="${HERE}/absolute.txt"
rm -f "${LINKLIST}"
touch "${LINKLIST}"
find . -type l | while read symlink
do
    firstch=`ls -l "$symlink" | awk ' { print $11 } ' | head -c 1`
    [ "$firstch" = "/" ] && {
        echo $symlink >> "${LINKLIST}"
    }
done
