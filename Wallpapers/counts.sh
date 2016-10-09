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
totaladds=0
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
ADDED=
[ "${subdir}" ] && {
    [ -d "${subdir}" ] && {
        cd "${subdir}"
        COUNT="total-${subdir}-${year}-${month}-${day}.txt"
        ADDED="added-${subdir}-${year}-${month}-${day}.txt"
    }
}
[ "$COUNT" ] || COUNT="total-$year-$month-$day.txt"
[ "$ADDED" ] || ADDED="added-$year-$month-$day.txt"
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
            [ "${have_kv}" ] && {
                onumtot=$(kvget "${topdir}_${sub}_numpics")
                [ "${onumtot}" ] && {
                    numadded=`expr $bnumtot - $onumtot`
                    kvset "${topdir}_${sub}_picsadded" $numadded
#                   [ $numadded -gt 0 ] && {
#                       printf "\nAdded $numadded pics in ${topdir}/${sub}" 2>> ${ADDED}
#                   }
                }
                kvset "${topdir}_${sub}_numpics" $bnumtot
            }
            bnumlinks=0
            for i in $sub/*
            do
                [ -L $i ] && bnumlinks=`expr $bnumlinks + 1`
            done
            [ "${have_kv}" ] && {
                onumtot=$(kvget "${topdir}_${sub}_numlinks")
                [ "${onumtot}" ] && {
                    numadded=`expr $bnumlinks - $onumtot`
                    kvset "${topdir}_${sub}_linkadded" $numadded
#                   [ $numadded -gt 0 ] && {
#                      printf "\nAdded $numadded links in ${topdir}/${sub}" 2>> ${ADDED}
#                   }
                }
                kvset "${topdir}_${sub}_numlinks" $bnumlinks
            }
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
            addedpics=$(kvget "${topdir}_${sub}_picsadded")
            addedlink=$(kvget "${topdir}_${sub}_linkadded")
            [ "$addedpics" ] || addedpics=0
            [ "$addedlink" ] || addedlink=0
            numadded=`expr $addedpics + $addedlink`
            if [ $numadded -gt 0 ]
            then
                substr="${sub} (added $numadded)"
            else
                substr="${sub}"
            fi
            printf "\n\t${substr}:"
            if [ ${#substr} -lt 7 ]
            then
                printf "\t\t"
            else
                [ ${#substr} -lt 15 ] && printf "\t"
            fi
            printf "\tPics=$bnumpics"
            [ $bnumpics -lt 100 ] && printf "\t"
            printf "\tFiles=$bunlinked"
            [ $bunlinked -lt 10 ] && printf "\t"
            printf "\tLinks=$bnumlinks"
        }
    done
}

count_pics() {
    cdir="$1"
    numpics=0
    numpngs=0
    numlinks=0
    numpics=`ls -1 | grep jpg | wc -l`
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
    [ "${have_kv}" ] && {
        onumtot=$(kvget "${cdir}_numpics")
        [ "${onumtot}" ] && {
            numadded=`expr $numpics - $onumtot`
            kvset "${cdir}_picsadded" $numadded
#           [ $numadded -gt 0 ] && {
#               printf "\nAdded $numadded pics in ${cdir}" 2>> ${ADDED}
#           }
        }
        onumtot=$(kvget "${cdir}_numlinks")
        [ "${onumtot}" ] && {
            numadded=`expr $numlinks - $onumtot`
            kvset "${cdir}_linkadded" $numadded
#           [ $numadded -gt 0 ] && {
#               printf "\nAdded $numadded links in ${cdir}" 2>> ${ADDED}
#           }
        }
        kvset "${cdir}_numpics" $numpics
        kvset "${cdir}_numlinks" $numlinks
    }
}

print_pics() {
    cdir="$1"
    unlinked=`expr $numpics - $numlinks`
    addedpics=$(kvget "${cdir}_picsadded")
    addedlink=$(kvget "${cdir}_linkadded")
    [ "$addedpics" ] || addedpics=0
    [ "$addedlink" ] || addedlink=0
    numadded=`expr $addedpics + $addedlink`
    if [ $numadded -gt 0 ]
    then
        substr="${pdir} (added $numadded)"
    else
        substr="${pdir}"
    fi
    printf "\n${substr}:"
    if [ ${#substr} -lt 7 ]
    then
        printf "\t\t\t"
    else
        if [ ${#substr} -lt 15 ]
        then
            printf "\t\t"
        else
            if [ ${#substr} -lt 23 ]
            then
                printf "\t"
            fi
        fi
    fi
    printf "\tPics=$numpics"
    [ $numpics -lt 100 ] && printf "\t"
    printf "\tFiles=$unlinked"
    printf "\tLinks=$numlinks"
    totaladds=`expr $totaladds + $numadded`
    totalpics=`expr $totalpics + $unlinked`
    totalinks=`expr $totalinks + $numlinks`
    # Print the subdirectory totals for subdirs in ./People/ and ./Models/
    [ "${cdir}" = "${peopledir}" ] || [ "${cdir}" = "${modelsdir}" ] && {
        [ "${have_kv}" ] && print_subdirs "${cdir}"
    }
}

rm -f $COUNT
touch $COUNT
rm -f $ADDED
touch $ADDED
exec &> >(tee -a "$COUNT")

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
printf "\n\nTotals:\t\tAdded=$totaladds\tPics=$total"
printf "\tFiles=$totalpics\tLinks=$totalinks\n"
