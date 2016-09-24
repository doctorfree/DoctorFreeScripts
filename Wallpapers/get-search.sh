#!/bin/bash
#
## @file get-search.sh
## @brief Download Wallhaven images matching the specified search term(s)
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##
## Downloaded files are placed in a subdirectory based on the search terms
## or the subdirectory specified in the -l option. If no subdirectory is
## specified on the command line then the subdirectory name is the search
## phrase with all occurrences of '+' and space replaced by '_'. After the
## search and download is completed, duplicate files in the download directory
## are symlinked.

[ -r ./utils ] && . ./utils
[ "$WHDIR" ] || WHDIR="/Volumes/My_Book_Studio/Pictures/Work/Wallhaven"

DDIR="${WHDIR}/Anime"

[ "$numdown" ] || numdown=480
[ "$categories" ] || categories=111
[ "$filters" ] || filters=001

[ "$query" ] || query="$*"

# Replace spaces and plusses in search terms with underscores to construct
# the subdirectory name to use
if [ "$subdir" ]
then
    QDIR="${subdir}"
else
    QDIR=`echo ${query} | sed -e "s/ /_/g" -e "s/+/_/g"`
fi
DDIR="${WHDIR}/${QDIR}"

[ -d "${DDIR}" ] || mkdir -p "${DDIR}"
cd "${DDIR}"

## Try to set a reasonable start page if one has not been specified by
## counting the number of previously downloaded images and divide by 24
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

wh -l "${DDIR}" -n $numdown -s $page -t search \
   -c $categories -f $filters -q "${query}" -p 0

cd "${WHDIR}"
./findups "${QDIR}"
