#!/bin/bash
#
## @file Wallpapers/mkbgdir.sh
## @brief Create a subdir of symlinks to a specified folder of wallpapers
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2018, Ronald Joe Record, all rights reserved.
## @date Written 18-Oct-2018
## @version 1.0.1
##

WHVN="/u/pictures/Wallhaven"
BACK="$HOME/Pictures/Backgrounds"

[ -d $BACK ] || {
    echo "$BACK does not exist or is not a directory. Exiting."
    exit 1
}
cd $BACK

linkem() {
    ln -s "$1"/* .
    rm -f *.txt
    rmportrait
}

for sub in $*
do
    [ -d $sub ] || mkdir $sub
    cd $sub
    if [ -d $WHVN/$sub ]
    then
        linkem $WHVN/$sub
    else
        if [ -d $WHVN/Models/$sub ]
        then
            linkem $WHVN/Models/$sub
        else
            if [ -d $WHVN/Photographers/$sub ]
            then
                linkem $WHVN/Photographers/$sub
            else
                echo "No Wallhaven folder found for $sub"
            fi
        fi
    fi
    cd ..
done
