#!/bin/bash
#
# dash2space - convenience script to replace the first occurence of "-"
#    in all MP3 filenames in this directory with " ". For example, this
#    would rename "03-My Song.mp3" to "03 My Song.mp3".

for i in *.mp3
do
    j=`echo $i | sed -e "s/-/ /"`
    [ "$i" = "$j" ] || mv "$i" "$j"
done
