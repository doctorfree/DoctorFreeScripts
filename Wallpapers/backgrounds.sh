#!/bin/bash

top=/u/pictures
out=/usr/local/share/backgrounds
bak=/tmp/pic$$
maxlinks=1024
subdir=
add=

usage() {
  echo "Usage: backgrounds [-u] [-a] [-l] [-n numpics] [-s subdir] directory"
  exit 1
}

while getopts n:s:alu flag; do
    case $flag in
        a)
            add=1
            ;;
        l)
            ls --color=auto -l $out | awk ' { print $11 } '
            exit 0
            ;;
        n)
            maxlinks="$OPTARG"
            ;;
        s)
            subdir="$OPTARG"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ -d $out ] || {
    sudo mkdir $out
    user=`id -u -n`
    sudo chown $user $out
}

cd $out

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
    top="$HOME/Pictures"
    bdir="Backgrounds"
  else
    if [ "$subdir" ]
    then
      [ -d "$top/$subdir/$bdir" ] || {
        echo "Cannot locate $top/$subdir/$bdir - exiting."
        exit 1
      }
      top=$top/$subdir
    else
      [ -d $top/$bdir ] || {
       for subdir in Wallhaven Wallhaven/Models Wallhaven/Photographers X-Art Met-Art KindGirls Wallbase
       do
         [ -d $top/$subdir/$bdir ] && {
           top=$top/$subdir
           break
         }
       done
      }
    fi
  fi
  [ -d $top/$bdir ] || {
    echo "Cannot locate $top/$bdir - exiting."
    exit 1
  }

  numlinks=0
  for pic in $top/$bdir/*
  do
    [ "$pic" == "$top/$bdir/*" ] && continue
    [ "$pic" == "$top/$bdir/downloaded.txt" ] && continue
    if [ -d "$pic" ]
    then
      for subpic in $pic/*
      do
        [ "$subpic" == "$pic/*" ] && continue
        [ "$subpic" == "$pic/downloaded.txt" ] && continue
        [ -d "$subpic" ] && continue
        bnam=`basename $subpic`
        [ -L $bnam ] && continue
        ln -s $subpic .
        numlinks=`expr $numlinks + 1`
        [ $numlinks -ge $maxlinks ] && break
      done
    else
      bnam=`basename $pic`
      [ -L $bnam ] && continue
      ln -s $pic .
      numlinks=`expr $numlinks + 1`
    fi
    [ $numlinks -ge $maxlinks ] && break
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
    file -L $j | grep ASCII > /dev/null && rm -f $j
  done
  [ "$add" ] || rm -rf $bak
}
