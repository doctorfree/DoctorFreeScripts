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
    echo "Usage: linkhaven [-n] [-p] [-P] [-d] [-u]"
    exit 1
}

while getopts nmpPdu flag; do
    case $flag in
        P)
            DES="$PHO"
            ;;
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
        [ -L $i ] && continue
        SRC="$DES"
        if [ "$DES" == "$PHO" ]
        then
            for wall in $PHO/*/$i
            do
                [ "$wall" == "$PHO/*/$i" ] && continue
                SRC=`dirname $wall`
                break
            done
        fi
        [ -f $SRC/$i ] || {
            continue
        }
        [ "$TELL" ] && {
            echo "ln -s $SRC/$i $model"
            continue
        }
        rm -f $i
        ln -s $SRC/$i .
    done
    cd ..
done
