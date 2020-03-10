#!/bin/bash

WTOP="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"
JDIR="${WTOP}/JAV_Idol"
MDIR="${WTOP}/Models"
PDIR="${WTOP}/Photographers"
SDIR="${WTOP}/Suicide_Girls"
TYPE="models"
ALL=
COUNT=
NUM=

ListModels() {
    UTYPE=`echo $2 | tr '[:lower:]' '[:upper:]'`
    printf "\n${UTYPE} in $1:"
    for model in "$1/${model_prefix}"*
    do
        if [ "${model}" == "$1/${model_prefix}*" ]
        then
            printf "\n\tNo $2 matching \"${model_prefix}\""
        else
            name=`basename ${model}`
            printf "\n\t${name}"
            [ "$COUNT" ] && {
                cnt=`ls -1 "${model}" | wc -l`
                printf "\t\t${cnt}"
            }
        fi
    done
    printf "\n"
}

[ "$1" == "-a" ] && {
    ALL=1
    shift
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
    TYPE="jav_idols"
    shift
}
[ "$1" == "-p" ] && {
    MDIR="${PDIR}"
    TYPE="photographers"
    shift
}
[ "$1" == "-s" ] && {
    MDIR="${SDIR}"
    TYPE="suicide_girls"
    shift
}

[ "$NUM" ] || {
  [ $# -lt 1 ] && {
    echo "Usage: models [-ajps] [-n model_id] model1 [model2] ..."
    echo "Exiting."
    exit 1
  }
}

[ "$NUM" ] && {
    found=
    for model_dir in $MDIR $JDIR $SDIR $PDIR
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
      ListModels $JDIR jav_idols
      ListModels $SDIR suicide_girls
      ListModels $PDIR photographers
  else
      ListModels $MDIR $TYPE
  fi
  printf "\nModel prefix alternate names in get-models:\n"
  grep ${model_prefix} ${WTOP}/get-models | grep get_search
  [ "${ALL}" ] || [ "${TYPE}" == "photographers" ] && {
      printf "\nPhotographer prefix alternate names in get-photographers:\n"
      grep ${model_prefix} ${WTOP}/get-photographers | grep get_search
  }
done
printf "\n"
exit 0
