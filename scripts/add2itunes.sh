#!/bin/bash
#
## @file add2itunes.sh
## @brief Add the media files provided as arguments to the Apple Music library
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 8-Mar-2014
## @version 1.0.1
##
## @remark Uses osascript to embed AppleScript in a Bash shell script
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.
#

HERE=`pwd`
for i in "$@"
do
    if [ -f "$i" ]
    then
        # Construct full pathname of file
        dnam=`dirname "$i"`
        cd "$dnam"
        pathname=`pwd`
        j="$pathname"/`basename "$i"`
        cd "$HERE"
        echo "Adding file $i to Apple Music"
        osascript -e "tell application \"Music\" to add POSIX file \"$j\""
    fi
done
