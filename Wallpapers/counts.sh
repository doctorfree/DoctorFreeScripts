#!/bin/bash
#
## @file Wallpapers/counts.sh
## @brief Prepare a table of number of pics & symbolic links in subdirectories
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

H=`pwd`
totalpics=0
totalinks=0
numdir=0
curdir=0

for i in *
do
    [ -d "$i" ] && numdir=`expr $numdir + 1`
done

peepdir="./People/"
find . -type d | while read ddir
do
    [ "${ddir}" = "." ] && continue
    # Skip over the subdirectories in ./People/
    [ "${ddir:0:${#peepdir}}" = "${peepdir}" ] && continue
    curdir=`expr $curdir + 1`
    cd "${ddir}"
    ddir=`echo ${ddir} | sed -e "s/\.\///"`
    numpics=0
    numpngs=0
    numlinks=0
    pics=`echo *.jpg`
    [ "$pics" = "*.jpg" ] || {
        numpics=`ls -1 *.jpg | wc -l`
    }
    pngs=`echo *.png`
    [ "$pngs" = "*.png" ] || {
        numpngs=`ls -1 *.png | wc -l`
    }
    [ "${ddir}" = "./People" ] && {
        for subdir in 0 1 2 3 4 5 6 7 8 9
        do
            bnumpics=`ls -1 $subdir/*.jpg 2> /dev/null | wc -l`
            numpics=`expr $numpics + $bnumpics`
            bnumpngs=`ls -1 $subdir/*.png 2> /dev/null | wc -l`
            numpngs=`expr $numpngs + $bnumpngs`
        done
    }
    numpics=`expr $numpics + $numpngs`
    for i in *
    do
        [ -L $i ] && numlinks=`expr $numlinks + 1`
    done
    [ "${ddir}" = "./People" ] && {
        bnumlinks=0
        for subdir in 0 1 2 3 4 5 6 7 8 9
        do
            for i in $subdir/*
            do
                [ -L $i ] && bnumlinks=`expr $bnumlinks + 1`
            done
            numlinks=`expr $numlinks + $bnumlinks`
        done
    }
    if [ $numpics -eq 0 ] && [ $numlinks -eq 0 ]
    then
        [ $curdir -eq $numdir ] && {
            total=`expr $totalpics + $totalinks`
            printf "\n\nTotals:\t\t\tPics=$total"
            printf "\tFiles=$totalpics\tLinks=$totalinks\n"
        }
        cd "${H}"
        continue
    fi
    unlinked=`expr $numpics - $numlinks`
    printf "\n${ddir}:"
    if [ ${#ddir} -lt 7 ]
    then
        printf "\t\t"
    else
        [ ${#ddir} -lt 15 ] && printf "\t"
    fi
    printf "\tPics=$numpics"
    [ $numpics -lt 100 ] && printf "\t"
    printf "\tFiles=$unlinked"
#   [ $unlinked -lt 100 ] && printf "\t"
    printf "\tLinks=$numlinks"
    totalpics=`expr $totalpics + $unlinked`
    totalinks=`expr $totalinks + $numlinks`
    [ $curdir -eq $numdir ] && {
        total=`expr $totalpics + $totalinks`
        printf "\n\nTotals:\t\t\tPics=$total"
        printf "\tFiles=$totalpics\tLinks=$totalinks\n"
    }
    cd "${H}"
done
