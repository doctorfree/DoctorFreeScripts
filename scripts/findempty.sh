#!/bin/bash
#
## @file findempty.sh
## @brief Find and report empty directories. Optionally, remove them.
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 12-May-2014
## @version 1.0.1
##
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

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    echo "Usage: findempty [-n] [-r] [-u] [directory1 directory2 ...]"
    echo ""
    echo "Where -r indicates remove empty directories."
    echo "      -n indicates tell me what you would do without doing it."
    echo "      -u displays this usage message and exits."
    echo "      directory1 directory2 ... is the list of directories to search"
    echo ""
    echo "Default is to list not remove and use the current working directory."
    echo ""
    exit 1
}

REMOVE=
TELL=
while getopts nru flag; do
    case $flag in
        n)
            TELL=1
            ;;
        r)
            REMOVE="Removing"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

if [ $# -eq 0 ]
then
    DIRS="."
else
    DIRS="$@"
fi

for DIR in $DIRS
do
    [ -d "$DIR" ] || {
        echo "$DIR is not a directory or does not exist. Skipping."
        continue
    }
    [ "$TELL" ] && echo "Looking for empty directories in $DIR"
    find "$DIR" -type d | while read d
    do
        NUM=`ls -1a "$d" | grep -v .DS_Store | wc -l`
        [ $NUM -eq 2 ] && {
            echo $REMOVE $d
            [ "$REMOVE" ] && {
                if [ "$TELL" ]
                then
                    echo "rm -f $d/.DS_Store"
                    echo "rmdir $d"
                else
                    rm -f "$d"/.DS_Store
                    rmdir "$d"
                fi
            }
        }
    done 
done
