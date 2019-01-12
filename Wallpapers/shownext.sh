#!/bin/bash
#
# shownext - read 'todo' files for Elite Babes and JP Erotica and open next model's page
#            with the Waterfox browser
#

TOP="/Volumes/Seagate_BPH_8TB/Pictures/Work"
EB="${TOP}/Elite_Babes"
JP="${TOP}/JP_Erotica"
EB_URL="https://www.elitebabes.com/model"
JP_URL="https://www.jperotica.com/model"
NEXT=
OPEN="Opening"
TELL=
ALL=

[ "$1" == "-n" ] && TELL=1
[ "$1" == "-a" ] && {
    TELL=1
    ALL=1
}
[ "${TELL}" ] && OPEN="Would open"

for TODO in ${EB} ${JP}
do
    BASE_URL="$TODO"
    [ "$ALL" ] && echo "`basename ${TODO}`:"
    while read model
    do
        [ "$model" ] && {
            NEXT="$model"
            [ "$ALL" ] || break 2
            printf "\t${NEXT}\n"
        }
    done < ${TODO}/todo
done

if [ "$NEXT" ]
then
    MODEL=`echo "${NEXT}" | tr '[:upper:]' '[:lower:]' | sed -e "s/_/-/g"`
    if [ "${BASE_URL}" == "${EB}" ]
    then
        URL="${EB_URL}/${MODEL}"
    else
        URL="${JP_URL}/${MODEL}"
    fi
    [ "${ALL}" ] || echo "${OPEN} model URL: ${URL}"
    [ "${TELL}" ] || open -a WaterFox ${URL}
else
    echo "No new model name found"
fi
