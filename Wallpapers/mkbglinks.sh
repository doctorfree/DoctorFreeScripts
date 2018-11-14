#!/bin/bash
#
TOP="/u/pictures"
WHVN="$TOP/Wallhaven"
FMJY="$TOP/Femjoy"
XART="$TOP/X-Art"
BACK="$HOME/Pictures/Backgrounds/Misc/Favs"

[ -d $BACK ] || {
    echo "$BACK does not exist or is not a directory. Exiting."
    exit 1
}
cd $BACK

for i in wallhaven* femjoy* x-art*
do
    [ -L $i ] && continue
    [ "$i" == "wallhaven*" ] && continue
    [ "$i" == "femjoy*" ] && continue
    [ "$i" == "x-art*" ] && continue
    found=
    # First check Wallhaven Models
    for pic in $WHVN/Models/*/$i
    do
        [ "$pic" == "$WHVN/Models/*/$i" ] && break
        rm -f $i
        ln -s $pic .
        found=1
        break
    done
    [ "$found" ] || {
        # Next check these Wallhaven subdirs
        for subdir in Sakimichan Tuigirl Legs General
        do
            [ -f $WHVN/$subdir/$i ] && {
                rm -f $i
                ln -s $WHVN/$subdir/$i .
                found=1
                break
            }
        done
    }
    [ "$found" ] || {
        # Next check Femjoy subdirs
        for pic in $FMJY/*/*/$i
        do
            [ "$pic" == "$FMJY/*/*/$i" ] && break
            rm -f $i
            ln -s $pic .
            found=1
            break
        done
    }
    [ "$found" ] || {
        # Finally check X-Art subdirs
        for pic in $XART/*/*/$i
        do
            [ "$pic" == "$XART/*/*/$i" ] && break
            rm -f $i
            ln -s $pic .
            found=1
            break
        done
    }
done
