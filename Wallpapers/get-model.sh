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

model=`echo $* | sed -e "s/ /\%2B/g"`
echo "./get-search ${DARG} -s ${model}"
./get-search ${DARG} -s "${model}"
