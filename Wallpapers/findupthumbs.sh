#!/bin/bash
#
## @file Wallpapers/findupthumbs.sh
## @brief Find and link duplicate thumbnails
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

[ "${PHOROOT}" ] || PHOROOT=/Photos

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi

# Set THMBS to the Thumbnail directory in which you want to create hard links
THMBS="$PHOROOT/Libraries/Wallhaven.photoslibrary/Thumbnails"

[ -d "$THMBS" ] || {
    echo "$THMBS does not exist or is not a directory. Exiting."
    exit 1
}
cd "$THMBS"

# Create a list of plain files and a sorted uniq'd list of those files
FILELIST="${THMBS}/filelist.txt"
SORTLIST="${THMBS}/sortlist.txt"
NEWDUPS="${THMBS}/newfilelist.txt"

rm -f ${NEWDUPS}
touch ${NEWDUPS}

[ -f "${FILELIST}" ] || {
    printf "\nCreating list of plain files ..."
    find . -type f -name thumb_wallhaven-\* > ${FILELIST}
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

numuniq=`cat ${SORTLIST} | wc -l`
[ $numplan -eq $numuniq ] && {
    echo "No duplicates found. Exiting."
    exit 0
}
completed=0
printf "\nFinding and linking duplicate files ...\n"
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
        # Check to see if they are already linked
        ck1=`ls -i "${THMBS}/${link}" | awk ' { print $1 } '`
        ck2=`ls -i "${dup}" | awk ' { print $1 } '`
        [ $ck1 -eq $ck2 ] && {
            echo "Files ${link} and ${dup} already linked. Skipping."
            continue
        }
        # Check to see if they are identical
        ck1=`cksum "${THMBS}/${link}" | awk ' { print $1 } '`
        ck2=`cksum "${dup}" | awk ' { print $1 } '`
        [ $ck1 -eq $ck2 ] || {
            echo "Checksums for ${link} and ${dup} do not match. Skipping."
            continue
        }
        if [ "$demo" ]
        then
            echo "rm -f $dup"
        else
            rm -f "$dup"
        fi
        cd "${picdir}"
        if [ "$demo" ]
        then
            echo "In ${picdir}: ln ${THMBS}/${link} ."
        else
            ln "${THMBS}/${link}" .
        fi
        cd ${THMBS}
    done
    rm -f /tmp/num$$
done < ${SORTLIST}
printf "\nDone\n"
prevperc=
rm -f /tmp/num$$
printf "\n"

