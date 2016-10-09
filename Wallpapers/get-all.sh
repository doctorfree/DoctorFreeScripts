#!/bin/bash
#
## @file Wallpapers/get-all.sh
## @brief Download wallpapers from Wallhaven in all current albums
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##
get_search() {
    QUERY=`echo $2 | sed -e "s/_/+/g"`
    echo "Running ./get-search -p 1 -l $1 -q $QUERY"
    ./get-search -p 1 -l "$1" -q "$QUERY"
    echo "Running ./get-search -l $1 -q $QUERY"
    ./get-search -l "$1" -q "$QUERY"
}

HERE=`pwd`

./get-anime -p 1 $*
./get-anime $*
./get-general -p 1 $*
./get-general $*
./get-people -p 1 $*
./get-people $*
./mvem People
#./get-favorites $*

for dir in *
do
    [ -d "${dir}" ] || continue
    [ "${dir}" = "Anime" ] && continue
    [ "${dir}" = "Favorites" ] && continue
    [ "${dir}" = "General" ] && continue
    [ "${dir}" = "People" ] && continue
    if [ "${dir}" = "Models" ]
    then
        cd Models
        for model in *
        do
            [ -d "${model}" ] || continue
            cd "${HERE}"
            get_search "Models/${model}" "${model}"
            cd Models
        done
        cd "${HERE}"
    else
        get_search "${dir}" "${dir}"
    fi
done

./findups
