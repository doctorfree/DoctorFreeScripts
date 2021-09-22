#!/bin/sh
#
# xnvslides - Applescript to open XnViewMP and start a slideshow
#
# Written 20-Sep-2021 by Ronald Joe Record <rr at ronrecord dot com>
#
# Copyright (c) 2015, Ronald Joe Record
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
#
# Set these to your default slideshow image folder and default model name
TOP="/Volumes/Seagate_8TB/Pictures/Work"
SUB="Wallhaven"
DEF_MODEL="Models/Carisha"
PICD="${TOP}/${SUB}/${DEF_MODEL}"

# Set Model and Photographer top dirs before processing arguments
MOD_TOP="${TOP}/Wallhaven/Models"
PHO_TOP="${TOP}/Wallhaven/Photographers"
PRE_TOP=$HOME/Pictures/Work/Backgrounds
  
osa=
subdir=
foundirs=
updpre=
list=
showprep=

usage() {
  printf "\nUsage: xnvslides [-u] [-lpP] [-s subdir] directory"
  printf "\n\t-l indicates list files in specified slideshow folder"
  printf "\n\t-L indicates list files in specified slideshow folder and show prepared folders"
  printf "\n\t-p indicates search for slideshow folder in desktop background folders"
  printf "\n\t-P indicates search for slideshow folder in desktop background folders and update"
  printf "\n\t-s <subdir> searches in $TOP/<subdir>"
  printf "\n\t\tKeywords:\n\t\t\telite\n\t\t\tfractals"
  printf "\n\t\t\tjp\n\t\t\tkind\n\t\t\tmodels\n\t\t\twhvn\n\t\t\txart"
  printf "\n\t-u displays this usage message and exits"
  printf "\n\nNote 1: The specified slideshow folder must contain images, not subfolders of images"
  printf "\nNote 2: XnView keyboard shortcuts must be configured with Slideshow shortcut Ctrl-Alt-S"
  printf "\n\tXnView -> Preferences -> Interface -> Shortcuts\n\n"
  exit 1
}

while getopts lLpPs:u flag; do
    case $flag in
        l)
            list=1
            ;;
        L)
            showprep=1
            list=1
            ;;
        p)
            TOP=$PRE_TOP
            foundirs="$TOP"
            ;;
        P)
            TOP=$PRE_TOP
            foundirs="$TOP"
            updpre=1
            ;;
        s)
            case "$OPTARG" in
              elite) subdir="Elite_Babes"
                ;;
              fractals) subdir="Fractals"
                ;;
              jp) subdir="JP_Erotica"
                ;;
              kind) subdir="KindGirls"
                ;;
              models) subdir="Wallhaven/Models"
                ;;
              whvn) subdir="Wallhaven"
                ;;
              xart) subdir="X-Art"
                ;;
              *) subdir="$OPTARG"
                ;;
            esac
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

inst=`type -p osascript`
[ "$inst" ] || {
    echo "AppleScript in shell script is not supported on this platform. Exiting."
    usage
}

if [ "$1" ]
then
    mdir="$1"
else
    mdir=${DEF_MODEL}
fi

if [ "$subdir" ]
then
    [ -d "$TOP/$subdir/$mdir" ] || {
      if [ "$list" ]
      then
        echo "Cannot locate $TOP/$subdir/$mdir"
      else
        echo "Cannot locate $TOP/$subdir/$mdir - exiting."
        exit 1
      fi
    }
    TOP="$TOP/$subdir"
    foundirs="$TOP"
else
    [ -d "$TOP/$mdir" ] || {
        [ "$updpre" ] && mkdir "$TOP/$mdir"
        for subdir in Wallhaven Wallhaven/Models Wallhaven/Photographers X-Art Elite_Babes JP_Erotica Met-Art KindGirls Wallbase
        do
          [ -d "$TOP/$subdir/$mdir" ] && {
            foundirs="$TOP/$subdir"
            break
          }
        done
        TOP=$foundirs
    }
fi

PICD="$TOP/$mdir"
if [ -d "$TOP/$mdir" ]
then
    echo "Using slideshow folder $TOP/$mdir"
else
    [ "$list" ] || exit 1
fi

[ "$list" ] && {
    if [ -d "$PICD" ]
    then
        numprep=`ls -1 $PICD | wc -l`
        ls -lL $PICD | grep -v 'total\|downloaded.txt\|SUMS.txt\|Description.txt\|todo' | awk ' { print $NF } '
    else
        numprep=0
    fi
    echo "$numprep files or directories in $PICD"
    echo ""
    for i in $PICD/*
    do
        [ -d "$i" ] && {
            echo "WARNING: Specified slideshow folder contains one or more subdirectories"
            echo "Subdirectories of images must be specified on the command line"
            j=`basename $i`
            echo "e.g. $mdir/$j"
            break
        }
    done
    echo ""
    [ "$showprep" ] || exit 0
}
[ "$showprep" ] && {
    echo "Prepared folders in $TOP :"
    echo ""
    prepfolders=
    for folder in $TOP/*
    do
        [ "$folder" == "$TOP/*" ] && continue
        [ -d "$folder" ] && {
            prepmod=`basename "$folder"`
            prepfolders="$prepfolders  $prepmod"
        }
    done
    echo "$prepfolders" | sed -e "s/  //"
    exit 0
}

open -a XnViewMP ${PICD}
osascript <<EOF
    delay 5
    tell application "System Events"
        keystroke "a" using {command down}
        delay 3
        key code 36
        delay 3
        keystroke "s" using {option down, command down}
        delay 3
        key code 36
        delay 3
        keystroke "f" using {option down, command down}
    end tell
EOF

