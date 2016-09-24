#!/bin/bash
#
## @file clndl.sh
## @brief Move and rename recently downloaded versions of files
## @remark Use filename without the (#) in the name
## @remark Relies on the Mac OS X convention of inserting (#) in the name of newer version filenames
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @version 1.0.1
##
## If you had files in the $DL directory named:
##     foo.txt, foo(1).txt, and foo(2).txt
## running clndl would move foo(2).txt to foo.txt and remove foo(1).txt
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
# The directory where you want to remove older versions of the files
DL=$HOME/Downloads
USE_CWD=
TELL=
VERB=

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "Usage: clndl [-c] [-d directory] [-n] [-u] [-v]\n"
    printf "Where:\n\t-c indicates use current working directory\n"
    printf "\t-d directory indicates use specified directory\n"
    printf "\t-n indicates tell me what you would do but don't do it\n"
    printf "\t-v indicates tell me what you are doing as you do it\n"
    printf "\t-u displays this usage message\n\n"
    exit 1
}

while getopts d:cnuv flag; do
    case $flag in
        c)
            USE_CWD=1
            DL="."
            ;;
        d)
            DL=$OPTARG
            ;;
        n)
            TELL=1
            VERB=1
            ;;
        v)
            VERB=1
            ;;
        u)
            usage
            ;;
    esac
done

[ -d "$DL" ] || {
    echo "$DL does not exist or is not a directory. Exiting."
    exit 1
}

cd "$DL"
for i in 9 8 7 6 5 4 3 2 1
do
    FILES=`echo *\($i\)*`
    [ "$FILES" = "*("$i")*" ] && continue
    ls -1 *\($i\)* | while read f
    do
        new=`echo "$f" | sed -e "s/($i)//"`
        [ "$VERB" ] && echo "mv $f $new"
        [ "$TELL" ] || mv "$f" "$new"
        # Remove all intermediate versions with this filename
        j=`expr $i - 1`
        while [ $j -gt 0 ]
        do
            old=`echo "$f" | sed -e "s/($i)/($j)/"`
            [ "$VERB" ] && echo "rm -f $old"
            [ "$TELL" ] || rm -f "$old"
            j=`expr $j - 1`
        done
    done
done
