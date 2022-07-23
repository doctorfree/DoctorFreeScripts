#!/bin/bash
#
# transwall.sh - use imagemagick to create a transparent list on walllpaper

WALLDIR="$HOME/Pictures/Wallpaper"
NOTES="$HOME/Documents/Notes/notes.md"
WALLPAPER="$HOME/Pictures/wallpaper"

usage() {
    printf "\nUsage: transwall [-r] [-t] [-c] [-u]"
    printf "\nWhere:"
    printf "\n\t-r indicates random wallpaper"
    printf "\n\t-t indicates wallpaper text"
    printf "\n\t-c indicates certain wallpaper text"
    printf "\n\t-u displays this usage message and exits\n"
    exit 1
}

convwall() {
    convert -geometry "x1080"\
            -fill '#00000099'\
            -draw "rectangle 50,50 530,1030"\
            -pointsize 20 \
            -fill '#ffff00'\
            -font 'FreeMono' \
            -pointsize '20' \
            -draw "text 70,100 '$notes'" \
            "$1" "${WALLPAPER}"
}

certwall=
randwall=
pickwall=
textwall=
[ "$1" == "" ] && pickwall=1
while getopts "crstu" flag; do
    case $flag in
        c)
            certwall=1
            ;;
        r)
            randwall=1
            ;;
        s)
            pickwall=1
            ;;
        t)
            textwall=1
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

randomwall=$(ls -1 "${WALLDIR}" | shuf -n 1)
notes=$(< "${NOTES}")

[ "${randwall}" ] && {
   cp "${WALLDIR}/$randomwall" "${WALLPAPER}"
}

[ "${pickwall}" ] && {
    certain=$(cd "${WALLDIR}" && ls | dmenu -l 15 -fn "xo4 Terminus:size=9" -i -p "Choose wall:")
    cp "${WALLDIR}/$certain" "${WALLPAPER}"
 }

[ "${certwall}" ] && {
    certain=$(cd "${WALLDIR}" && ls | dmenu -l 15 -fn "xo4 Terminus:size=9" -i -p "Choose wall:")
    convwall "${WALLDIR}/$certain"
 }

[ "${textwall}" ] && {
    convwall "${WALLDIR}/$randomwall"
 }

feh --bg-scale ${WALLPAPER}
