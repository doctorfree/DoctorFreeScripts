#!/bin/bash

cd People

find . -type l | while read i
do
    ls -lL "$i" > /dev/null 2>&1
    [ $? -eq 0 ] || {
        target=`ls -l "$i" | awk ' { print $11 } '`
        echo "$i target is $target"
        [ -f $target ] && {
            echo "Removing and relinking to ../$target"
            rm -f "$i"
            cd `dirname $i`
            ln -s ../$target .
            cd ..
        }
    }
done
