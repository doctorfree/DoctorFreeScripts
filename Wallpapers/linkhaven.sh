#!/bin/bash

TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"

# Subdirs with model name subdirs
JAP="$TOP/Japanese"
MOD="$TOP/Models"
PHO="$TOP/Photographers"
SUI="$TOP/Suicide_Girls"

# Largest top-level subdirs
LTL="Ass Breasts Fantasy_Art Group_of_Women Legs Long_Hair \
     Nature Panties Pubic_Hair Shaved Women_Outdoors"

PHD="../../Photographers"
DIG="../../Digital_Desire"
BDS="../../Bella_da_Semana"
BAB="../../Babes.com"
CHK="../../Czech"
DOM="../../Domai"
FEM="../../Femjoy"
JAV="../JAV_Idol"
MET="../../Met-Art"
DRO="../../Photodromm"
PLA="../../Playboy"
RUS="../../Russian"
STQ="../../Stasy_Q"
UKR="../../Ukrainian"
W4B="../../Watch4Beauty"
DES="$PHD"
SUB="$MOD"
LN="ln -s"
ALL=
BIG=
TELL=

usage() {
  printf "\nUsage: linkhaven [-a] [-bBcCdD] [-f] [-h] [-j] [-m] [-n] [-pP] [-rsS] [-uU] [-wz]"
  printf "\nWhere:"
  printf "\n\t-a indicates use all combinations of subdirs and destinations"
  printf "\n\t-b indicates use Playboy destination dir"
  printf "\n\t-B indicates use Bella_da_Semana destination dir"
  printf "\n\t-c indicates use Czech destination dir"
  printf "\n\t-d indicates use Domai destination dir"
  printf "\n\t-D indicates use Digital_Desire destination dir"
  printf "\n\t-f indicates use Femjoy destination dir"
  printf "\n\t-h indicates use hard links for duplicates"
  printf "\n\t\t(default is symbolic links)"
  printf "\n\t-j indicates use Japanese destination dir"
  printf "\n\t-m indicates use Met-Art destination"
  printf "\n\t-n indicates tell me what you would do but don't do it"
  printf "\n\t-p indicates use Photographers subdir"
  printf "\n\t-P indicates use Photodromm destination dir"
  printf "\n\t-r indicates use Russian destination dir"
  printf "\n\t-s indicates use Stasy Q destination dir"
  printf "\n\t-S indicates use Suicide Girls subdir"
  printf "\n\t-U indicates use Ukrainian destination dir"
  printf "\n\t\t(default destination dir is Digital_Desire)"
  printf "\n\t-w indicates use Watch4Beauty destination dir"
  printf "\n\t-z indicates do largest subdirs"
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
            [ -f "$SRC/$i" ] || continue
            [ -L "$SRC/$i" ] && continue
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

do_big() {
    echo "Linking in largest top-level subdirs:"
    for ltl in $LTL
    do
        echo "Linking in $ltl"
        cd $TOP/$ltl
        for pic in wall*
        do
            [ -L $pic ] && continue
            for dir in $LTL
            do
                [ "$dir" == "$ltl" ] && continue
                [ -f "../$dir/$pic" ] || continue
                [ -L "../$dir/$pic" ] && continue
                [ "$TELL" ] && {
                    echo "$LN ../$dir/$pic $ltl"
                }
                rm -f $pic
                $LN ../$dir/$pic .
                break
            done
        done
    done
}

while getopts abcdfhjnmprsBDPSwzUu flag; do
    case $flag in
        a)
            ALL=1
            ;;
        b)
            DES="$PLA"
            ;;
        B)
            DES="$BDS"
            ;;
        c)
            DES="$CHK"
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
            DES="$DRO"
            ;;
        r)
            DES="$RUS"
            ;;
        s)
            DES="$STQ"
            ;;
        S)
            DES="$PHD"
            SUB="$SUI"
            ;;
        U)
            DES="$UKR"
            ;;
        w)
            DES="$W4B"
            ;;
        z)
            BIG=1
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
# BDS="../../Bella_da_Semana"
# BAB="../../Babes.com"
# CHK="../../Czech"
# DOM="../../Domai"
# FEM="../../Femjoy"
# MET="../../Met-Art"
# DRO="../../Photodromm"
# PLA="../../Playboy"
# RUS="../../Russian"
# STQ="../../Stasy_Q"
# UKR="../../Ukrainian"
# W4B="../../Watch4Beauty"
if [ "$ALL" ]
then
    SUB="$MOD"
    for dest in "$PHD" "$BDS" "$BAB" "$CHK" "$DIG" "$DOM" "$FEM" "$MET" "$DRO" "$PLA" "$RUS" "$STQ" "$UKR" "$W4B"
    do
        DES="$dest"
        linkem
    done
    SUB="$PHO"
    for dest in "$BDS" "$BAB" "$CHK" "$DIG" "$DOM" "$FEM" "$MET" "$DRO" "$PLA" "$RUS" "$STQ" "$UKR" "$W4B"
    do
        DES="$dest"
        linkem
    done
    SUB="$SUI"
    for dest in "$BDS" "$BAB" "$CHK" "$DIG" "$DOM" "$FEM" "$MET" "$DRO" "$PLA" "$RUS" "$STQ" "$UKR" "$W4B"
    do
        DES="$dest"
        linkem
    done
    DES="$JAV"
    SUB="$JAP"
    linkem
    do_big
else
    [ "$BIG" ] && do_big
    linkem
fi
