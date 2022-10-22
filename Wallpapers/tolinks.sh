#!/bin/bash

TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven/Models"
[ -d "${TOP}" ] || {
  if [ -d /mac/pictures/Work/Wallhaven/Models ]
  then
    TOP="/mac/pictures/Work/Wallhaven/Models"
  else
    if [ -d /u/pictures/Wallhaven/Models ]
    then
      TOP="/u/pictures/Wallhaven/Models"
    else
      echo "Can't find Wallhaven download folder. Exiting."
      exit 1
    fi
  fi
}

for folder in *
do
    [ -d $folder ] || continue
    cd $folder
    for img in *
    do
        [ -L $img ] && continue
        [ -f $TOP/$folder/$img ] && {
            rm -f $img
            ln -s $TOP/$folder/$img .
        }
    done
    cd ..
done
