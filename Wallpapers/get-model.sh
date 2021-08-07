#!/bin/bash

DARG="-m"

[ "$1" == "-u" ] && {
   echo "Usage: get-model [-psjbhu] <model name>"
   echo "Where:"
   echo "   -p indicates use Photographers download directory"
   echo "   -s indicates use Suicide Girls download directory"
   echo "   -j indicates use JAV download directory"
   echo "   -b indicates use Playboy download directory"
   echo "   -h indicates use Photodromm download directory"
   echo "   -u displays this usage message"
   echo "Default download directory is Models"
   exit 1
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
