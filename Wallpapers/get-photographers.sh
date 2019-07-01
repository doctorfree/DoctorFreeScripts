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
    echo "Running ./get-search ${LAT} -p 1 -l $1 -s $QUERY"
    ./get-search -q ${LAT} -n 1536 -p 1 -l "$1" -s "$QUERY"
#   echo "Running ./get-search ${LAT} -l $1 -s $QUERY"
#   ./get-search -q ${LAT} -l "$1" -s "$QUERY"
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

cd Photographers
for photographer in *
do
    [ -d "${photographer}" ] || continue
    cd "${HERE}"
    case "${photographer}" in
        Alex_Lynn)
            get_search "Photographers/${photographer}" "${photographer}"
            get_search "Photographers/${photographer}" "Alex-Lynn.com"
            ;;
        Holly_Randall)
            get_search "Photographers/${photographer}" "${photographer}"
            get_search "Photographers/${photographer}" "HollyRandall"
            ;;
        Maksim_Chuprin)
            get_search "Photographers/${photographer}" "${photographer}"
            get_search "Photographers/${photographer}" "Maxim_Chuprin"
            ;;
        Murbo_Dagldian)
            get_search "Photographers/${photographer}" "${photographer}"
            get_search "Photographers/${photographer}" "Murbo"
            ;;
        Vladimir_Nikolaev)
            get_search "Photographers/${photographer}" "${photographer}"
            get_search "Photographers/${photographer}" "Vavaca"
            ;;
        *)
            get_search "Photographers/${photographer}" "${photographer}"
            ;;
    esac
    cd Photographers
done
cd "${HERE}"
[ "${UPD}" ] && {
  [ -x ../updsumhaven ] && {
    echo "Running ../updsumhaven -p"
    ../updsumhaven -p > /dev/null
  }
}
