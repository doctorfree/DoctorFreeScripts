#!/bin/bash
#
## @file get-all.sh
## @brief Download wallpapers from Wallhaven in all current albums
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##

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
