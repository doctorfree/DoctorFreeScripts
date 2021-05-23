#!/bin/bash
#
## @file Wallpapers/backgrounds.sh
## @brief Set background desktop wallpapers or display slideshow
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2017, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2017
## @version 2.0.1
##
## NOTES:
##
## Link the file "backgrounds" to "slides" and/or "slideshow" to enable
## and turn on automatic slideshow presentation when invoked as such.
##
## I found I needed to give iTerm2 system privileges in
## System Preferences -> Security & Privacy -> Privacy
## Adding it to the list of applications given Accessibility and Full Disk Access
## privileges. On another system I needed to add "System Events" rather than "iTerm 2"
## to Accessibility so ymmv - apparently this is a result of strengthened privacy
## protections in Apple's Mojave release.
##
## You may wish to add the "Slideshow" icon to the Preview toolbar for ease of use
##

# Root directory of your subfolders of image files to use as backgrounds/slideshows
LIN_TOP=/u/pictures
MAC_TOP="/Volumes/Seagate_8TB/Pictures/Work"
NFS_TOP=/u/pictures/Work
PRE_TOP=$HOME/Pictures/Work/Backgrounds
#
# Location of folder to copy selected images to
MAC_OUT=$HOME/Pictures/Backgrounds
LIN_OUT=/usr/local/share/backgrounds
#
# Folders to search for model name or other subfolder of images to use
# These are located under $TOP, defined below
# Order is important, first in list coming first in search
# If you want to combine images from several folders use the "-s all" option
#
SUBS="Fractals Wallhaven Wallhaven/Models Wallhaven/Photographers X-Art Elite_Babes \
      JP_Erotica Met-Art KindGirls Wallbase"

bak=/tmp/pic$$
maxlinks=2048
add=
all=
osa=
show=
subdir=
foundirs=
updpre=
name=`basename $0`
plat=`uname -s`

usage() {
  printf "\nUsage: $name [-u] [-a] [-l] [-pP] [-S] [-n numpics] [-s subdir] directory"
  printf "\nWhere\t-a indicates add to existing background/slide pics"
  printf "\n\t-l lists currently installed background/slide pics"
  printf "\n\t-p indicates search for background pics in prepared folders"
  printf "\n\t-P indicates search for background pics in prepared folders and update"
  printf "\n\t-n <numpics> sets maximum number of pics to be copied (default ${maxlinks})"
  printf "\n\t-s <subdir> searches in $TOP/<subdir> for specified folder"
  printf "\n\t-S indicates run a slideshow of pics\n\n"
  exit 1
}

# Turn on slideshow capability if invoked as "slides" or "slideshow"
[ "$name" == "slides" ] && show=1
[ "$name" == "slideshow" ] && show=1

# Try to figure out which system we are on
if [ "$plat" == "Linux" ]
then
    TOP="$LIN_TOP"
    OUT="$LIN_OUT"
    SLIDE_APP="Variety Slideshow"
else
    if [ "$plat" == "Darwin" ]
    then
        TOP="$MAC_TOP"
        OUT="$MAC_OUT"
        SLIDE_APP="AppleScript"
    else
        echo "Unable to detect a supported platform: ${plat}. Exiting."
        exit 1
    fi
fi
[ -d "$TOP" ] || {
    TOP="$NFS_TOP"
    [ -d "$TOP" ] || {
        echo "Cannot locate Work directory for pics. Exiting."
        exit 1
    }
}

# Set Model and Photographer top dirs before processing arguments
MOD_TOP="$TOP/Wallhaven/Models"
PHO_TOP="$TOP/Wallhaven/Photographers"
  
while getopts pPn:s:alSu flag; do
    case $flag in
        a)
            add=1
            ;;
        l)
#           ls --color=auto -l $OUT | awk ' { print $NF } '
            ls -l $OUT | grep -v total | awk ' { print $NF } '
            echo "Background images in $OUT"
            exit 0
            ;;
        n)
            maxlinks="$OPTARG"
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
              all) all=1
                ;;
              elite) subdir="Elite_Babes"
                ;;
              fractals) subdir="Fractals"
                ;;
              jp) subdir="JP_Erotica"
                ;;
              kind) subdir="KindGirls"
                ;;
              whvn) subdir="Wallhaven/Models"
                ;;
              xart) subdir="X-Art"
                ;;
              *) subdir="$OPTARG"
                ;;
            esac
            ;;
        S)
            show=1
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$show" ] && {
    if [ "$plat" == "Darwin" ]
    then
        inst=`type -p osascript`
        [ "$inst" ] && osa=1
    else
        inst=`type -p variety-slideshow`
        [ "$inst" ] && var=1
    fi
    [ "$inst" ] || {
        echo "$SLIDE_APP is not supported on this platform."
        echo "Unable to automate the slideshow feature."
    }
}

[ -d $OUT ] || {
    sudo mkdir $OUT
    user=`id -u -n`
    sudo chown $user $OUT
}

cd $OUT

[ "$1" ] && {
  [ "$add" ] || {
    mkdir $bak
    touch $bak/foo
    for i in *
    do
      [ "$i" == "*" ] && continue
      mv $i $bak
    done
  }

  bdir="$1"
  if [ "$bdir" == "favs" ]
  then
    TOP="$HOME/Pictures"
    bdir="Favs"
    foundirs=$TOP
  else
    if [ "$subdir" ]
    then
      [ -d "$TOP/$subdir/$bdir" ] || {
        echo "Cannot locate $TOP/$subdir/$bdir - exiting."
        exit 1
      }
      TOP="$TOP/$subdir"
      foundirs="$TOP"
    else
      [ -d "$TOP/$bdir" ] || {
        [ "$updpre" ] && mkdir "$TOP/$bdir"
        for subdir in Wallhaven Wallhaven/Models Wallhaven/Photographers X-Art Elite_Babes JP_Erotica Met-Art KindGirls Wallbase
        do
          [ -d "$TOP/$subdir/$bdir" ] && {
            sub="$TOP/$subdir"
            if [ "$all" ]
            then
              foundirs="$foundirs $sub"
            else
              foundirs="$sub"
              break
            fi
          }
        done
        #TOP="$sub"
      }
    fi
  fi
  [ -d "$TOP/$bdir" ] || {
    echo "Cannot locate $TOP/$bdir - exiting."
    exit 1
  }
  echo "Using background pics in $TOP/$bdir"

  numlinks=0
  for dir in $foundirs
  do
    [ "$updpre" ] && {
      updtop=
      if [ -d $MOD_TOP/$bdir ]
      then
        updtop=$MOD_TOP
      else
        if [ -d $PHO_TOP/$bdir ]
        then
          updtop=$PHO_TOP
        fi
      fi
      [ "$updtop" ] && {
        [ -d $TOP/$bdir ] || mkdir $TOP/$bdir
        cd $TOP/$bdir
        for orig in $updtop/$bdir/wallhaven*
        do
          [ "$orig" == "$updtop/$bdir/wallhaven*" ] && {
            echo "No pics in $updtop/$bdir"
            continue
          }
          bnam=`basename $orig`
          [ -L $bnam ] && continue
          cp $orig $bnam
          rmportargs $bnam
          [ -f $bnam ] && {
            rm -f $bnam
            echo "Adding $bnam to $bdir"
            ln -s $orig .
          }
        done
        cd $OUT
      }
    }
    for pic in $dir/$bdir/*
    do
      [ "$pic" == "$dir/$bdir/*" ] && continue
      [ "$pic" == "$dir/$bdir/downloaded.txt" ] && continue
      [ "$pic" == "$dir/$bdir/Description.txt" ] && continue
      if [ -d "$pic" ]
      then
        for subpic in $pic/*
        do
          [ "$subpic" == "$pic/*" ] && continue
          [ "$subpic" == "$pic/downloaded.txt" ] && continue
          [ "$subpic" == "$pic/Description.txt" ] && continue
          [ -d "$subpic" ] && continue
#       bnam=`basename $subpic`
#       [ -L $bnam ] && continue
#       ln -s $subpic .
          cp "$subpic" .
          numlinks=`expr $numlinks + 1`
          [ $numlinks -ge $maxlinks ] && break 2
        done
      else
#     bnam=`basename $pic`
#     [ -L $bnam ] && continue
#     ln -s $pic .
        cp "$pic" .
        numlinks=`expr $numlinks + 1`
      fi
      [ $numlinks -ge $maxlinks ] && break 2
    done
  done

  for j in *
  do
    [ "$j" == "*" ] && {
      [ "$add" ] || {
        mv $bak/* .
        rm -f foo
      }
      continue
    }
    file -L "$j" | grep ASCII > /dev/null && rm -f "$j"
  done
  [ "$add" ] || rm -rf $bak
}

[ "$show" ] && {
    if [ "$plat" == "Darwin" ]
    then
        open -a Preview "$OUT"/*
        # ----------------------
        # Applescript below here
        # ----------------------
        [ "$osa" ] && {
            osascript <<EOF
            delay 5
            tell application "System Events"
                keystroke "F" using {shift down, command down}
            end tell
EOF
        }
    else
#           variety-slideshow $HOME/.config/variety/Favorites 2> /dev/null
            variety-slideshow "$OUT" 2> /dev/null
    fi
}
