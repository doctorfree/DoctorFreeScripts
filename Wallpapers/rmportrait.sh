#!/bin/bash

VERBOSE=
TELL=

[ "$1" == "-v" ] && VERBOSE=1
[ "$1" == "-n" ] && TELL=1

rm -f *.gif
rm -f *.txt
for i in *.jpg *.jpeg *.png
do
    [ "$i" == "*.jpg" ] && continue
    [ "$i" == "*.jpeg" ] && continue
    [ "$i" == "*.png" ] && continue
    [ "$VERBOSE" ] && echo "identify $i"
    GEO=`identify $i | awk ' { print $3 } '`
    W=`echo $GEO | awk -F "x" ' { print $1 } '`
    # Remove if width not greater than 1000
    [ $W -gt 1000 ] || {
        rm -f $i
        continue
    }
    H=`echo $GEO | awk -F "x" ' { print $2 } '`
    # Remove if height not greater than 750
    [ $H -gt 750 ] || {
        rm -f $i
        continue
    }
    # Remove if width not greater than height
    [ $W -gt $H ] || rm -f $i
    # Remove if width not greater than height
    [ $W -gt $H ] || {
        if [ "$TELL" ]
        then
            echo "rm -f $i"
        else
            rm -f $i
        fi
    }
done
