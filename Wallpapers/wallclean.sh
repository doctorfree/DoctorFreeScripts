#!/bin/bash

rm -f *.txt
for i in */*.txt */*/*.txt */login.? */*/login.?
do
    [ "$i" = "*/*.txt" ] && continue
    [ "$i" = "*/*/*.txt" ] && continue
    [ "$i" = "*/login.?" ] && continue
    [ "$i" = "*/*/login.?" ] && continue
    basnam=`basename "$i"`
    [ "$basnam" = "downloaded.txt" ] || rm -f "$i"
done
