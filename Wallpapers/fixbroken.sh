#!/bin/bash
#
## @file Wallpapers/fixbroken.sh
## @brief Remove or repair broken symbolic links listed in broken.txt
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

HERE=`pwd`
WALL=`basename "$HERE"`

[ -f broken.txt ] || {
    echo "No file broken.txt in $HERE"
    echo "Run findbroken to create this file"
    echo "Exiting without repairing or removing broken symbolic links"
    exit 1
}

printf "\nRemoving broken symbolic links in $HERE\n"
while read broken
do
    [ -L "$broken" ] || {
        echo "$broken already removed or not a symbolic link - skipping"
        continue
    }
    target=`basename $broken`
    found=
    for dir in *
    do
        [ -f "$dir"/$target ] && {
            [ ! -L "$dir"/$target ] && {
                found="$dir/$target"
                break
            }
        }
    done
    [ "$found" ] || {
        # Check for a plain file in People, Photographers, and Models subdirs
        for dir in Models/* People/* Photographers/*
        do
            [ -f "$dir"/$target ] && {
                [ ! -L "$dir"/$target ] && {
                    found="$dir/$target"
                    break
                }
            }
        done
    }
    [ "$found" ] || {
        echo "Removing $broken"
        rm -f "$broken"
        continue
    }
    printf "Removing and relinking $broken to $found\n"
    rm -f "$broken"
    sdir=`dirname $broken`
    cd "$sdir"
    relative=""
    numdots=0
    while [ $numdots -lt 4 ]
    do
        relative="../$relative"
        [ -f "${relative}${found}" ] && {
            ln -s "${relative}${found}" .
            break
        }
        numdots=`expr $numdots + 1`
        [ $numdots -eq 4 ] && {
            echo "Could not find $found from $sdir"
        }
    done
    cd "$HERE"
done < broken.txt
printf "\n"
