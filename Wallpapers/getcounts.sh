#!/bin/bash

rm -f counts.txt
touch counts.txt
for i in *
do
    [ -d $i ] || continue
    count=`ls -1 $i | wc -l`
    echo "$count $i" >> counts.txt
done
