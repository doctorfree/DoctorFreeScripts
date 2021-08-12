#!/bin/bash
#
## @file Wallpapers/get-artists.sh
## @brief Download wallpapers from Wallhaven in all current albums
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##
get_search() {
    QUERY=`echo $2 | sed -e "s/_/\%2B/g"`
#   echo "Running get-search ${LAT} -n 256 -p 1 -l $1 -s $QUERY"
    get-search -q ${LAT} -n 256 -p 1 -l "$1" -s "$QUERY"
#   echo "Running get-search ${LAT} -l $1 -s $QUERY"
#   get-search -q ${LAT} -l "$1" -s "$QUERY"
}

HERE=`pwd`
LAT=
UPD=1

[ "$1" == "-R" ] && {
  LAT="-R"
  shift
}

[ "$1" == "-S" ] && {
  UPD=
  [ "$2" == "-R" ] && LAT="-R"
}

cd Artists
for artist in *
do
    [ -d "${artist}" ] || continue
    cd "${HERE}"
    case "${artist}" in
        Ayya_Saparniyazova)
            get_search "Photographers/${artist}" "${artist}"
            get_search "Photographers/${artist}" "AyyaSAP"
            ;;
        Zumi)
            get_search "Artists/${artist}" "${artist}"
            get_search "Artists/${artist}" "zumidraws"
            ;;
        *)
            get_search "Artists/${artist}" "${artist}"
            ;;
    esac
    cd Artists
done
cd "${HERE}"
[ "${UPD}" ] && {
  [ -x ../updsumhaven ] && {
#   echo "Running ../updsumhaven -p"
    ../updsumhaven -p > /dev/null
  }
}
