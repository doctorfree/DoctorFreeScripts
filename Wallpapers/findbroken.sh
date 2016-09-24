#!/bin/bash
#
## @file findbroken.sh
## @brief Find and save a list of broken symbolic links in current directory
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

rm -f broken.txt
touch broken.txt
find . -type l | while read i
do
    ls -lL "$i" > /dev/null 2>&1
    [ $? -eq 0 ] || {
        printf "\nBroken symbolic link: $i"
        echo "$i" >> broken.txt
    }
done
