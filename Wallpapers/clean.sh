#!/bin/bash

rm -f *.txt
for i in */*.txt
do
    basnam=`basename "$i"`
    [ "$basnam" = "downloaded.txt" ] || rm -f "$i"
done
