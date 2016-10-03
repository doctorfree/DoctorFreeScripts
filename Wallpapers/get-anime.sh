#!/bin/bash
#
## @file Wallpapers/get-anime.sh
## @brief Download Wallhaven Anime wallpapers
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
[ "$WHDIR" ] || WHDIR="/Volumes/My_Book_Studio/Pictures/Work/Wallhaven"

DDIR="${WHDIR}/Anime"

[ "$numdown" ] || numdown=480
[ "$categories" ] || categories=010
[ "$filters" ] || filters=001

[ -d "${DDIR}" ] || mkdir -p "${DDIR}"
cd "${DDIR}"
[ "$page" ] || {
    pics=`echo *.jpg`
    numpics=0
    pngs=`echo *.png`
    numpngs=0
    [ "$pics" = "*.jpg" ] || {
        numpics=`ls -1 *.jpg | wc -l`
    }
    [ "$pngs" = "*.png" ] || {
        numpngs=`ls -1 *.png | wc -l`
    }
    totpics=`expr $numpics + $numpngs`
    numpage=`expr $totpics / 24`
    page=`expr $numpage + 1`
}

wh -l "${DDIR}" \
   -n $numdown \
   -s $page \
   -c $categories \
   -f $filters \
   -t standard \
   -p 0

