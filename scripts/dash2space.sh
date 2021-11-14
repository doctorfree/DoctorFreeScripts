#!/bin/bash
#
## @file dash2space.sh
## @brief Convenience script to replace the first occurence of "-" with " "
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @version 1.0.1
##
## The dash2space script will replace the first occurence of "-" with " "
## in all MP3 filenames in this directory with " ". For example, this
## would rename "03-My Song.mp3" to "03 My Song.mp3".

for i in *.mp3
do
    j=`echo $i | sed -e "s/-/ /"`
    [ "$i" = "$j" ] || mv "$i" "$j"
done
