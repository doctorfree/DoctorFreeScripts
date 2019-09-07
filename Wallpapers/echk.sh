#!/bin/bash

for i in ????-01*.jpg
do
    [ "$i" == "????-01*.jpg" ] && {
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
            # Check for filename of type ####-##_###.jpg
            under=
            echo $i | grep _ > /dev/null && under=1
            if [ "$under" ]
            then
                num=`echo $i | awk -F "-" ' { print $1 } '`
                suf=`echo $i | awk -F "_" ' { print $2 } ' | sed -e "s/.jpg//"`
                rm -f ${num}-??_${suf}.jpg
            else
                num=`echo $i | awk -F "-" ' { print $1 } '`
                rm -f ${num}-??.jpg
            fi
            break
        }
        echo "$j"
    done
    echo ""
done
../sizes
