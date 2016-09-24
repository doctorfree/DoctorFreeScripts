#!/bin/bash

[ -r ./utils ] && . ./utils
[ "$WHDIR" ] || WHDIR="/Volumes/My_Book_Studio/Pictures/Work/Wallhaven"

DDIR="${WHDIR}/People"

[ "$numdown" ] || numdown=480
[ "$categories" ] || categories=001
[ "$filters" ] || filters=001

[ -d "${DDIR}" ] || mkdir -p "${DDIR}"
cd "${DDIR}"
[ $page ] || {
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
   -t standard \
   -c $categories \
   -f $filters \
   -p 0

