#!/bin/bash
#
## @file Wallpapers/get-people.sh
## @brief Download Wallhaven wallpapers in the People category
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

[ -r ./utils ] && . ./utils
[ "$WHDIR" ] || WHDIR="/Volumes/My_Book_Studio/Pictures/Work/Wallhaven"

DDIR="${WHDIR}/People"

[ "$numdown" ] || numdown=480
[ "$categories" ] || categories=001
[ "$filters" ] || filters=001

[ -d "${DDIR}" ] || mkdir -p "${DDIR}"
cd "${DDIR}"
[ $page ] || {
    anumpics=`ls -1 *.jpg 2> /dev/null | wc -l`
    anumpngs=`ls -1 *.png 2> /dev/null | wc -l`
    numpics=$anumpics
    numpngs=$anumpngs
    for subdir in 0 1 2 3 4 5 6 7 8 9
    do
        bnumpics=`ls -1 $subdir/*.jpg 2> /dev/null | wc -l`
        numpics=`expr $numpics + $bnumpics`
        bnumpngs=`ls -1 $subdir/*.png 2> /dev/null | wc -l`
        numpngs=`expr $numpngs + $bnumpngs`
    done
    totpics=`expr $numpics + $numpngs`
    numpage=`expr $totpics / 24`
    page=`expr $numpage + 1`
}

wh -l "${DDIR}" \
   -n $numdown \
   -s $page \
   -t standard \
   -c $categories \
   -f $filters \
   -p 0

