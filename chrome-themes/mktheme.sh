#!/bin/bash
#
# mktheme - create a Google Chrome theme using a specified background image
#     and corresponding manifest, theme images, private key, etc.
#
# Written 24-Apr-2016 by Ronald Joe Record <themes at ronrecord dot com>
#
# Copyright (c) 2016, Ronald Joe Record
# All rights reserved.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.

BASE="$HOME/Documents/My Documents/ronrecord.com/httpdocs/Themes/Chrome"
BASE_DIR="${BASE}"
BACK="${BASE}/Backgrounds"
BACK_DIR="${BACK}"
MANI="${BASE}/Manifests"
IMAG="${BASE}/Images"
ICON="${BASE}/Icons/Icon_128.png"
SUFF="png"
ALL=
REM=
SEM=
INQ=
ZIP=

usage() {
    printf "Usage: mktheme [-a] [-B /full/path/to/base_dir] \n"
    printf "\t\t[-b relative_base_dir] [-i] [-r] [-s] [-u] [-z]\n"
    printf "Where:\n\t-a indicates use all backgrounds/themes\n"
    printf "\t-b <dir> specifies a subdir of the base dir to use\n"
    printf "\t-B </path/to/dir> specifies the full path to the base dir\n"
    printf "\t-i indicates inquire which themes are done, need to be done\n"
    printf "\t-r indicates remove the specified generated themes\n"
    printf "\t-s indicates use the seamless backgrounds\n"
    printf "\t-z indicates create zip file(s) of themes for upload\n"
    printf "\t-u indicates display this usage message\n"
    exit 1
}

while getopts aB:b:irsuz flag; do
    case $flag in
        a)
            ALL=1
            ;;
        B)
            BASE_DIR="$OPTARG"
            ;;
        b)
            BASE_DIR="${BASE}/$OPTARG"
            ;;
        i)
            INQ=1
            ;;
        r)
            REM=1
            ;;
        s)
            SEM=1
            BACK_DIR="${BACK}/Seamless"
            ;;
        z)
            ZIP=1
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$INQ" ] && {
    for back in "${BACK_DIR}"/*.${SUFF}
    do
        base=`basename "$back"`
        name=`echo $base | sed -e "s/\.${SUFF}//"`
        if [ -d "${BASE_DIR}/${name}" ]
        then
            echo "Theme directory ${name} already exists."
        else
            if [ -f "${MANI}/${name}.json" ]
            then
                echo "Existing manifest for ${name}"
            else
                echo "No existing manifest for ${name}"
            fi
            if [ -d "${IMAG}/${name}" ]
            then
                echo "Existing images for ${name}"
            else
                echo "No existing images for ${name}"
            fi
        fi
    done
    exit 0
}

if [ "$ALL" ]
then
    if [ "$REM" ]
    then
        for back in "${BACK_DIR}"/*.${SUFF}
        do
            base=`basename "$back"`
            name=`echo $base | sed -e "s/\.${SUFF}//"`
            [ -d "${BASE_DIR}/${name}" ] && rm -rf "${BASE_DIR}/${name}"
        done
    else
        for back in "$BACK_DIR"/*.${SUFF}
        do
            base=`basename "$back"`
            name=`echo $base | sed -e "s/\.${SUFF}//"`
            themes="$name $themes"
        done
    fi
else
    themes="$*"
fi
CUR_DIR=`pwd`
for theme in $themes
do
    [ -f "${BACK_DIR}/${theme}.${SUFF}" ] || {
        echo "Could not find ${BACK_DIR}/$1.${SUFF}. Skipping."
        continue
    }
    theme_dir="${BASE_DIR}/${theme}"
    image_dir="${theme_dir}/images"
    [ -d "${theme_dir}" ] && {
        echo "${theme_dir} exists. Skipping."
        continue
    }
    echo "Creating ${theme} Google Chrome theme."
    mkdir "${theme_dir}"
    if [ -f "${MANI}/${theme}.json" ]
    then
        echo "Copying existing manifest for ${theme}"
        cp "${MANI}/${theme}.json" "${theme_dir}/manifest.json"
    else
        echo "Copying default manifest for ${theme}"
        cp "${MANI}/Default.json" "${theme_dir}/manifest.json"
    fi
    mkdir "${image_dir}"
    if [ -d "${IMAG}/${theme}" ]
    then
        echo "Copying existing images for ${theme}"
        cp "${IMAG}/${theme}"/*.png "${image_dir}"
    else
        echo "Copying default images for ${theme}"
        cp "${IMAG}/Default"/*.png "${image_dir}"
    fi
    cp "${BACK_DIR}/${theme}.${SUFF}" \
       "${image_dir}"/ntp_background.${SUFF}
    cp "${ICON}" "${theme_dir}"/icon_128.png
    # If there is a private key for this theme, copy it into the theme dir
    # [ -f "${BASE_DIR}/Keys/${theme}.pem" ] && {
    #     echo "Copying private key for ${theme}"
    #     cp "${BASE_DIR}/Keys/${theme}.pem" "${theme_dir}"/key.pem
    # }
    [ "$ZIP" ] && {
        echo "Zipping ${theme}"
        cd "${BASE_DIR}"
        zip -q -r ${theme}.zip ${theme}
        cd "$CUR_DIR"
    }
done
