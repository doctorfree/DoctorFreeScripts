#!/bin/bash

MODEL_DIR=/u/pictures/Wallhaven/Models

[ "$1" == "-p" ] && MODEL_DIR=/u/pictures/Wallhaven/Photographers

[ -d $MODEL_DIR ] || {
    echo "$MODEL_DIR does not exist or is not a directory. Exiting."
    exit 1
}

cd $MODEL_DIR
a=( * )
((j=RANDOM%${#a[@]}))
randf="${a[j]}"
#echo "Using $MODEL_DIR/$randf for backgrounds"
backgrounds "$randf"
