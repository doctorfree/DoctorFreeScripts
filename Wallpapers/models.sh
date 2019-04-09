#!/bin/bash

MDIR="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven/Models"
PDIR="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven/Photographers"
SDIR="/Volumes/Seagate_BPH_8TB/Pictures/Work/Wallhaven/Suicide_Girls"
TYPE="models"
ALL=
COUNT=

ListModels() {
    UTYPE=`echo $2 | tr '[:lower:]' '[:upper:]'`
    printf "\n${UTYPE} in $1:"
    for model in "$1/${models}"*
    do
        if [ "${model}" == "$1/${models}*" ]
        then
            printf "\n\tNo $2 matching \"${models}\""
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

usage() {
    echo "Usage: models [-acpsu] model1 [model2] ..."
    echo "Exiting."
    exit 1
}

[ $# -lt 1 ] && usage

while getopts acpsu flag; do
    case $flag in
        a)
            ALL=1
            ;;
        c)
            COUNT=1
            ;;
        p)
            MDIR="${PDIR}"
            TYPE="photographers"
            ;;
        s)
            MDIR="${SDIR}"
            TYPE="suicide_girls"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

for models in $*
do
  if [ "$ALL" ]
  then
      ListModels $MDIR models
      ListModels $SDIR suicide_girls
      ListModels $PDIR photographers
  else
      ListModels $MDIR $TYPE
  fi
done
printf "\n"
exit 0
