#!/bin/bash

MODEL_DIR=/Volumes/Seagate_8TB/Pictures/Work/Wallhaven/Models

[ "$1" == "-p" ] && MODEL_DIR=/Volumes/Seagate_8TB/Pictures/Work/Wallhaven/Photographers

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
