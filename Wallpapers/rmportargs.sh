#!/bin/bash

TELL=
VERB=

[ "$1" == "-n" ] && {
    TELL=1
    [ "$2" == "-v" ] && {
        VERB=1
    }
}

[ "$1" == "-v" ] && {
    VERB=1
    [ "$2" == "-n" ] && {
        TELL=1
    }
}

for i in $*
do
    [ "$i" == "*.jpg" ] && continue
    [ "$i" == "*.jpeg" ] && continue
    [ "$i" == "*.png" ] && continue
    [ "${VERB}" ] && echo "Identifying $i"
    GEO=`identify "$i" | awk ' { print $(NF-6) } '`
    W=`echo $GEO | awk -F "x" ' { print $1 } '`
    # Remove if width not greater than 1000
    [ "$W" ] && [ $W -gt 1000 ] || {
        if [ "${TELL}" ]
        then
            echo "rm -f $i"
        else
            rm -f "$i"
        fi
        continue
    }
    H=`echo $GEO | awk -F "x" ' { print $2 } '`
    # Remove if height not greater than 750
    [ "$H" ] && [ $H -gt 750 ] || {
        if [ "${TELL}" ]
        then
            echo "rm -f $i"
        else
            rm -f "$i"
        fi
        continue
    }
    # Remove if width not greater than height
    [ "$W" ] && [ "$H" ] && [ $W -gt $H ] || {
        if [ "${TELL}" ]
        then
            echo "rm -f $i"
        else
            rm -f "$i"
        fi
    }
done
