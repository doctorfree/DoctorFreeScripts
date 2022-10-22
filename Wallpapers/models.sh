#!/bin/bash

WTOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"
[ -d "${WTOP}" ] || {
  if [ -d /mac/pictures/Work/Wallhaven ]
  then
    WTOP="/mac/pictures/Work/Wallhaven"
  else
    if [ -d /u/pictures/Wallhaven ]
    then
      WTOP="/u/pictures/Wallhaven"
    else
      echo "Can't find Wallhaven download folder. Exiting."
      exit 1
    fi
  fi
}

JDIR="${WTOP}/JAV_Idol"
MDIR="${WTOP}/Models"
DDIR="${WTOP}/Models/Photodromm"
BDIR="${WTOP}/Models/Playboy"
HDIR="${WTOP}/Models/Penthouse"
PDIR="${WTOP}/Photographers"
ADIR="${WTOP}/Artists"
SDIR="${WTOP}/Suicide_Girls"
TYPE="models"
ALL=1
COUNT=
NUM=

ListModels() {
    header=1
    UTYPE=`echo $2 | tr '[:lower:]' '[:upper:]'`
    for model in "$1/${model_prefix}"*
    do
        if [ "${model}" == "$1/${model_prefix}*" ]
        then
#           printf "\n\tNo $2 matching \"${model_prefix}\""
            continue
        else
            [ ${header} ] && {
                printf "\n${UTYPE} in $1:"
                header=
            }
            name=`basename ${model}`
            printf "\n\t${name}"
            [ "$COUNT" ] && {
                cnt=`ls -1 "${model}" | wc -l`
                printf "\t\t${cnt}"
            }
        fi
    done
    [ ${header} ] || printf "\n"
}

[ "$1" == "-c" ] && {
    COUNT=1
    shift
}
[ "$1" == "-n" ] && {
    NUM="$2"
    shift 2
}
[ "$1" == "-j" ] && {
    MDIR="${JDIR}"
    ALL=
    TYPE="jav_idols"
    shift
}
[ "$1" == "-A" ] && {
    MDIR="${ADIR}"
    ALL=
    TYPE="artists"
    shift
}
[ "$1" == "-p" ] && {
    MDIR="${PDIR}"
    ALL=
    TYPE="photographers"
    shift
}
[ "$1" == "-s" ] && {
    MDIR="${SDIR}"
    ALL=
    TYPE="suicide_girls"
    shift
}

[ "$NUM" ] || {
  [ $# -lt 1 ] && {
    echo "Usage: models [-Aajps] [-n model_id] model1 [model2] ..."
    echo "Exiting."
    exit 1
  }
}

[ "$NUM" ] && {
    found=
    for model_dir in $MDIR $HDIR $BDIR $DDIR $JDIR $SDIR $PDIR $ADIR
    do
        for model in $model_dir/*
        do
              [ -L $model/wallhaven-$NUM.jpg ] && {
                  echo "Found symbolic link $model/wallhaven-$NUM.jpg"
                  found=1
                  continue
              }
              [ -f $model/wallhaven-$NUM.jpg ] && {
                  found=1
                  echo "Found regular file $model/wallhaven-$NUM.jpg"
              }
        done
    done
    for topic in ${WTOP}/*
    do
        [ -d $topic ] || continue
        [ -L $topic/wallhaven-$NUM.jpg ] && {
            echo "Found symbolic link $topic/wallhaven-$NUM.jpg"
            found=1
            continue
        }
        [ -f $topic/wallhaven-$NUM.jpg ] && {
            echo "Found regular file $topic/wallhaven-$NUM.jpg"
            found=1
        }
    done
    [ "$found" ] || echo "No image found for ID=$NUM"
}

for model_prefix in $*
do
  if [ "$ALL" ]
  then
      ListModels $MDIR models
      ListModels $DDIR models
      ListModels $BDIR models
      ListModels $HDIR models
      ListModels $JDIR jav_idols
      ListModels $SDIR suicide_girls
      ListModels $PDIR photographers
      ListModels $ADIR artists
  else
      ListModels $MDIR $TYPE
      [ "$TYPE" == "models" ] && {
        ListModels $DDIR $TYPE
        ListModels $BDIR $TYPE
        ListModels $HDIR $TYPE
      }
  fi
  printf "\nModel prefix alternate names in get-models:\n"
  grep ${model_prefix} /usr/local/bin/get-models | grep get_search
  [ "${ALL}" ] || [ "${TYPE}" == "photographers" ] && {
      printf "\nPhotographer prefix alternate names in get-photographers:\n"
      grep ${model_prefix} /usr/local/bin/get-photographers | grep get_search
  }
done
printf "\n"
exit 0
