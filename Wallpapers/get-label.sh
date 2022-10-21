#!/bin/bash

DARG=
TELL=
[ "$1" == "-d" ] && {
    TELL="-d"
    shift
}
[ "$1" == "-l" ] && {
    DARG="$1 $2"
    shift 2
}
[ "$1" == "-d" ] && {
    TELL="-d"
    shift
}

label=`echo $* | sed -e "s/ /\%2B/g"`
echo "get-search ${TELL} ${DARG} -p 1 -n 2048 -s ${label}"
get-search ${TELL} ${DARG} -p 1 -n 2048 -s "${label}"
