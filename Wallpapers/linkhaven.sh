#!/bin/bash

TOP="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven"
JAP="$TOP/Japanese"
MOD="$TOP/Models"
PHO="$TOP/Photographers"
SUG="$TOP/Suicide_Girls"
SGD="../Misc"
PHD="../../Photographers"
DIG="../../Digital_Desire"
DOM="../../Domai"
FEM="../../Femjoy"
JAV="../JAV_Idol"
MET="../../Met-Art"
DRO="../../Photodromm"
W4B="../../Watch4Beauty"
PEO="../../People"
DES="$PHD"
SUB="$MOD"
LN="ln -s"
ALL=
TELL=

usage() {
  printf "\nUsage: linkhaven [-a] [-dD] [-f] [-h] [-j] [-m] [-n] [-psP] [-r] [-u] [-w]"
  printf "\nWhere:"
  printf "\n\t-a indicates use all combinations of subdirs and destinations"
  printf "\n\t-D indicates use Digital_Desire destination dir"
  printf "\n\t-d indicates use Domai destination dir"
  printf "\n\t-f indicates use Femjoy destination dir"
  printf "\n\t-h indicates use hard links for duplicates"
  printf "\n\t\t(default is symbolic links)"
  printf "\n\t-j indicates use Japanese destination dir"
  printf "\n\t-m indicates use Met-Art destination"
  printf "\n\t-n indicates tell me what you would do but don't do it"
  printf "\n\t-p indicates use Photographers subdir"
  printf "\n\t-P indicates use People destination dir"
  printf "\n\t-r indicates use Photodromm destination dir"
  printf "\n\t\t(default destination dir is Digital_Desire)"
  printf "\n\t-s indicates use Suicide Girls subdir"
  printf "\n\t-w indicates use Watch4Beauty destination dir"
  printf "\n\t-u displays this usage message and exits"
  printf "\n\n"
  exit 1
}

linkem() {
    printf "Linking in $SUB to $DES ..."
    cd $SUB
    for model in *
    do
        [ -d $model ] || continue
        [ "$SUB" == "$SUG" ] && [ "$model" == "Misc" ] && continue
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
                    [ -L "$SRC" ] && {
                        SRC="$DES"
                        continue
                    }
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
            [ -f "$SRC/$i" ] || {
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
    printf "\n"
}

while getopts adfhjnmprPDswu flag; do
    case $flag in
        a)
            ALL=1
            ;;
        d)
            DES="$DOM"
            ;;
        D)
            DES="$DIG"
            ;;
        f)
            DES="$FEM"
            ;;
        h)
            LN="ln"
            ;;
        j)
            DES="$JAV"
            SUB="$JAP"
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
        s)
            SUB="$SUG"
            DES="$SGD"
            ;;
        w)
            DES="$W4B"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))
printf "\n"

# The destinations
# PHD="../../Photographers"
# DIG="../../Digital_Desire"
# DOM="../../Domai"
# FEM="../../Femjoy"
# MET="../../Met-Art"
# DRO="../../Photodromm"
# PEO="../../People"
# W4B="../../Watch4Beauty"
if [ "$ALL" ]
then
    SUB="$MOD"
    for dest in "$PHD" "$DIG" "$DOM" "$FEM" "$MET" "$DRO" "$PEO" "$W4B"
    do
        DES="$dest"
        linkem
    done
    SUB="$PHO"
    for dest in "$DIG" "$DOM" "$FEM" "$MET" "$DRO" "$PEO" "$W4B"
    do
        DES="$dest"
        linkem
    done
    SUB="$SUG"
    DES="$SGD"
    linkem
    DES="$JAV"
    SUB="$JAP"
    linkem
else
    linkem
fi
