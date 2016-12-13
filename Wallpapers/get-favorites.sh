#!/bin/bash
#
## @file Wallpapers/get-favorites.sh
## @brief Download favorites from Wallhaven
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi
[ "$WHDIR" ] || WHDIR="/Volumes/LaCie_8TB/Pictures/Work/Wallhaven"

DDIR="${WHDIR}/Favorites"

[ "$numdown" ] || numdown=480
[ "$categories" ] || categories=111
[ "$filters" ] || filters=111
[ "$page" ] || page=1

wh -l ${DDIR} \
   -n $numdown \
   -s $page \
   -t favorites \
   -c $categories \
   -f $filters \
   $quiet \
   -p 0

