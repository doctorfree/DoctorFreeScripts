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
    QUERY=`echo $2 | sed -e "s/_/\%2B/g"`
#   echo "Running ./get-search -p 1 -l $1 -s $QUERY"
#   ./get-search -p 1 -l "$1" -s "$QUERY"
    echo "Running ./get-search -l $1 -s $QUERY"
    ./get-search -q -l "$1" -s "$QUERY"
}

HERE=`pwd`

# ./get-anime -p 1 $*
echo "Running ./get-anime $*"
./get-anime -q $*
# ./get-general -p 1 $*
echo "Running ./get-general $*"
./get-general -q $*
# ./get-people -p 1 $*
echo "Running ./get-people $*"
./get-people -q $*
echo "Running ./mvem People"
./mvem People
#./get-favorites $*

for dir in *
do
    [ -d "${dir}" ] || continue
    [ "${dir}" = "Anime" ] && continue
    [ "${dir}" = "Favorites" ] && continue
    [ "${dir}" = "General" ] && continue
    [ "${dir}" = "People" ] && continue
    if [ "${dir}" = "Models" ] || [ "${dir}" = "Photographers" ]
    then
        cd ${dir}
        for model in *
        do
            [ -d "${model}" ] || continue
            cd "${HERE}"
            get_search "${dir}/${model}" "${model}"
            cd ${dir}
        done
        cd "${HERE}"
    else
        get_search "${dir}" "${dir}"
    fi
done

[ -x ./clean ] && ./clean
[ -x ./findups ] && {
    echo "Running ./findups"
    ./findups
}
[ -x ./counts ] && {
    echo "Running ./counts"
    ./counts
}
