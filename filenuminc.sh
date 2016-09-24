#!/bin/bash
#
# filenuminc - convenience script to rename files beginning with a track number
#    after increasing the number by some previously ripped number of tracks.
#    For example, the command "filenuminc 11" would rename "04 My Song.mp3"
#    to "15 My Song.mp3".

usage() {
    echo "Usage: filenuminc <number>"
    echo "Where <number> is a two digit number between 01 and 99"
    exit 1
}

is_all_digits() {
    case $1 in *[!0-9]*) false;; esac
}

[ "$1" ] || usage

INC=$1

is_all_digits $INC || usage

for i in *.mp3
do
    [ "$i" = "*.mp3" ] && continue
    num="${i:0:2}"
    newnum=`expr $num + $INC`
    j=`echo $i | sed -e "s/$num/$newnum/"`
    [ "$i" = "$j" ] || mv "$i" "$j"
done
