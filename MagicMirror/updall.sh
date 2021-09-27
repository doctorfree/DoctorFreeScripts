#!/bin/bash

TOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"
MOD="${TOP}/Models"
ART="${TOP}/Artists"
JAV="${TOP}/JAV_Idol"
PHO="${TOP}/Photographers"
PLA="${MOD}/Playboy"
PEN="${MOD}/Penthouse"
DRO="${MOD}/Photodromm"
KIND="/Volumes/Seagate_8TB/Pictures/Work/KindGirls"
HER=`pwd`

isportrait() {
    port=0
    GEO=`identify "$1" | awk ' { print $(NF-6) } '`
    W=`echo $GEO | awk -F "x" ' { print $1 } '`
    # Check if width not greater than 600
    [ "$W" ] && [ $W -gt 600 ] || {
        port=1
        return $port
    }
    H=`echo $GEO | awk -F "x" ' { print $2 } '`
    # Check if height not greater than 800
    [ "$H" ] && [ $H -gt 800 ] || {
        port=1
        return $port
    }
    # Check if width less than height
    [ "$W" ] && [ "$H" ] && [ $W -lt $H ] || {
        port=1
        return $port
    }
    return $port
}

# Update any existing plain files to symlinks if possible
for folder in *
do
    [ "$folder" == "*" ] && continue
    [ "$folder" == "Unused" ] && continue
    [ -d $folder ] || continue
    cd $folder
    for img in *
    do
        [ "$img" == "*" ] && continue
        [ -L $img ] && continue
        if [ -f $MOD/$folder/$img ]
        then
          rm -f $img
          ln -s $MOD/$folder/$img .
        else
          if [ -f $KIND/$folder/$img ]
          then
            rm -f $img
            ln -s $KIND/$folder/$img .
          else
            if [ -f $ART/$folder/$img ]
            then
              rm -f $img
              ln -s $ART/$folder/$img .
            else
              if [ -f $PHO/$folder/$img ]
              then
                rm -f $img
                ln -s $PHO/$folder/$img .
              else
                if [ -f $PLA/$folder/$img ]
                then
                  rm -f $img
                  ln -s $PLA/$folder/$img .
                else
                  if [ -f $PEN/$folder/$img ]
                  then
                    rm -f $img
                    ln -s $PEN/$folder/$img .
                  else
                    if [ -f $DRO/$folder/$img ]
                    then
                      rm -f $img
                      ln -s $DRO/$folder/$img .
                    else
                      if [ -f $JAV/$folder/$img ]
                      then
                        rm -f $img
                        ln -s $JAV/$folder/$img .
                      else
                        if [ -f $TOP/$folder/$img ]
                        then
                          rm -f $img
                          ln -s $TOP/$folder/$img .
                        fi
                      fi
                    fi
                  fi
                fi
              fi
            fi
          fi
        fi
    done
    cd ..
done

# Identify any newly added files and create symlinks
for folder in *
do
    [ "$folder" == "*" ] && continue
    [ "$folder" == "Unused" ] && continue
    [ -d $folder ] || continue
    [ -d $MOD/$folder ] && {
        echo "Checking $MOD/$folder for newly added files"
        cd $MOD/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $MOD/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $KIND/$folder ] && {
        echo "Checking $KIND/$folder for newly added files"
        cd $KIND/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $KIND/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $ART/$folder ] && {
        echo "Checking $ART/$folder for newly added files"
        cd $ART/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $ART/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $JAV/$folder ] && {
        echo "Checking $JAV/$folder for newly added files"
        cd $JAV/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $JAV/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $PHO/$folder ] && {
        echo "Checking $PHO/$folder for newly added files"
        cd $PHO/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $PHO/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $PLA/$folder ] && {
        echo "Checking $PLA/$folder for newly added files"
        cd $PLA/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $PLA/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $PEN/$folder ] && {
        echo "Checking $PEN/$folder for newly added files"
        cd $PEN/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $PEN/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $DRO/$folder ] && {
        echo "Checking $DRO/$folder for newly added files"
        cd $DRO/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $DRO/$folder/$img $HER/$folder/$img
            fi
        done
    }
    [ -d $TOP/$folder ] && {
        echo "Checking $TOP/$folder for newly added files"
        cd $TOP/$folder
        for img in *
        do
            [ "$img" == "*" ] && continue
            [ -L $HER/$folder/$img ] && continue
            if isportrait $img
            then
                ln -s $TOP/$folder/$img $HER/$folder/$img
            fi
        done
    }
    cd $HER
done
