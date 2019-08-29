#!/bin/bash
#
## @file Wallpapers/findups.sh
## @brief Find and symlink duplicate files
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi

HERE=`pwd`
# Create a list of plain files and a sorted uniq'd list of those files
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

mksortlist() {
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
}

[ -f "${SORTLIST}" ] || mksortlist

[ "${LN}" ] || LN="ln"

if [ "$LINKEM" ]
then
    numuniq=`cat ${SORTLIST} | wc -l`
    [ $numplan -eq $numuniq ] && {
        echo "No duplicates found. Exiting."
        exit 0
    }
    completed=0
    printf "\nFinding and symlinking duplicate files ...\n"
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
            if [ "$demo" ]
            then
                echo "rm -f $dup"
            else
                rm -f "$dup"
            fi
            cd "${picdir}"
            javido=
            models=
            photos=
            suicid=
            pwd | grep /Wallhaven/JAV_Idol/ > /dev/null && javido=1
            pwd | grep /Wallhaven/Models/ > /dev/null && models=1
            pwd | grep /Wallhaven/Photographers/ > /dev/null && photos=1
            pwd | grep /Wallhaven/Suicide_Girls/ > /dev/null && suicid=1
            if [ "$javido" ] || [ "$models" ] || [ "$photos" ] || [ "$suicid" ]
            then
                if [ "$demo" ]
                then
                    echo "In ${picdir}: ${LN} ../../${link} ."
                else
                    ${LN} ../../"${link}" .
                fi
            else
                if [ "$demo" ]
                then
                    echo "In ${picdir}: ${LN} ../${link} ."
                else
                    ${LN} ../"${link}" .
                fi
            fi
            cd ${HERE}
        done
        rm -f /tmp/num$$
    done < ${SORTLIST}
    printf "\nDone\n"
    prevperc=
    rm -f /tmp/num$$
else
    if [ "${DUPDIR}" ]
    then
        printf "\nUpdating file list with entries from ${DUPDIR}\n"
        find ./${DUPDIR} -type f -name wallhaven-\* >> ${FILELIST}
        numplan=`cat ${FILELIST} | wc -l`
        mksortlist
        printf "\nCreating symbolic links in ${DUPDIR}\n"
        cd "${DUPDIR}"
        H=`pwd`
        DIRFLIST="filelist.txt"
        UNIQLIST="uniqlist.txt"
        find . -type f -name wallhaven-\* > ${DIRFLIST}
        cat ${DIRFLIST} | sort | uniq > ${UNIQLIST}
        numuniq=`cat ${UNIQLIST} | wc -l`
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
                if [ "$demo" ]
                then
                    echo "In ${picdir}: rm -f $img"
                else
                    rm -f "$img"
                fi
                javido=
                models=
                photos=
                suicid=
                pwd | grep /Wallhaven/JAV_Idol/ > /dev/null && javido=1
                pwd | grep /Wallhaven/Models/ > /dev/null && models=1
                pwd | grep /Wallhaven/Photographers/ > /dev/null && photos=1
                pwd | grep /Wallhaven/Suicide_Girls/ > /dev/null && suicid=1
                if [ "$javido" ] || [ "$models" ] || [ "$photos" ] || [ "$suicid" ]
                then
                    if [ "$demo" ]
                    then
                        echo "In ${picdir}: ${LN} ../../${link} ."
                    else
                        ${LN} ../../"${link}" .
                    fi
                else
                    if [ "$demo" ]
                    then
                        echo "In ${picdir}: ${LN} ../${link} ."
                    else
                        ${LN} ../"${link}" .
                    fi
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

