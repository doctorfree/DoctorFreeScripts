#!/bin/bash

DARG=
ALL=

[ "$1" == "-a" ] && {
   ALL=1
   shift
}

[ "$1" == "-m" ] && {
   DARG="-m"
   shift
}

[ "$1" == "-p" ] && {
   DARG="-P"
   shift
}

[ "$1" == "-s" ] && {
   DARG="-S"
   shift
}

[ "$1" == "-j" ] && {
   DARG="-J"
   shift
}

if [ "$ALL" ]
then
    get-models -l -m
    get-models -l -j
    get-models -l -s
else
    model=`echo $* | sed -e "s/ /\%2B/g"`
    echo "get-search -R ${DARG} -p 1 -n 2048 -s ${model}"
    get-search -R ${DARG} -p 1 -n 256 -s "${model}"
fi
