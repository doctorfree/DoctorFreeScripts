#!/bin/bash

for i in *
do
    [ -d "$i" ] || continue
    siz=`echo $i | wc -c`
    num=`ls -1 $i | wc -l`
    printf "\n$i\t"
    [ $siz -lt 9 ] && printf "\t"
    [ $siz -lt 17 ] && printf "\t"
    printf "$num"
done
echo ""
