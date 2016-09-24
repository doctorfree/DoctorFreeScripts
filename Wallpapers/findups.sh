#!/bin/bash
#
## @file findups.sh
## @brief Find and symlink duplicate files
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

[ -r ./utils ] && . ./utils

DUPFILE="duplicates.txt"
NEWDUPS="newduplicates.txt"
LINKEM=
DUPDIR=
if [ "$1" = "-l" ]
then
    LINKEM=1
else
    [ "$1" ] && {
        DUPDIR="$1"
        [ -d "${DUPDIR}" ] || {
            echo "${DUPDIR} not a directory or does not exist. Exiting."
            exit 1
        }
    }
fi

[ "$LINKEM" ] || {
    rm -f ${NEWDUPS}
    touch ${NEWDUPS}
}

[ -f ${DUPFILE} ] || {
    cat */downloaded.txt | sort | uniq -d > ${DUPFILE}
}

if [ "$LINKEM" ]
then
    numdups=`cat ${DUPFILE} | wc -l`
    completed=0
    while read num
    do
        numfiles=0
        DUPS=`echo */wallhaven-${num}\.???`
        for dup in ${DUPS}
        do
            [ -L "$dup" ] || {
                numfiles=`expr $numfiles + 1`
            }
        done
        [ $numfiles -eq 1 ] && {
            completed=`expr $completed + 1`
            progress $numdups $completed
            continue
        }
        link=
        for dup in ${DUPS}
        do
            [ "$link" ] || {
                [ -L "${dup}" ] || {
                    link="${dup}"
                }
                continue
            }
            [ -L "${dup}" ] && continue
            picdir=`dirname "$dup"`
            [ -d "${picdir}" ] || {
                echo "Unknown directory path ${picdir}. Skipping $dup"
                continue
            }
            cd "${picdir}"
            rm -f wallhaven-${num}\.???
            ln -s ../"${link}" .
            cd ..
        done
        completed=`expr $completed + 1`
        progress $numdups $completed
    done < ${DUPFILE}
else
    if [ "${DUPDIR}" ]
    then
        printf "\nCreating symbolic links in ${DUPDIR}\n"
        cd "${DUPDIR}"
        H=`pwd`
        numdups=`ls -1 *.jpg *.png 2> /dev/null | wc -l`
        completed=0
        for pic in *.jpg *.png
        do
            [ "$pic" = "*.jpg" ] && continue
            [ "$pic" = "*.png" ] && continue
            numfiles=0
            DUPS=`echo ../*/$pic`
            for dup in ${DUPS}
            do
                [ -L "$dup" ] || {
                    numfiles=`expr $numfiles + 1`
                }
            done
            [ $numfiles -eq 1 ] && {
                completed=`expr $completed + 1`
                progress $numdups $completed
                continue
            }
            link=
            for dup in ${DUPS}
            do
                [ "$link" ] || {
                    [ -L "${dup}" ] || {
                        link="${dup}"
                    }
                    continue
                }
                [ -L "${dup}" ] && continue
                picdir=`dirname "$dup"`
                [ -d "${picdir}" ] || {
                    echo "Unknown directory path ${picdir}. Skipping $dup"
                    continue
                }
                cd "${picdir}"
                rm -f $pic
                ln -s ${link} .
                cd $H
            done
            completed=`expr $completed + 1`
            progress $numdups $completed
        done
        printf "\nDONE\n"
    else
        numdups=`cat ${DUPFILE} | wc -l`
        completed=0
        while read num
        do
            numfiles=0
            DUPS=`echo */wallhaven-${num}\.???`
            for dup in ${DUPS}
            do
                [ -L "$dup" ] || {
                    numfiles=`expr $numfiles + 1`
                }
            done
            [ $numfiles -eq 1 ] || {
                echo $num >> ${NEWDUPS}
            }
            completed=`expr $completed + 1`
            progress $numdups $completed
        done < ${DUPFILE}
    fi
fi

[ "$LINKEM" ] || {
    [ "${DUPDIR}" ] || {
        mv ${NEWDUPS} ${DUPFILE}
    }
}
