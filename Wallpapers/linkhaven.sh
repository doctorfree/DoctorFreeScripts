#!/bin/bash

TOP="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven"
MOD="$TOP/Models"
PHO="$TOP/Photographers"
PHD="../../Photographers"
DIG="../../Digital_Desire"
DRO="../../Photodromm"
DES="$DIG"
SUB="$MOD"
ALL=
TELL=

usage() {
    echo "Usage: linkhaven [-a] [-n] [-p] [-P] [-d] [-u]"
    exit 1
}

linkem() {
    cd $SUB
    for model in *
    do
        [ -d $model ] || continue
        cd $model
        for i in wall*
        do
            [ -L $i ] && continue
            SRC="$DES"
            if [ "$DES" == "$PHD" ]
            then
                for wall in $PHD/*/$i
                do
                    [ "$wall" == "$PHD/*/$i" ] && continue
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
}

while getopts anmpPdu flag; do
    case $flag in
        a)
            ALL=1
            ;;
        P)
            DES="$PHD"
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

if [ "$ALL" ]
then
    DES="$DIG"
    SUB="$MOD"
    linkem
    SUB="$PHO"
    linkem
    DES="$DRO"
    linkem
    SUB="$MOD"
    linkem
    DES="$PHD"
    linkem

else
    linkem
fi
