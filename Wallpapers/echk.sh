#!/bin/bash

for i in ????-01.jpg
do
    [ "$i" == "????-01.jpg" ] && {
        echo "No new images to check."
        continue
    }
    new=`cksum $i | awk ' { print $1 } '`
    echo "$i"
    for j in */$i
    do
        [ "$j" == "*/$i" ] && {
            echo "NEW: $i"
            break
        }
        old=`cksum $j | awk ' { print $1 } '`
        [ "$new" == "$old" ] && {
            echo "OLD: $i already downloaded. Removing."
            num=`echo $i | awk -F "-" ' { print $1 } '`
            rm -f ${num}-??.jpg
            break
        }
        echo "$j"
    done
    echo ""
done
../sizes
