#!/bin/bash

DIR=/usr/local/share/backgrounds
FLOOR=1
RANGE=`ls -1 "$DIR"/*.jpg | wc | awk '// {print $1}'`

number=0

while [ 1 -eq 1 ]; do
  
   number=$RANDOM
   while [ "$number" -le $FLOOR ]; do
        number=$RANDOM
   done
   let "number %= $RANGE"  # Scales $number down within $RANGE.
   COUNTER=1
   for X in "$DIR"/*.jpg
   do
      if [ $number -eq $COUNTER ]; then
         pcmanfm --set-wallpaper "$X"
      fi
   COUNTER=$(($COUNTER+1))
   done
   COUNTER=1
   sleep 10
done
