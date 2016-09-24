#!/bin/bash
#
# upd - sync specified directories/libraries to a USB flash drive
#    Note: to sync other directories use the -s, -a, and -t arguments
#        when invoked as updaplibs it syncs directories in my Aperture library
#        when invoked as updphotoslibs it syncs directories in my Photos library
#        when invoked as upditunes it syncs directories in my iTunes library
#        when invoked as updpicdir it syncs directories in my Pictures dir
#        when invoked as updmovdir it syncs directories in my Movies dir
#        when invoked as updauddir it syncs directories in my Audio dir
#        when invoked as updhome it syncs directories in $HOME
#
# Written 10-Feb-2014 by Ronald Joe Record <rr at ronrecord dot com>
#
# Copyright (c) 2014, Ronald Joe Record
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
SOURCEDIR=
TRANSCEND=
SUFFIX=
NAME="upd"
MYHOME=
APERT_DIR=
ITUNES_DIR=
PICDIR=
AUDDIR=
MOVDIR=
HOMEDIR=
TELL=
DRY=
EXCLUDE=
FOLLOW=
IGN="--max-size=4G"
USAGE=
VERB="q"

usage() {
    printf "Usage: $NAME [-d] [-h] [-n] [-u] [-a source dir] [-t dest dir]\n"
    printf "    [-v] [-A] [-I] [-P] [-M] [-H] [-L] [-l] [-s suffix]\n"
    printf "    source-subdir [subdir2 subdir3 ...]\n"
    printf "Where:\n\t-d indicates a dry run sync (no changes)\n"
    printf "\t-h indicates use directories from your HOME dir\n"
    printf "\t-l indicates follow symbolic links\n"
    printf "\t-v indicates verbose rsync output\n"
    printf "\t-A indicates use the Audio directory (like updauddir)\n"
    printf "\t-L indicates use the Photos libraries (like updaplibs)\n"
    printf "\t-I indicates use the iTunes library (like upditunes)\n"
    printf "\t-P indicates use the Pictures directory (like updpicdir)\n"
    printf "\t-M indicates use the Movies directory (like updmovdir)\n"
    printf "\t-H indicates use the Home directory (like updhome)\n"
    printf "\t-n indicates tell me what you would do without doing it\n"
    printf "\t-u displays this usage message\n"
    printf "\t-a source dir sets the top-level source directory\n"
    printf "\t-t dest dir sets the top-level destination directory\n"
    printf "\t-s suffix sets the subdirectory suffix to look for\n"
    printf "\tsource-dir is the master directory hierarchy to sync from\n"
    printf "\tdest-dir is the directory hierarchy to be sync'd\n"
    printf "\nWhen invoked without arguments $NAME will attempt to sync\n"
    printf "all the directories in $TRANSCEND with\n"
    printf "corresponding directories in the current working directory.\n\n"
    exit 1
}

while getopts a:E:s:t:dehAILPMHlnuv flag; do
    case $flag in
        d)
            DRY="n"
            ;;
        E)
            EXCLUDE="--exclude $OPTARG"
            ;;
        e)
            IGN="$IGN --ignore-errors"
            ;;
        h)
            MYHOME=1
            ;;
        l)
            FOLLOW="--copy-links"
            ;;
        H)
            HOMEDIR=1
            ;;
        n)
            TELL=1
            ;;
        A)
            AUDDIR=1
            ;;
        I)
            ITUNES_DIR=1
            ;;
        L)
            APERT_DIR=1
            ;;
        P)
            PICDIR=1
            ;;
        M)
            MOVDIR=1
            ;;
        a)
            SOURCEDIR="$OPTARG"
            ;;
        s)
            SUFFIX="$OPTARG"
            ;;
        t)
            TRANSCEND="$OPTARG"
            ;;
        u)
            USAGE=1
            ;;
        v)
            VERB=v
            ;;
    esac
done
shift $(( OPTIND - 1 ))
EXCLUDE="--delete-excluded --exclude .DS_Store $EXCLUDE"
FOLLOW="$FOLLOW $EXCLUDE"

NAME=`basename $0`
[ "$APERT_DIR" ] || [ "$NAME" = "updphotoslibs" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Pictures/Libraries"
    [ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/Pictures/Libraries"
    SUFFIX=".photoslibrary"
}
[ "$NAME" = "updaplibs" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Pictures/Libraries"
    [ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/Pictures/Libraries"
    SUFFIX=".aplibrary"
}
[ "$ITUNES_DIR" ] || [ "$NAME" = "upditunes" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/LaCie_4TB/iTunes"
    [ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/iTunes"
}
[ "$PICDIR" ] || [ "$NAME" = "updpicdir" ] && {
    if [ "$MYHOME" ]
    then
        [ "$SOURCEDIR" ] || SOURCEDIR="$HOME/Pictures"
    else
        [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Pictures"
    fi
    [ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/Pictures"
}
[ "$AUDDIR" ] || [ "$NAME" = "updauddir" ] && {
    if [ "$MYHOME" ]
    then
        [ "$SOURCEDIR" ] || SOURCEDIR="$HOME/Audio"
    else
        [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Audio"
    fi
    [ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/Audio"
}
[ "$MOVDIR" ] || [ "$NAME" = "updmovdir" ] && {
    if [ "$MYHOME" ]
    then
        [ "$SOURCEDIR" ] || SOURCEDIR="$HOME/Movies"
    else
        [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Movies"
    fi
    [ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/Movies"
}
[ "$HOMEDIR" ] || [ "$NAME" = "updhome" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="$HOME"
    [ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/Home"
}

# Where to sync from - defaults to current working directory
[ "$SOURCEDIR" ] || SOURCEDIR=`pwd`
# Where to sync to
[ "$TRANSCEND" ] || TRANSCEND="/Volumes/Transcend/`basename $SOURCEDIR`"

[ "$USAGE" ] && usage

[ "$SOURCEDIR" = "/" ] && {
    echo "Use of / as source directory is not supported. Exiting."
    exit 1
}

[ -d "$SOURCEDIR" ] || {
    echo "$SOURCEDIR does not exist or is not a directory. Exiting."
    exit 1
}

cd "$SOURCEDIR"

if [ $# -eq 0 ]
then
  for lib in *$SUFFIX
  do
    [ "$lib" = "*" ] && lib=
    [ -e "$SOURCEDIR/$lib" ] || {
        echo "$SOURCEDIR/$lib does not exist. Skipping."
        continue
    }
    echo -n "Syncing $SOURCEDIR/$lib to $TRANSCEND/$lib with rsync ... "
    DEL="--delete"
    [ -f "$TRANSCEND/$lib/.do_not_delete" ] && DEL=""
    if [ "$TELL" ]
    then
        echo ""
        echo "rsync -${VERB}a$DRY $FOLLOW $IGN $DEL $SOURCEDIR/$lib $TRANSCEND" 
    else
        if [ "$DRY" ]
        then
            rsync -van $FOLLOW $IGN $DEL "$SOURCEDIR/$lib" "$TRANSCEND" 
        else
            rsync -Wa$VERB $FOLLOW $IGN $DEL "$SOURCEDIR/$lib" "$TRANSCEND" 
            touch "$TRANSCEND/.rsync_$lib"
        fi
    fi
    echo "done."
  done
else
    for libnam in "$@"
    do
      lib="$libnam$SUFFIX"
      [ "$lib" = "*" ] && lib=
      [ -d "$SOURCEDIR/$lib" ] || {
        echo "$SOURCEDIR/$lib does not exist or is not a directory. Skipping."
        continue
      }
      echo -n "Syncing $SOURCEDIR/$lib to $TRANSCEND/$lib with rsync ... "
      DEL="--delete"
      [ -f "$TRANSCEND/$lib/.do_not_delete" ] && DEL=""
      if [ "$TELL" ]
      then
          echo ""
          echo "rsync -${VERB}a$DRY $FOLLOW $IGN $DEL $SOURCEDIR/$lib $TRANSCEND" 
      else
          if [ "$DRY" ]
          then
              rsync -van $FOLLOW $IGN $DEL "$SOURCEDIR/$lib" "$TRANSCEND" 
          else
              rsync -W${VERB}a $FOLLOW $IGN $DEL "$SOURCEDIR/$lib" "$TRANSCEND" 
              touch "$TRANSCEND/.rsync_$lib"
          fi
      fi
      echo "done."
    done
fi
