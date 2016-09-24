#!/bin/bash
#
## @file chrome-themes/mkscreen.sh
## @brief Create screenshots for Chrome themes
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 29-Apr-2016
## @version 1.0.1
##

BASE="$HOME/Documents/My Documents/ronrecord.com/httpdocs/Themes/Chrome"
INPD="${BASE}/html"
OUTD="${BASE}/Screenshots"

if [ "$1" = "-a" ]
then
    if [ "$2" = "-r" ]
    then
        for them in "$INPD"/*
        do
            name=`basename "${them}"`
            rm -f "${OUTD}/${name}"/Screenshot_?.png
        done
    else
        for them in "$INPD"/*
        do
            [ -d "${them}" ] || continue
            name=`basename "${them}"`
            themes="$name $themes"
        done
    fi
else
    themes="$*"
fi

[ -d "${OUTD}" ] || mkdir "${OUTD}"
for theme in $themes
do
    theme_dir="${INPD}/${theme}"
    [ -f "${theme_dir}/${theme}_Screen1.png" ] || {
        echo "Could not find ${theme_dir}/${theme}_Screen1.png. Skipping."
        continue
    }
    echo "Creating ${theme} Google Chrome theme screenshots."
    [ -d "${OUTD}/${theme}" ] || mkdir "${OUTD}/${theme}"
    convert -geometry 1280x800\! "${theme_dir}/${theme}_Screen1.png" \
                               "${OUTD}/${theme}/Screenshot_1.png"
    convert -geometry 1280x800\! "${theme_dir}/${theme}_Screen2.png" \
                               "${OUTD}/${theme}/Screenshot_2.png"
done
