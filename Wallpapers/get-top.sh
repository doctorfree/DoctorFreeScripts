#!/bin/bash
#
## @file Wallpapers/get-top.sh
## @brief Download top 100 large photos from Wallhaven
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2018, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2018
## @version 1.0.1
##

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi
[ "$WHDIR" ] || WHDIR="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven"

DDIR="${WHDIR}/Top"

[ -d "${DDIR}" ] || mkdir -p "${DDIR}"
cd "${DDIR}"

[ "$numdown" ] || numdown=480
[ "$categories" ] || categories=001
[ "$filters" ] || filters=001

## Try to set a reasonable start page if one has not been specified by
## counting the number of previously downloaded images and divide by 24
[ "$page" ] || {
    pics=`echo *.jpg`
    numpics=0
    pngs=`echo *.png`
    numpngs=0
    [ "$pics" = "*.jpg" ] || {
        numpics=`ls -1 | grep jpg | wc -l`
    }
    [ "$pngs" = "*.png" ] || {
        numpngs=`ls -1 | grep png | wc -l`
    }
    totpics=`expr $numpics + $numpngs`
    numpage=`expr $totpics / 24`
    page=`expr $numpage + 1`
}

wh -l ${DDIR} \
   -m toplist \
   -a 16x9 \
   -n $numdown \
   -s $page \
   -c $categories \
   -f $filters \
   $quiet \
   -p 0
