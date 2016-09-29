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

HERE=`pwd`
# Create a list of plain files and a sorted uniq's list of those files
FILELIST="${HERE}/filelist.txt"
SORTLIST="${HERE}/sortlist.txt"
NEWDUPS="${HERE}/newfilelist.txt"
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

[ -f "${FILELIST}" ] || {
    printf "\nCreating list of plain files ..."
    find . -type f -name wallhaven-\* > ${FILELIST}
    printf " done.\n"
}
numplan=`cat ${FILELIST} | wc -l`

[ -f "${SORTLIST}" ] || {
    printf "\nCreating sorted uniq list of plain files ...\n"
    rm -f /tmp/files$$
    touch /tmp/files$$
    completed=0
    cat ${FILELIST} | while read wallpath
    do
        filename=`basename "$wallpath"`
        echo "$filename" >> /tmp/files$$
        completed=`expr $completed + 1`
        progress $numplan $completed
    done
    printf "\n"
    prevperc=
    cat /tmp/files$$ | sort | uniq > ${SORTLIST}
    rm -f /tmp/files$$
    printf " done.\n"
}

if [ "$LINKEM" ]
then
    numuniq=`cat ${SORTLIST} | wc -l`
    [ $numplan -eq $numuniq ] && {
        echo "No duplicates found. Exiting."
        exit 0
    }
    completed=0
    while read num
    do
        completed=`expr $completed + 1`
        progress $numuniq $completed
        grep $num ${FILELIST} > /tmp/num$$
        numfiles=`cat /tmp/num$$ | wc -l`
        [ $numfiles -eq 1 ] && {
            continue
        }
        link=`head -1 /tmp/num$$`
        cat /tmp/num$$ | while read dup
        do
            [ "$link" = "$dup" ] && continue
            picdir=`dirname "$dup"`
            [ -d "${picdir}" ] || {
                echo "Unknown directory path ${picdir}. Skipping $dup"
                continue
            }
            fnam=`basename "$dup"`
            # Remove leading ./ from $link filename path
            link=`echo $link | sed -e "s/\.\///"`
            rm -f "$dup"
            cd "${picdir}"
            peeps=
            pwd | grep /Wallhaven/People/ > /dev/null && peeps=1
            if [ "$peeps" ]
            then
                ln -s ../../"${link}" .
            else
                ln -s ../"${link}" .
            fi
            cd ${HERE}
        done
        rm -f /tmp/num$$
    done < ${SORTLIST}
    printf "\n"
    prevperc=
    rm -f /tmp/num$$
else
    if [ "${DUPDIR}" ]
    then
        printf "\nCreating symbolic links in ${DUPDIR}\n"
        cd "${DUPDIR}"
        H=`pwd`
        B=`basename "$H"`
        DIRFLIST="filelist.txt"
        UNIQLIST="uniqlist.txt"
        find . -type f -name wallhaven-\* > ${DIRFLIST}
        cat ${DIRFLIST} | sort | uniq > ${UNIQLIST}
        peeps=
        [ "$B" = "People" ] && peeps=1
        numuniq=`grep "/$B/" "${UNIQLIST}" | wc -l`
        completed=0
        cat "${UNIQLIST}" | while read pic
        do
            completed=`expr $completed + 1`
            progress $numuniq $completed
            img="`basename $pic`"
            grep "$img" ${FILELIST} > /tmp/num$$
            numfiles=`cat /tmp/num$$ | wc -l`
            [ $numfiles -eq 1 ] && continue
            link=`head -1 /tmp/num$$`
            # Remove leading ./ from $link filename path
            link=`echo $link | sed -e "s/\.\///"`
            cat /tmp/num$$ | while read dup
            do
                [ "$link" = "$dup" ] && continue
                picdir="${HERE}"/`dirname "$dup"`
                [ -d "${picdir}" ] || {
                    echo "Unknown directory path ${picdir}. Skipping $dup"
                    continue
                }
                cd "${picdir}"
                rm -f "$img"
                pwd | grep /Wallhaven/People/ > /dev/null && people=1
                if [ "$people" ]
                then
                    ln -s ../../"${link}" .
                else
                    ln -s ../"${link}" .
                fi
            done
            rm -f /tmp/num$$
        done
        rm -f /tmp/num$$
        printf "\nDONE\n"
        prevperc=
    else
        find . -type f -name wallhaven-\* > ${FILELIST}
        cat ${FILELIST} | sort | uniq > ${SORTLIST}
        numuniq=`cat ${SORTLIST} | wc -l`
        completed=0
        while read num
        do
            numfiles=0
            completed=`expr $completed + 1`
            progress $numuniq $completed
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
        done < ${SORTLIST}
        prevperc=
        mv ${NEWDUPS} ${SORTLIST}
    fi
fi
printf "\n"

