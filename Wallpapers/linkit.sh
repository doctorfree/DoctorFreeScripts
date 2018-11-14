#!/bin/bash
#
# linkit <num> <num> ...

TOP=/u/pictures
WHVN="$TOP/Wallhaven"
FMJY="$TOP/Femjoy
XART="$TOP/X-Art"
FAVS="$HOME/Pictures/Backgrounds/Favs"

[ -d "${FAVS}" ] || {
    echo "${FAVS} does not exist or is not a directory. Exiting."
    exit 1
}
cd "${FAVS}"

for num in $*
do
    for PIC in ${WHVN}/*/wallhaven-${num}.jpg ${WHVN}/Models/*/wallhaven-${num}.jpg \
               ${FMJY}/*/*/femjoy_${num}.jpg ${XART}/*/*/x-art-${num}.jpg
    do
        [ "$PIC" == "${WHVN}/*/wallhaven-${num}.jpg" ] && continue
        [ "$PIC" == "${WHVN}/Models/*/wallhaven-${num}.jpg" ] && continue
        [ "$PIC" == "${FMJY}/*/*/femjoy_${num}.jpg" ] && continue
        [ "$PIC" == "${XART}/*/*/x-art-${num}.jpg" ] && continue
        if [ -r ${PIC} ]
        then
            break
        else
            PNG=`echo $PIC | sed -e "s/\.jpg/.png/"`
            [ -r ${PNG} ] && {
                PIC=${PNG}
                break
            }
        fi
    done
    [ -r ${PIC} ] || {
        echo "Cannot locate wallpaper for ${num}. Skipping."
        continue
    }
    IMG=`basename ${PIC}`
    [ -L ${IMG} ] && {
        echo "Symbolic link for ${IMG} already exists."
        continue
    }
    echo "Linking ${PIC} as favorite"
    ln -s ${PIC} .
done
