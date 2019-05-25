#!/bin/bash

DARG="-m"

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

model=`echo $* | sed -e "s/ /\%2B/g"`
echo "./get-search -R ${DARG} -p 1 -n 2048 -s ${model}"
./get-search -R ${DARG} -p 1 -n 256 -s "${model}"
