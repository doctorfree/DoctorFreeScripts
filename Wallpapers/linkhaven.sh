#!/bin/bash

TOP="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven"
MOD="$TOP/Models"
PHO="$TOP/Photographers"
PHD="../../Photographers"
DIG="../../Digital_Desire"
MET="../../Met-Art"
DRO="../../Photodromm"
PEO="../../People"
DES="$PHD"
SUB="$MOD"
LN="ln -s"
ALL=
TELL=

usage() {
    printf "\nUsage: linkhaven [-a] [-d] [-h] [-m] [-n] [-p] [-P] [-r] [-u]"
    printf "\nWhere:"
    printf "\n\t-a indicates use all combinations of subdirs and destinations"
    printf "\n\t-d indicates use Digital_Desire destination dir"
    printf "\n\t-h indicates use hard links for duplicates"
    printf "\n\t\t(default is symbolic links)"
    printf "\n\t-m indicates use Met-Art destination"
    printf "\n\t-n indicates tell me what you would do but don't do it"
    printf "\n\t-p indicates use Photographers subdir"
    printf "\n\t-P indicates use People destination dir"
    printf "\n\t-r indicates use Photodromm destination dir"
    printf "\n\t\t(default destination dir is Digital_Desire)"
    printf "\n\t-u displays this usage message and exits"
    printf "\n\n"
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
            if [ "$DES" == "$PEO" ]
            then
                for wall in $PEO/*/$i
                do
                    [ "$wall" == "$PEO/*/$i" ] && continue
                    SRC=`dirname $wall`
                    break
                done
            fi
            [ -f $SRC/$i ] || {
                continue
            }
            [ "$TELL" ] && {
                echo "$LN $SRC/$i $model"
                continue
            }
            rm -f $i
            $LN $SRC/$i .
        done
        cd ..
    done
}

while getopts anmpPdu flag; do
    case $flag in
        a)
            ALL=1
            ;;
        d)
            DES="$DIG"
            ;;
        h)
            LN="ln"
            ;;
        m)
            DES="$MET"
            ;;
        n)
            TELL=1
            ;;
        p)
            SUB="$PHO"
            ;;
        P)
            DES="$PEO"
            ;;
        r)
            DES="$DRO"
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
    DES="$MET"
    linkem
    SUB="$PHO"
    linkem
    DES="$DRO"
    linkem
    DES="$PEO"
    linkem
    SUB="$MOD"
    linkem
    DES="$PHD"
    linkem
    DES="$PEO"
    linkem

else
    linkem
fi
