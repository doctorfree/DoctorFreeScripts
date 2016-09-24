#!/bin/bash
#
# filenumset - convenience script to rename files beginning without a track
#    number to a filename with track number as prefix. For example, the command
#    "filenumset foo.mp3" might rename "foo.mp3" to "5 foo.mp3".

usage() {
    echo "Usage: filenumset <filename> [filename2 ...]"
    echo "Where <filename> is the name of an MP3 file with a track setting"
    exit 1
}

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
