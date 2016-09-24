#!/bin/bash
#
## @file chk.sh
## @brief Check if the specified directories/libraries need to be sync'd
## @remark Sync with rsync to the USB flash drive backup
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 15-Feb-2014
## @version 1.0.1
##
##   Note: to check other directories use the -s, -a, and -t arguments
##         when invoked as chkaplibs it checks directories in my Photosn libs
##         when invoked as chkitunes it checks directories in my iTunes library
##         when invoked as chkpicdir it checks directories in my Pictures dir
##         when invoked as chkmovdir it checks directories in my Movies dir
##         when invoked as chkauddir it checks directories in my Audio dir
##         when invoked as chkhome it checks directories in $HOME
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
USBLIBDIR=
SUFFIX=
NAME="chk"
UPSC="upd"
FORCE=
IGNORE=
APERT_DIR=
ITUNES_DIR=
AUDDIR=
MOVDIR=
PICDIR=
HOMEDIR=
MYHOME=
UPD=
TELL=
USAGE=

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "Usage: $NAME [-h] [-n] [-r] [-u] [-a source_dir] [-t dest_dir]\n"
    printf "  [-A] [-I] [-H] [-L] [-M] [-P] [-f] [-s suffix]\n"
    printf "  [library name(s) ...]\n"
    printf "\nWhere:\n\t-r indicates run rsync to sync libraries when needed\n"
    printf "\t-f indicates force a sync regardless of last time-stamp\n"
    printf "\t-h indicates use directories from $HOME\n"
    printf "\t-A indicates act like invoked as chkauddir\n"
    printf "\t-I indicates act like invoked as chkitunes\n"
    printf "\t-H indicates act like invoked as chkhome\n"
    printf "\t-L indicates act like invoked as chkaplibs\n"
    printf "\t-M indicates act like invoked as chkmovdir\n"
    printf "\t-P indicates act like invoked as chkpicdir\n"
    printf "\t-n indicates tell me what you would do without doing it\n"
    printf "\t-u displays this usage message\n"
    printf "\t-a source_dir sets the top-level source directory\n"
    printf "\t-t dest_dir sets the top-level destination directory\n"
    printf "\t-s suffix sets the subdirectory suffix to look for\n"
    printf "\tadditional arguments indicate library names to check/sync\n"
    printf "\nWhen invoked without arguments $NAME will attempt to check\n"
    printf "all the directories in $SOURCEDIR\n"
    printf "Only corresponding directories in $USBLIBDIR will be checked\n\n"
    exit 1
}

## @fn chklib()
## @brief Check if specified library directory needs to be sync'd
## @param param1 first argument specifies library directory name
chklib() {
    lib=$1
    [ -d "$USBLIBDIR/$lib" ] || continue
    [ -f "$USBLIBDIR/.rsync_$lib" ] || {
        if [ "$FORCE" ]
        then
          echo "Forced sync has been specified - $lib will by synced"
        else
          echo "$USBLIBDIR/.rsync_$lib does not exist. Directory will by synced"
        fi
        newer="sync_me"
    }
    echo "Checking $lib"
    if [ "$FORCE" ] || [ "$newer" = "sync_me" ]
    then
        newer=1
    else
        newer=`find "$SOURCEDIR/$lib" -newer "$USBLIBDIR/.rsync_$lib" | wc -l`
    fi
    if [ $newer -eq 0 ]
    then
        echo "$USBLIBDIR/$lib is current"
    else
        [ "$FORCE" ] || echo "$USBLIBDIR/$lib is out of date"
        [ "$UPD" ] && {
            if [ "$TELL" ]
            then
                echo "Showing what syncing $USBLIBDIR/$lib would do"
            else
                echo "Syncing $USBLIBDIR/$lib"
            fi
            if [ "$SUFFIX" ]
            then
                libnam=`echo $lib | sed -e "s/$SUFFIX//"`
            else
                libnam="$lib"
            fi
            $UPSC $IGNORE $TELL $MYHOME $libnam
        }
    fi
}

while getopts a:s:t:efhAIHPLMrnu flag; do
    case $flag in
        f)
            FORCE=1
            ;;
        e)
            IGNORE="-e"
            ;;
        h)
            MYHOME="-h"
            ;;
        A)
            AUDDIR=1
            ;;
        I)
            ITUNES_DIR=1
            ;;
        H)
            HOMEDIR=1
            ;;
        L)
            APERT_DIR=1
            ;;
        M)
            MOVDIR=1
            ;;
        P)
            PICDIR=1
            ;;
        r)
            UPD=1
            ;;
        n)
            TELL="-dn"
            ;;
        a)
            SOURCEDIR="$OPTARG"
            ;;
        s)
            SUFFIX="$OPTARG"
            ;;
        t)
            USBLIBDIR="$OPTARG"
            ;;
        u)
            USAGE=1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

NAME=`basename $0`
[ "$APERT_DIR" ] || [ "$NAME" = "chkphotoslibs" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Pictures/Libraries"
    [ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/Pictures/Libraries"
    SUFFIX=".photoslibrary"
    UPSC="upd -L"
}
[ "$NAME" = "chkaplibs" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Pictures/Libraries"
    [ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/Pictures/Libraries"
    SUFFIX=".aplibrary"
    UPSC="upd -L"
}
[ "$PICDIR" ] || [ "$NAME" = "chkpicdir" ] && {
    if [ "$MYHOME" ]
    then
        [ "$SOURCEDIR" ] || SOURCEDIR="$HOME/Pictures"
    else
        [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Pictures"
    fi
    [ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/Pictures"
    UPSC="upd -P"
}
[ "$AUDDIR" ] || [ "$NAME" = "chkauddir" ] && {
    if [ "$MYHOME" ]
    then
        [ "$SOURCEDIR" ] || SOURCEDIR="$HOME/Audio"
    else
        [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Audio"
    fi
    [ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/Audio"
    UPSC="upd -A"
}
[ "$MOVDIR" ] || [ "$NAME" = "chkmovdir" ] && {
    if [ "$MYHOME" ]
    then
        [ "$SOURCEDIR" ] || SOURCEDIR="$HOME/Movies"
    else
        [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/My_Book_Studio/Movies"
    fi
    [ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/Movies"
    UPSC="upd -M"
}
[ "$HOMEDIR" ] || [ "$NAME" = "chkhome" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="$HOME"
    [ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/Home"
    UPSC="upd -H"
}
[ "$ITUNES_DIR" ] || [ "$NAME" = "chkitunes" ] && {
    [ "$SOURCEDIR" ] || SOURCEDIR="/Volumes/LaCie_4TB/iTunes"
    [ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/iTunes"
    UPSC="upd -I"
}

#  Where to check the sync from
## Defaults to checking current working directory
[ "$SOURCEDIR" ] || SOURCEDIR=`pwd`
# The mounted USB stick or backup directory
[ "$USBLIBDIR" ] || USBLIBDIR="/Volumes/Transcend/`basename $SOURCEDIR`"

[ "$USAGE" ] && usage

[ -d "$SOURCEDIR" ] || {
    echo "$SOURCEDIR does not exist or is not a directory. Exiting."
    exit 1
}

cd "$SOURCEDIR"
if [ $# -eq 0 ]
then
  for lib in *
  do
      chklib $lib
  done
else
  for lib in $*
  do
      chklib $lib$SUFFIX
  done
fi
