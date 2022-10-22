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
[ -d "${TOP}" ] || {
  if [ -d /mac/pictures/Work ]
  then
    TOP="/mac/pictures/Work"
  else
    if [ -d /u/pictures ]
    then
      TOP="/u/pictures"
    else
      echo "Can't find Wallhaven download folder. Exiting."
      exit 1
    fi
  fi
}
ALT_TOP="/Volumes/My_Book_Studio/Pictures/Work"
SUB="Wallhaven"
DEF_MODEL="Models/Alisa_I"
PICD="${TOP}/${SUB}/${DEF_MODEL}"

# Set Model and Photographer top dirs before processing arguments
MOD_TOP="${TOP}/${SUB}/Models"
PHO_TOP="${TOP}/${SUB}/Photographers"
PRE_TOP=$HOME/Pictures/Work/Backgrounds
  
osa=
subdir=
foundirs=
has_subdir=false
updpre=
list=
showprep=
subsubdirs=

usage() {
  printf "\nUsage: xnvslides [-u] [-lpP] [-s subdir] directory"
  printf "\n\t-l indicates list files in specified slideshow folder"
  printf "\n\t-L indicates list files in specified slideshow folder and show prepared folders"
  printf "\n\t-p indicates search for slideshow folder in desktop background folders"
  printf "\n\t-P indicates search for slideshow folder in desktop background folders and update"
  printf "\n\t-s <subdir> searches in $TOP/<subdir>"
  printf "\n\t\tKeywords:"
  printf "\n\t\t\tcameron\tdomai\telite\tfap\tfractals"
  printf "\n\t\t\tfemjoy\tjp\tkind\tmetart\tmike"
  printf "\n\t\t\tmodels\tplayboy\ttuigirl\twhvn\txart"
  printf "\n\t-u displays this usage message and exits"
  printf "\n\nNote: XnView keyboard shortcuts must be configured with"
  printf "\n\tSlideshow shortcut Ctrl-Alt-S"
  printf "\n\tShow files in subfolder shortcut Ctrl-Alt-O"
  printf "\n\t\tXnView -> Preferences -> Interface -> Shortcuts\n\n"
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
              cameron) subdir="Cameron_Davis"
                       DEF_MODEL=
                ;;
              domai) subdir="Domai"
                ;;
              elite) subdir="Elite_Babes"
                ;;
              fap) subdir="TheFappening2014"
                ;;
              femjoy) subdir="Femjoy"
                ;;
              fractals) subdir="Fractals"
                ;;
              jp) subdir="JP_Erotica"
                ;;
              kind) subdir="KindGirls"
                ;;
              metart) subdir="Met-Art"
                ;;
              mike) subdir="Mike_Dowson"
                    TOP="${ALT_TOP}"
                    DEF_MODEL=
                ;;
              models) subdir="${SUB}/Models"
                      subsubdirs="Photodromm Penthouse Playboy"
                ;;
              playboy) subdir="Playboy"
                ;;
              tuigirl) subdir="Tuigirls"
                ;;
              whvn) subdir="${SUB}"
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
      if [ "$mdir" ]
      then
        newmdir=`basename $mdir`
      else
        newmdir=
      fi
      if [ -d "$TOP/$subdir/$newmdir" ]
      then
        mdir=$newmdir
      else
        foundit=
        [ "$subsubdirs" ] && {
          for subsub in $subsubdirs
          do
            [ -d "$TOP/$subdir/$subsub/$mdir" ] && {
              foundit="$subsub/$mdir"
            }
          done
        }
        if [ "$foundit" ]
        then
          mdir="$foundit"
        else
          if [ "$list" ]
          then
            echo "Cannot locate $TOP/$subdir/$mdir"
          else
            echo "Cannot locate $TOP/$subdir/$mdir - exiting."
            exit 1
          fi
        fi
      fi
    }
    TOP="$TOP/$subdir"
    foundirs="$TOP"
else
    [ -d "$TOP/$mdir" ] || {
        [ "$updpre" ] && mkdir "$TOP/$mdir"
        for subdir in ${SUB} ${SUB}/Models ${SUB}/Models/Playboy ${SUB}/Models/Penthouse ${SUB}/Models/Photodromm ${SUB}/Photographers X-Art Elite_Babes JP_Erotica Met-Art KindGirls Wallbase
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

for i in $PICD/*
do
    [ -d "$i" ] && {
        has_subdir=true
        break
    }
done

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

open -a XnViewMP "${PICD}"
osascript <<EOF
    delay 5
    tell application "System Events"
        if $has_subdir then
            keystroke "o" using {option down, command down}
        end if
        delay 3
        keystroke "a" using {command down}
        delay 2
        key code 36
        delay 2
        keystroke "s" using {option down, command down}
        delay 2
        key code 36
        delay 2
        keystroke "f" using {option down, command down}
    end tell
EOF

