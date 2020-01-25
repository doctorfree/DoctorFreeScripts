#!/bin/bash

DARG=
[ "$1" == "-l" ] && {
    DARG="$1 $2"
    shift 2
}

label=`echo $* | sed -e "s/ /\%2B/g"`
echo "get-search ${DARG} -p 1 -n 2048 -s ${label}"
get-search ${DARG} -p 1 -n 2048 -s "${label}"
