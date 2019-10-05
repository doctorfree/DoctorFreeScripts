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

usage() {
    printf "\nUsage: get-all [-au] [-M] [-P] [-R] [-S]"
    printf "\nWhere:"
    printf "\n\t-a indicates find duplicates after downloading"
    printf "\n\t-M indicates do not retrieve Models wallpapers"
    printf "\n\t-P indicates do not retrieve Photographers wallpapers"
    printf "\n\t-R indicates retrieve latest wallpapers first"
    printf "\n\t-S indicates do not update SUMS after downloading"
    printf "\n\t-u displays this usage message and exits\n"
    exit 1
}

HERE=`pwd`
FIND=
LAT=
MLAT=
MODS=1
PHOT=1
UPD=1

while getopts MPRSau flag; do
    case $flag in
        M)
            MODS=
            ;;
        P)
            PHOT=
            ;;
        R)
            LAT="-R"
            MLAT="-l"
            ;;
        S)
            UPD=
            ;;
        a)
            FIND=1
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

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
        [ "$MODS" ] && ./get-models ${MLAT} -j -S
        ;;
    Models)
        [ "$MODS" ] && ./get-models ${MLAT} -m -S
        ;;
    Photographers)
        [ "$PHOT" ] && ./get-photographers ${LAT} -S
        ;;
    Suicide_Girls)
        [ "$MODS" ] && ./get-models ${MLAT} -s -S
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
    Bella_da_Semana)
        get_search "${dir}" "BelladaSemana"
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
    Camel_Toe)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "cameltoe"
        get_search "${dir}" "camel_toes"
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
    Pubic_Hair)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Natural_Pubic_Hair"
        ;;
    Redheads)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "redhead"
        ;;
    Renders)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "render"
        get_search "${dir}" "3D"
        get_search "${dir}" "CGI"
        get_search "${dir}" "digital_art"
        ;;
    Russian)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Russian_women"
        get_search "${dir}" "Russian_Model"
        ;;
    Smoking)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Smoke"
        get_search "${dir}" "cigarette"
        ;;
    Sucking_Nipples)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "boob_sucking"
        get_search "${dir}" "biting_nipples"
        get_search "${dir}" "licking_nipples"
        get_search "${dir}" "tit_sucking"
        ;;
    Sunglasses)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Women_With_Shades"
        ;;
    The_Life_Erotic)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "TheLifeErotic"
        ;;
    Ukrainian)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Ukraine"
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
    WowGirls)
        get_search "${dir}" "${dir}"
        get_search "${dir}" "Wow_Girls"
        ;;
    *)
        get_search "${dir}" "${dir}"
        ;;
    esac
done

inst=`type -p linkhaven`
[ "$inst" ] && linkhaven -a
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
