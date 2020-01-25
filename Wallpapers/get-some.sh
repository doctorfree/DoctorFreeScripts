#!/bin/bash
#
## @file Wallpapers/get-some.sh
## @brief Download wallpapers from Wallhaven in some current albums
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##
get_search() {
    QUERY=`echo $2 | sed -e "s/_/\%2B/g"`
#   echo "Running get-search -p 1 -l $1 -s $QUERY"
#   get-search -q -p 1 -l "$1" -s "$QUERY"
    echo "Running get-search -l $1 -s $QUERY"
    get-search -q -l "$1" -s "$QUERY"
}

HERE=`pwd`
FIND=

[ "$1" == "-a" ] && FIND=1

echo "Running get-anime $*"
get-anime -q $*
echo "Running get-top $*"
get-top -q $*

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
#       get-models -j
        continue
        ;;
    Models)
#       get-models -m
        continue
        ;;
    Photographers)
#       get-photographers
        continue
        ;;
    Suicide_Girls)
#       get-models -s
        continue
        ;;
    Art)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "artwork"
        ;;
    Body_Oil)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "oiled_body"
        ;;
    Celebrity)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Fake_Nudes"
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
[ -x ../updsumhaven ] && {
    echo "Running ../updsumhaven"
    ../updsumhaven > /dev/null
}
