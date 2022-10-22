#!/bin/bash

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

MDL="${TOP}/Wallhaven/Models/Models"
PLA="${TOP}/Wallhaven/Models/Playboy"
PEN="${TOP}/Wallhaven/Models/Penthouse"
PHO="${TOP}/Wallhaven/Models/Photodromm"
KIND="${TOP}/KindGirls"
HER=`pwd`

isportrait() {
    port=0
    #GEO=`identify "$1" | awk ' { print $(NF-6) } '`
    GEO=`identify "$1" | awk ' { print $3 } '`
    W=`echo $GEO | awk -F "x" ' { print $1 } '`
    # Check if width not greater than 1000
    [ "$W" ] && [ $W -gt 1000 ] || {
        port=1
        return $port
    }
    H=`echo $GEO | awk -F "x" ' { print $2 } '`
    # Check if height not greater than 750
    [ "$H" ] && [ $H -gt 750 ] || {
        port=1
        return $port
    }
    # Check if width not greater than height
    [ "$W" ] && [ "$H" ] && [ $W -gt $H ] || {
        port=1
        return $port
    }
    return $port
}

[ "$1" ] || {
    echo "Use updall.sh to update all folders."
    echo "This script requires a folder or folders as arguments."
    echo "Exiting."
    exit 1
}

# Update any existing plain files to symlinks if possible
for folder in $*
do
    [ "$folder" == "*" ] && continue
    [ -d $folder ] || continue
    cd $folder
    for img in *
    do
        [ "$img" == "*" ] && continue
        [ -L $img ] && continue
        for MDIR in $MDL $KIND $PLA $PEN $PHO
        do
            [ -f $MDIR/$folder/$img ] && {
                rm -f $img
                ln -s $MDIR/$folder/$img .
                break
            }
        done
    done
    cd ..
done

# Identify any newly added files and create symlinks
for folder in $*
do
    [ "$folder" == "*" ] && continue
    [ -d $folder ] || continue
    for MDIR in $MDL $KIND $PLA $PEN $PHO
    do
      [ -d $MDIR/$folder ] && {
        echo "Checking $MDIR/$folder for newly added files"
        cd $MDIR/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $MDIR/$folder/$img $HER/$folder/$img
            fi
        done
      }
    done
#   [ -d $KIND/$folder ] && {
#       echo "Checking $KIND/$folder for newly added files"
#       cd $KIND/$folder
#       for img in *
#       do
#           [ "$img" == "*" ] && continue
#           [ -L $HER/$folder/$img ] && continue
#           if isportrait $img
#           then
#               ln -s $KIND/$folder/$img $HER/$folder/$img
#           fi
#       done
#   }
    cd $HER
done
