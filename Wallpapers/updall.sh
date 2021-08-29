#!/bin/bash

TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven/Models"
KIND="/Volumes/Seagate_8TB/Pictures/Work/KindGirls"
HER=`pwd`

isportrait() {
    port=0
    GEO=`identify "$1" | awk ' { print $(NF-6) } '`
    W=`echo $GEO | awk -F "x" ' { print $1 } '`
    # Check if width not greater than 1000
    [ "$W" ] && [ $W -gt 1000 ] || {
        port=1
        return $port
    }
    H=`echo $GEO | awk -F "x" ' { print $2 } '`
    # Check if height not greater than 750
    [ "$H" ] && [ $H -gt 750 ] || {
        port=1
        return $port
    }
    # Check if width not greater than height
    [ "$W" ] && [ "$H" ] && [ $W -gt $H ] || {
        port=1
        return $port
    }
    return $port
}

# Update any existing plain files to symlinks if possible
for folder in *
do
    [ "$folder" == "*" ] && continue
    [ -d $folder ] || continue
    cd $folder
    for img in *
    do
        [ "$img" == "*" ] && continue
        [ -L $img ] && continue
        if [ -f $TOP/$folder/$img ]
        then
            rm -f $img
            ln -s $TOP/$folder/$img .
        else
            [ -f $KIND/$folder/$img ] && {
                rm -f $img
                ln -s $KIND/$folder/$img .
            }
        fi
    done
    cd ..
done

# Identify any newly added files and create symlinks
for folder in *
do
    [ "$folder" == "*" ] && continue
    [ -d $folder ] || continue
    [ -d $TOP/$folder ] && {
        echo "Checking $TOP/$folder for newly added files"
        cd $TOP/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $TOP/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $KIND/$folder ] && {
        echo "Checking $KIND/$folder for newly added files"
        cd $KIND/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $KIND/$folder/$img $HER/$folder/$img
            fi
        done
    }
    cd $HER
done
