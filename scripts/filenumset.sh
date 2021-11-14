#!/bin/bash
#
## @file filenumset.sh
## @brief Convenience script to rename files beginning without a track
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @version 1.0.1
##
## The filenumset script renames files beginning without a track
## number to a filename with track number as prefix. For example, the command
## "filenumset foo.mp3" might rename "foo.mp3" to "5 foo.mp3".

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    echo "Usage: filenumset <filename> [filename2 ...]"
    echo "Where <filename> is the name of an MP3 file with a track setting"
    exit 1
}

## @fn is_all_digits()
## @brief Returns false if any of the characters in the argument is not a digit
## @param param1 string to check for digits
is_all_digits() {
    case $1 in *[!0-9]*) false;; esac
}

for MP3 in "$@"
do
    NUM=`id3info "$MP3" | grep TRCK | awk ' { print $7 } '`
    [ ${#NUM} -eq 1 ] && NUM="0$NUM"
    is_all_digits "$NUM" || usage
    CUR="${MP3:0:2}"
    [ "${CUR}" = "${NUM}" ] && {
        echo "$MP3 already begins with its track number"
        continue
    }
    mv "$MP3" "$NUM $MP3"
done
