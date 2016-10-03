#!/bin/bash
#
## @file Wallpapers/mvem.sh
## @brief Move downloaded files to subdirs
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

[ -d "$1" ] || {
    echo "$1 not a directory. Exiting."
    exit 1
}
if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./utils ] && . ./utils
fi
cd "$1"
for i in 0 1 2 3 4 5 6 7 8 9
do
    [ -d $i ] || mkdir $i
    touch $i/downloaded.txt
done

completed=0
numjpg=`ls -1 *.jpg 2> /dev/null | wc -l`
numpng=`ls -1 *.png 2> /dev/null | wc -l`
totalpics=`expr $numjpg + $numpng`

move_it() {
    [ -r "$2"/"$1" ] || mv "$1" "$2"
}

for pic in *.jpg *.png
do
    completed=`expr $completed + 1`
    progress $totalpics $completed
    [ "$pic" = "*.jpg" ] && continue
    [ "$pic" = "*.png" ] && continue
    num=`echo $pic | sed -e "s/wallhaven-//" -e "s/\.jpg//" -e "s/\.png//"`
    [ $num -lt 100000 ] && {
        move_it "$pic" 0
        echo "$num" >> 0/downloaded.txt
        continue
    }
    [ $num -lt 200000 ] && {
        move_it "$pic" 1
        echo "$num" >> 1/downloaded.txt
        continue
    }
    [ $num -lt 300000 ] && {
        move_it "$pic" 2
        echo "$num" >> 2/downloaded.txt
        continue
    }
    [ $num -lt 400000 ] && {
        move_it "$pic" 3
        echo "$num" >> 3/downloaded.txt
        continue
    }
    [ $num -lt 500000 ] && {
        move_it "$pic" 4
        echo "$num" >> 4/downloaded.txt
        continue
    }
    [ $num -lt 600000 ] && {
        move_it "$pic" 5
        echo "$num" >> 5/downloaded.txt
        continue
    }
    [ $num -lt 700000 ] && {
        move_it "$pic" 6
        echo "$num" >> 6/downloaded.txt
        continue
    }
    [ $num -lt 800000 ] && {
        move_it "$pic" 7
        echo "$num" >> 7/downloaded.txt
        continue
    }
    [ $num -lt 900000 ] && {
        move_it "$pic" 8
        echo "$num" >> 8/downloaded.txt
        continue
    }
    move_it "$pic" 9
    echo "$num" >> 9/downloaded.txt
done
printf "\n"
