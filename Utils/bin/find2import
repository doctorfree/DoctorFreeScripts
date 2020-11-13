#!/bin/bash
#
## @file find2import.sh
## @brief List photo albums and movies that can be imported into iTunes
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @version 1.0.1
##

FEMJOY="/Volumes/My_Book_Studio/Pictures/Work/Femjoy"
#KINDGIRLS="/Volumes/My_Book_Studio/Pictures/Work/KindGirls"
KINDGIRLS="/Volumes/LaCie_8TB/Pictures/Work/KindGirls"
MOVS="/Volumes/My_Book_Studio/Movies/Work"
prev_d="__notset__"

for PICDIR in "${FEMJOY}" "${KINDGIRLS}"
do
    cd "${PICDIR}"
    printf "\n\nThe following photo albums can be imported from\n${PICDIR}:\n\n"
    find . -type f | while read i
    do
        d=`dirname "$i"`
        [ "$d" = "$prev_d" ] || {
            echo $d
            prev_d="$d"
        }
    done
done

cd "$MOVS"
printf "\n\nThe following movies can be imported from\n${MOVS}:\n\n"
find . -type f | grep -v /bin/ | grep -v mvnew | grep -v getnew | \
                 grep -v cknew | grep -v Katlyn_Stripping_Source | grep -v SUMS
printf "\n\n"
