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
#   ./get-search -q -p 1 -l "$1" -s "$QUERY"
    echo "Running ./get-search ${LAT} -l $1 -s $QUERY"
    ./get-search -q ${LAT} -l "$1" -s "$QUERY"
}

HERE=`pwd`
FIND=
LAT=
MLAT=
UPD=1

# TODO: use getopts to process arguments
[ "$1" == "-R" ] && {
  LAT="-R"
  MLAT="-l"
  shift
}

[ "$1" == "-S" ] && {
  UPD=
  [ "$2" == "-R" ] && {
    LAT="-R"
    MLAT="-l"
  }
}

[ "$1" == "-a" ] && FIND=1

# ./get-anime ${LAT} -p 1 $*
echo "Running ./get-anime ${LAT} $*"
./get-anime ${LAT} -q $*
echo "Running ./get-top $*"
./get-top -q $*
# ./get-general -p 1 $*
#echo "Running ./get-general $*"
#./get-general -q $*
# ./get-people -p 1 $*
#echo "Running ./get-people $*"
#./get-people -q $*
#echo "Running ./mvem People"
#./mvem People
#./get-favorites $*

for dir in *
do
    [ -d "${dir}" ] || continue
    [ "${dir}" = "Anime" ] && continue
    [ "${dir}" = "Favorites" ] && continue
    [ "${dir}" = "General" ] && continue
    [ "${dir}" = "People" ] && continue
    [ "${dir}" = "Top" ] && continue
    case "${dir}" in
    JAV_Idol)
        ./get-models ${MLAT} -j -S
        ;;
    Models)
        ./get-models ${MLAT} -m -S
        ;;
    Photographers)
        ./get-photographers ${LAT} -S
        ;;
    Suicide_Girls)
        ./get-models ${MLAT} -s -S
        ;;
    Amateur)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "amateurs"
        get_search "${dir}" "nonprofessionals"
        ;;
    Art)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "artwork"
        ;;
    Body_Oil)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "oiled_body"
        ;;
    Body_Paint)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "bodypaint"
        get_search "${dir}" "body_painting"
        ;;
    Celebrity)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Fake_Nudes"
        get_search "${dir}" "celebrities"
        get_search "${dir}" "famous_people"
        ;;
    Czech)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Czech_women"
        get_search "${dir}" "Czech_Republic"
        get_search "${dir}" "Karin_Spolnikova"
        get_search "${dir}" "Michaela_Isizzu"
        ;;
    Domai)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "${dir}.com"
        get_search "${dir}" "domai_magazine"
        ;;
    Errotica_Archives)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Errotica_Archives_Magazine"
        ;;
    FameGirls)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "famegirls.net"
        ;;
    Fantasy_Art)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "fantasy_girl"
        ;;
    Femjoy)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Femjoy_Magazine"
        ;;
    Glasses)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Women_With_Glasses"
        ;;
    Hard_Nipples)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Perky_Nipples"
        ;;
    Hegre-Art)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "hegre.com"
        ;;
    Japanese)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Japanese_women"
        ;;
    Lesbian)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Lesbians"
        ;;
    Met-Art)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "MetArt_Magazine"
        ;;
    Nubiles)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Nubiles.net"
        ;;
    Overwatch)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Personalami"
        ;;
    Playboy)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Playboy_Plus"
        get_search "${dir}" "Playmate"
        ;;
    Redheads)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "redhead"
        ;;
    Renders)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "render"
        ;;
    Russian)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Russian_women"
        get_search "${dir}" "Russian_Model"
        ;;
    Sunglasses)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Women_With_Shades"
        ;;
    The_Life_Erotic)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "TheLifeErotic"
        ;;
    Waterfall)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Waterfalls"
        ;;
    Weapon)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Gun"
        get_search "${dir}" "Knife"
        get_search "${dir}" "Sword"
        ;;
    Wet)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Wet_Body"
        get_search "${dir}" "Wet_Clothing"
        ;;
    *)
        get_search "${dir}" "${dir}"
        ;;
    esac
done

[ -x ./clean ] && ./clean
[ "$FIND" ] && {
  [ -x ./findups ] && {
    echo "Running ./findups"
    ./findups
  }
}
[ -x ./counts ] && {
    echo "Running ./counts"
    ./counts
}
[ "${UPD}" ] && {
  [ -x ../updsumhaven ] && {
    echo "Running ../updsumhaven"
    ../updsumhaven > /dev/null
  }
}
