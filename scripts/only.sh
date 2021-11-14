#!/bin/bash
#
## @file only.sh
## @brief Report files/dirs only in one directory hierarchy but not in a second
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 20-Feb-2014
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

[ "${MEDROOT}" ] || MEDROOT=/u
[ "${PICROOT}" ] || PICROOT=/u/pictures
[ "${VIDROOT}" ] || VIDROOT=/u/movies
[ "${AUDROOT}" ] || AUDROOT=/Audio
[ "${PHOROOT}" ] || PHOROOT=/Photos
[ "${ITUROOT}" ] || ITUROOT=/iTunes
[ "${MNTROOT}" ] || {
    USER=`id -u -n`
    MNTROOT=/media/${USER}
}

FIRST="${ITUROOT}/Music"
SECOND="${MNTROOT}/Transcend"

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "\nUsage: only [-Fru] [-f 1st directory] [-l 2nd directory]\n"
    printf "Where:\n\t1st directory is location to locate only-ins\n"
    printf "\t2nd directory is location to compare to\n"
    printf "\t-F indicates report on a file-by-file basis\n"
    printf "\t-r reverses the roles of 1st and 2nd directories\n"
    printf "\t-u displays this usage message\n"
    printf "\nCurrent defaults are:\n\t1st Directory = $FIRST\n"
    printf "\t2nd Directory = $SECOND\n"
    printf "\tReport only-in $TYPE\n"
    exit 1
}

R=
U=
FILES="d"
TYPE="Directories"
while getopts f:l:Fru flag; do
    case $flag in
        f)
            FIRST="$OPTARG";
            ;;
        l)
            SECOND="$OPTARG";
            ;;
        F)
            FILES="f";
            TYPE="Files"
            ;;
        r)
            R=1;
            ;;
        u)
            U=1;
            ;;
    esac
done

[ "$R" ] && {
    TMP="$FIRST"
    FIRST="$SECOND"
    SECOND="$TMP"
}

[ "$U" ] && usage

[ -d "$FIRST" ] || {
    echo "First specified directory: $FIRST"
    echo "does not exist or is not a directory. Exiting."
    usage
}
[ -d "$SECOND" ] || {
    echo "Second specified directory: $SECOND"
    echo "does not exist or is not a directory. Exiting."
    usage
}

cd "$FIRST"

printf "\n$TYPE in $FIRST\n\tbut not in $SECOND :\n"
find . -type $FILES | while read dir
do
    [ -$FILES "$SECOND/$dir" ] || echo "$dir"
done
