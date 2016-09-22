#!/bin/bash

rm -f broken.txt
touch broken.txt
find . -type l | while read i
do
    ls -lL "$i" > /dev/null 2>&1
    [ $? -eq 0 ] || {
        printf "\nBroken symbolic link: $i"
        echo "$i" >> broken.txt
    }
done
