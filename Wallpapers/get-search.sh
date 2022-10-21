#!/bin/bash
#
## @file Wallpapers/get-search.sh
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

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi

# Root directory of your subfolders of Wallhaven image files
MAC_TOP=/u/pictures/Work/Wallhaven
LIN_TOP=/u/pictures/Wallhaven
SEA_TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"

[ "$WHDIR" ] || WHDIR="$SEA_TOP"
[ -d "$WHDIR" ] || {
    plat=`uname -s`
    # Try to figure out which system we are on
    if [ "$plat" == "Linux" ]
    then
        WHDIR="$LIN_TOP"
    else
        if [ "$plat" == "Darwin" ]
        then
            WHDIR="$MAC_TOP"
        else
            echo "Unable to detect a supported platform: ${plat}. Exiting."
            exit 1
        fi
    fi
    [ -d "$WHDIR" ] || {
        WHDIR="$SEA_TOP"
        [ -d "$WHDIR" ] || {
            echo "Cannot locate Work directory for pics. Exiting."
            exit 1
        }
    }
}

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
    QDIR=`echo ${query} | sed -e "s/ /_/g" -e "s/+/_/g" -e "s/\%2B/_/g"`
fi
[ "$artist" ] && QDIR="Artists/${QDIR}"
[ "$model" ] && QDIR="Models/${QDIR}"
[ "$playboy" ] && QDIR="Models/Playboy/${QDIR}"
[ "$photodromm" ] && QDIR="Models/Photodromm/${QDIR}"
[ "$photo" ] && QDIR="Photographers/${QDIR}"
if [ "$suicide" ]
then
    QDIR="Suicide_Girls/${QDIR}"
else
    if [ "$japanese" ]
    then
        QDIR="JAV_Idol/${QDIR}"
    else
        [ "${QDIR}" == "Suicide_Girls" ] && QDIR="Suicide_Girls/Misc"
    fi
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
        numpics=`ls -1 | grep jpg | wc -l`
    }
    [ "$pngs" = "*.png" ] || {
        numpngs=`ls -1 | grep png | wc -l`
    }
    totpics=`expr $numpics + $numpngs`
    numpage=`expr $totpics / 24`
    page=`expr $numpage + 1`
}

if [ "${demo}" ]
then
  echo "wh -l ${DDIR} -n $numdown -s $page -t search $quiet \
           -c $categories -f $filters -q ${query} -p 0 ${latest}"
else
  wh -l "${DDIR}" -n $numdown -s $page -t search $quiet \
     -c $categories -f $filters -q "${query}" -p 0 ${latest}
fi

#cd "${WHDIR}"
#echo "Finding duplicates in ${QDIR}"
#./findups "${QDIR}"
