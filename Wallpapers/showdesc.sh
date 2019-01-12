#!/bin/bash

TOP="/Volumes/Seagate_BPH_8TB/Pictures/Work/Elite_Babes"
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
