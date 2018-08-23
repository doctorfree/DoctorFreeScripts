#!/bin/bash
#
## @file Wallpapers/get-photographers.sh
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

cd Photographers
for model in *
do
    [ -d "${model}" ] || continue
    cd "${HERE}"
    get_search "Photographers/${model}" "${model}"
    cd Photographers
done
cd "${HERE}"
