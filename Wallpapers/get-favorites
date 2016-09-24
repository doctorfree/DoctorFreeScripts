#!/bin/bash

[ -r ./utils ] && . ./utils
[ "$WHDIR" ] || WHDIR="/Volumes/My_Book_Studio/Pictures/Work/Wallhaven"

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
   -p 0

