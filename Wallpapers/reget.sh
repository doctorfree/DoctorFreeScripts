#!/bin/bash
#
## @file Wallpapers/reget.sh
## @brief Re-download Wallhaven images for multiple search term directories
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2017, Ronald Joe Record, all rights reserved.
## @date Written 27-Sep-2017
## @version 1.0.1
##
## Multiple search term downloads from Wallhaven may have been done with a
## logical OR. This convenience script (optionally) removes previous download
## directories created with multiple search terms and recreates them using
## logical AND of search terms.

[ "${PICROOT}" ] || PICROOT=/Volumes/Seagate_8TB/Pictures/Work

TDIR="${PICROOT}/Wallhaven"
MDIR="$TDIR/Models"
PDIR="$TDIR/Photographers"
MODEL=
PHOTO=
TOP=
DEM=
ADD=
VERBOSE="-q"

usage() {
    printf "\nUsage: reget [-A] [-a] [-d] [-m] [-p] [-t] [-u] [-v]"
    printf "\nWhere:"
    printf "\n\t-A indicates Add to existing dir, do not remove"
    printf "\n\t-a indicates all, top and subdirs"
    printf "\n\t-d indicates demo mode, tell me what you would do"
    printf "\n\t-m indicates use Models subdir"
    printf "\n\t-p indicates use Photographers subdir"
    printf "\n\t-t indicates use top dir"
    printf "\n\t-v indicates output verbose status messages"
    printf "\n\t-u displays this usage message\n\n"
    exit 1
}

getem() {
    [ -d "${DDIR}" ] || {
        echo "Directory $DDIR does not exist. Exiting."
        exit 1
    }

    echo "Regetting photos in $DDIR"
    cd "${DDIR}"
    for folder in *_*
    do
        num=`ls -1 "$folder" | wc -l`
        num=`expr $num \* 2`
        [ $num -le 2 ] && num=200
        [ "$ADD" ] || {
            [ "$DEM" ] || rm -rf "$folder"
        }
        search=`echo "${folder}" | sed -e "s/_/\%2B/g"`
        echo "Retrieving photos with search term $search"
        if [ "$DEM" ]
        then
            echo "$TDIR/get-search $VERBOSE $DOPT -n $num -s $search"
        else
            "$TDIR"/get-search $VERBOSE $DOPT -n $num -s "$search"
        fi
    done
}

while getopts Aadmptuv flag; do
    case $flag in
        A)
            ADD=1
            ;;
        a)
            MODEL=1
            PHOTO=1
            TOP=1
            ;;
        d)
            DEM=1
            ;;
        m)
            MODEL=1
            ;;
        p)
            PHOTO=1
            ;;
        t)
            TOP=1
            ;;
        v)
            VERBOSE=
            ;;
        u)
            usage
            ;;
    esac
done

[ "$MODEL" ] && {
    DDIR="$MDIR"
    DOPT="-m"
    getem
}
[ "$PHOTO" ] && {
    DDIR="$PDIR"
    DOPT="-P"
    getem
}
[ "$TOP" ] && {
    DDIR="$TDIR"
    DOPT=""
    getem
}

