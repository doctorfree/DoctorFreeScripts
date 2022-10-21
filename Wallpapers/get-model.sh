#!/bin/bash

DARG="-m"
TELL=

usage() {
   echo "Usage: get-model [-psjebhu] <model name>"
   echo "Where:"
   echo "   -a indicates use Artists download directory"
   echo "   -d indicates tell me what you would do, don't do anything"
   echo "   -p indicates use Photographers download directory"
   echo "   -s indicates use Suicide Girls download directory"
   echo "   -j indicates use JAV download directory"
   echo "   -b indicates use Playboy download directory"
   echo "   -e indicates use Penthouse download directory"
   echo "   -h indicates use Photodromm download directory"
   echo "   -u displays this usage message"
   echo "Default download directory is Models"
   exit 1
}

while getopts "adpsjbehu" flag; do
    case $flag in
        a) DARG="-a"
           ;;
        d) TELL="-d"
           ;;
        p) DARG="-P"
           ;;
        s) DARG="-S"
           ;;
        j) DARG="-J"
           ;;
        b) DARG="-b"
           ;;
        e) DARG="-e"
           ;;
        h) DARG="-h"
           ;;
        u) usage
           ;;
    esac
done
shift $(( OPTIND - 1 ))

model=`echo $* | sed -e "s/ /\%2B/g"`
echo "get-search ${TELL} ${DARG} -p 1 -n 2048 -s ${model}"
get-search ${TELL} ${DARG} -p 1 -n 2048 -s "${model}"
