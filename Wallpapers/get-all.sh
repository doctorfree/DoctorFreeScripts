#!/bin/bash

./get-anime $*
./get-general $*
./get-people $*
#./get-favorites $*

for dir in *
do
    [ -d "${dir}" ] || continue
    [ "${dir}" = "Anime" ] && continue
    [ "${dir}" = "Favorites" ] && continue
    [ "${dir}" = "General" ] && continue
    [ "${dir}" = "People" ] && continue
    QUERY=`echo ${dir} | sed -e "s/_/+/g"`
    echo "Running ./get-search $QUERY"
    ./get-search -q "$QUERY" $*
done

./findups -l
