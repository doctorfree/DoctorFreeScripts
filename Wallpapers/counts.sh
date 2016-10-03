#!/bin/bash
#
## @file Wallpapers/counts.sh
## @brief Prepare a table of number of pics & symbolic links in subdirectories
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

day=`date "+%d"`
month=`date "+%m"`
year=`date "+%Y"`
totalpics=0
totalinks=0
peopledir="People"
modelsdir="Models"

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi

COUNT=
[ "${subdir}" ] && {
    [ -d "${subdir}" ] && {
        cd "${subdir}"
        COUNT="counts-${subdir}-${year}-${month}-${day}.txt"
    }
}
[ "$COUNT" ] || COUNT="counts-$year-$month-$day.txt"
HERE=`pwd`

## @fn count_subdirs()
## @brief Count number of JPEG and PNG files and symbolic links in subdirs
## @param param1 directory in which to count image files in subdirs
##
## Uses kv-bash functions, if available, to store key/value pairs
count_subdirs() {
    topdir="$1"
    for sub in *
    do
        [ -d "$sub" ] && {
            bnumpics=`ls -1 $sub/*.jpg 2> /dev/null | wc -l`
            bnumpngs=`ls -1 $sub/*.png 2> /dev/null | wc -l`
            bnumtot=`expr $bnumpics + $bnumpngs`
            numpics=`expr $numpics + $bnumtot`
            [ "${have_kv}" ] && kvset "${topdir}_${sub}_numpics" $bnumtot
            bnumlinks=0
            for i in $sub/*
            do
                [ -L $i ] && bnumlinks=`expr $bnumlinks + 1`
            done
            [ "${have_kv}" ] && kvset "${topdir}_${sub}_numlinks" $bnumlinks
            numlinks=`expr $numlinks + $bnumlinks`
        }
    done
}

## @fn print_subdirs()
## @brief Print previously calculated counts of image files in subdirs
## @param param1 directory in which to display subdirectory image file counts
##
## Uses kv-bash functions, if available, to read key/value pairs
print_subdirs() {
    topdir="$1"
    for sub in *
    do
        [ -d "$sub" ] && {
            bnumpics=$(kvget "${topdir}_${sub}_numpics")
            [ $bnumpics -eq 0 ] && continue
            bnumlinks=$(kvget "${topdir}_${sub}_numlinks")
            bunlinked=`expr $bnumpics - $bnumlinks`
            printf "\n\t${sub}:" | tee -a $COUNT
            if [ ${#sub} -lt 7 ]
            then
                printf "\t\t" | tee -a $COUNT
            else
                [ ${#sub} -lt 15 ] && printf "\t" | tee -a $COUNT
            fi
            printf "\tPics=$bnumpics" | tee -a $COUNT
            [ $bnumpics -lt 100 ] && printf "\t" | tee -a $COUNT
            printf "\tFiles=$bunlinked" | tee -a $COUNT
            printf "\tLinks=$bnumlinks" | tee -a $COUNT
        }
    done
}

count_pics() {
    cdir="$1"
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
    numpics=`expr $numpics + $numpngs`
    for i in *
    do
        [ -L $i ] && numlinks=`expr $numlinks + 1`
    done
    # Count the subdirectories in ./People/ and ./Models/
    [ "${cdir}" = "${peopledir}" ] || [ "${cdir}" = "${modelsdir}" ] && {
        count_subdirs "${cdir}"
    }
    kvset "${cdir}_numpics" $numpics
    kvset "${cdir}_numlinks" $numlinks
}

print_pics() {
    cdir="$1"
    unlinked=`expr $numpics - $numlinks`
    printf "\n${pdir}:" | tee -a $COUNT
    if [ ${#pdir} -lt 7 ]
    then
        printf "\t\t\t" | tee -a $COUNT
    else
        if [ ${#pdir} -lt 15 ]
        then
            printf "\t\t" | tee -a $COUNT
        else
            if [ ${#pdir} -lt 23 ]
            then
                printf "\t" | tee -a $COUNT
            fi
        fi
    fi
    printf "\tPics=$numpics" | tee -a $COUNT
    [ $numpics -lt 100 ] && printf "\t" | tee -a $COUNT
    printf "\tFiles=$unlinked" | tee -a $COUNT
    printf "\tLinks=$numlinks" | tee -a $COUNT
    totalpics=`expr $totalpics + $unlinked`
    totalinks=`expr $totalinks + $numlinks`
    # Print the subdirectory totals for subdirs in ./People/ and ./Models/
    [ "${cdir}" = "${peopledir}" ] || [ "${cdir}" = "${modelsdir}" ] && {
        [ "${have_kv}" ] && print_subdirs "${cdir}"
    }
}

rm -f $COUNT
touch $COUNT

if [ "${subdir}" ]
then
    pdir=`echo "${subdir}" | sed -e "s/_/ /g"`
    count_pics "${subdir}"
    if [ $numpics -ne 0 ] || [ $numlinks -ne 0 ]
    then
        print_pics "${subdir}"
    fi
else
    for ddir in *
    do
        [ -d "${ddir}" ] || continue
        cd "${ddir}"
        pdir=`echo $ddir | sed -e "s/_/ /g"`
        count_pics "${ddir}"
        if [ $numpics -eq 0 ] && [ $numlinks -eq 0 ]
        then
            cd "${HERE}"
            continue
        fi
        print_pics "${ddir}"
        cd "${HERE}"
    done
fi

total=`expr $totalpics + $totalinks`
printf "\n\nTotals:\t\t\t\tPics=$total" | tee -a $COUNT
printf "\tFiles=$totalpics\tLinks=$totalinks\n" | tee -a $COUNT
