#!/bin/bash

TOP="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven"
MOD="$TOP/Models"
PHO="$TOP/Photographers"
DIG="../../Digital_Desire"
DRO="../../Photodromm"
DES="$DIG"
SUB="$MOD"
TELL=

usage() {
    echo "Usage: linkhaven [-n] [-p] [-d] [-u]"
    exit 1
}

while getopts nmpdu flag; do
    case $flag in
        d)
            DES="$DRO"
            ;;
        n)
            TELL=1
            ;;
        p)
            SUB="$PHO"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

cd $SUB
for model in *
do
    [ -d $model ] || continue
    cd $model
    for i in wall*
    do
        [ -f $DES/$i ] || {
            continue
        }
        [ -L $i ] && continue
        [ "$TELL" ] && {
            echo "ln -s $DES/$i $model"
            continue
        }
        rm -f $i
        ln -s $DES/$i .
    done
    cd ..
done
