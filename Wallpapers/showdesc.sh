#!/bin/bash

DES="Description.txt"
model=`echo "$*" | sed -e "s/ /_/g"`
matchnum=0

showdesc() {
    [ -f "${TOP}"/"$1"/"$DES" ] || {
        echo "No model description for model name $1 found."
        [ "$2" == "1" ] && exit 1
        return
    }
    [ $matchnum -eq 0 ] || {
        echo "Matching Model Description #${matchnum}:"
        echo "------------------------------"
    }
    cat "${TOP}"/"$1"/"$DES"
    echo ""
}

# Which system are we on?
WORK="Work/Elite_Babes"
if [ -d /Volumes/Seagate_8TB/Pictures/$WORK ]
then
    TOP="/Volumes/Seagate_8TB/Pictures/$WORK"
else
    if [ -d /u/pictures ]
    then
        TOP="/u/pictures/$WORK"
    else
        echo "Cannot determine top-level photo dir. Exiting."
        exit 1
    fi
fi

[ "$model" ] || {
    echo "Usage: showdesc model_name"
    exit 1
}

[ -d "${TOP}"/"$model" ] || {
    # Maybe only the first part of the model name was given
    foundit=
    for maybe in "${TOP}"/"${model}"*
    do
        [ "$maybe" == "${TOP}"/"${model}*" ] && continue
        [ -d "$maybe" ] && {
            model=`basename "$maybe"`
            foundit=1
            matchnum=`expr $matchnum + 1`
            showdesc "$model" 0
        }
    done
    [ "$foundit" ] || {
        echo "No model folder for model name $model found. Exiting."
        exit 1
    }
    exit 0
}

showdesc "$model" 1
