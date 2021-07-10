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

[ "$1" == "-b" ] && {
   DARG="-b"
   shift
}

[ "$1" == "-h" ] && {
   DARG="-h"
   shift
}

model=`echo $* | sed -e "s/ /\%2B/g"`
echo "get-search ${DARG} -p 1 -n 2048 -s ${model}"
get-search ${DARG} -p 1 -n 2048 -s "${model}"
