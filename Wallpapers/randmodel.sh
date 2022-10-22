#!/bin/bash

TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"
[ -d "${TOP}" ] || {
  if [ -d /mac/pictures/Work/Wallhaven ]
  then
    TOP="/mac/pictures/Work/Wallhaven"
  else
    if [ -d /u/pictures/Wallhaven ]
    then
      TOP="/u/pictures/Wallhaven"
    else
      echo "Can't find Wallhaven download folder. Exiting."
      exit 1
    fi
  fi
}
MODEL_DIR=${TOP}/Models

[ "$1" == "-p" ] && MODEL_DIR=${TOP}/Photographers

[ -d $MODEL_DIR ] || {
    echo "$MODEL_DIR does not exist or is not a directory. Exiting."
    exit 1
}

cd $MODEL_DIR
a=( * )
((j=RANDOM%${#a[@]}))
randf="${a[j]}"
[ "$MODEL_DIR/$randf" == "$MODEL_DIR/*" ] && echo "Using $MODEL_DIR/$randf for backgrounds"
backgrounds "$randf"
