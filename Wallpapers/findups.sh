#!/bin/bash
#
## @file Wallpapers/findups.sh
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
if [ "$1" ]
then
    DUPDIR="$1"
    [ -d "${DUPDIR}" ] || {
        echo "${DUPDIR} not a directory or does not exist. Exiting."
        exit 1
    }
else
    LINKEM=1
fi

[ "$LINKEM" ] || {
    rm -f ${NEWDUPS}
    touch ${NEWDUPS}
}

[ -f ${DUPFILE} ] || {
    cat */downloaded.txt | sort | uniq -d > ${DUPFILE}
}

HERE=`pwd`
if [ "$LINKEM" ]
then
    numdups=`cat ${DUPFILE} | wc -l`
    completed=0
    while read num
    do
        numfiles=0
        completed=`expr $completed + 1`
        progress $numdups $completed
        DUPS=`echo */wallhaven-${num}\.??? People/*/wallhaven-${num}\.???`
        for dup in ${DUPS}
        do
            [ "$dup" = "*/wallhaven-${num}\.???" ] && continue
            [ "$dup" = "People/*/wallhaven-${num}\.???" ] && continue
            [ -L "$dup" ] || {
                numfiles=`expr $numfiles + 1`
            }
        done
        [ $numfiles -eq 1 ] && {
            continue
        }
        link=
        for dup in ${DUPS}
        do
            [ "$dup" = "*/wallhaven-${num}\.???" ] && continue
            [ "$dup" = "People/*/wallhaven-${num}\.???" ] && continue
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
            H=`pwd`
            rm -f wallhaven-${num}\.???
            peeps=
            echo $H | grep /Wallhaven/People/ > /dev/null && peeps=1
            if [ "$peeps" ]
            then
                ln -s ../../"${link}" .
            else
                ln -s ../"${link}" .
            fi
            cd ${HERE}
        done
    done < ${DUPFILE}
else
    if [ "${DUPDIR}" ]
    then
        printf "\nCreating symbolic links in ${DUPDIR}\n"
        cd "${DUPDIR}"
        H=`pwd`
        B=`basename "$H"`
        if [ "$B" = "People" ]
        then
            numdups=0
            for d in 0 1 2 3 4 5 6 7 8 9
            do
                numdir=`ls -1 $d/*.jpg $d/*.png 2> /dev/null | wc -l`
                numdups=`expr $numdups + $numdir`
            done
            pics="*/*.jpg */*.png"
            peeps=1
        else
            numdups=`ls -1 *.jpg *.png 2> /dev/null | wc -l`
            pics="*.jpg *.png"
            peeps=
        fi
        completed=0
        for pic in $pics
        do
            completed=`expr $completed + 1`
            progress $numdups $completed
            [ "$pic" = "*.jpg" ] && continue
            [ "$pic" = "*/*.jpg" ] && continue
            [ "$pic" = "*.png" ] && continue
            [ "$pic" = "*/*.png" ] && continue
            numfiles=0
            if [ "$peeps" ]
            then
                DUPS=`echo ../../*/$pic`
            else
                DUPS=`echo ../*/$pic`
            fi
            for dup in ${DUPS}
            do
                [ -L "$dup" ] || {
                    numfiles=`expr $numfiles + 1`
                }
            done
            [ $numfiles -eq 1 ] && {
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
        done
        printf "\nDONE\n"
    else
        numdups=`cat ${DUPFILE} | wc -l`
        completed=0
        while read num
        do
            numfiles=0
            completed=`expr $completed + 1`
            progress $numdups $completed
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
        done < ${DUPFILE}
    fi
fi

[ "$LINKEM" ] || {
    [ "${DUPDIR}" ] || {
        mv ${NEWDUPS} ${DUPFILE}
    }
}
