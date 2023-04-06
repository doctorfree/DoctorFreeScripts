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
    QUERY=$(echo "$2" | sed -e "s/_/\%2B/g")
#   echo "Running get-search -p 1 -l $1 -s $QUERY"
#   get-search -q -p 1 -l "$1" -s "$QUERY"
#   echo "Running get-search ${LAT} -l $1 -n $numdown -s $QUERY"
    get-search -q "$LAT" -l "$1" -n "$numdown" -s "$QUERY"
}

usage() {
    printf "\nUsage: get-all [-asu] [-n numdown] [-N] [-A] [-J] [-M] [-P] [-R] [-S]"
    printf "\nWhere:"
    printf "\n\t-a indicates find duplicates after downloading"
    printf "\n\t-n numdown specifies the number of downloads per search"
    printf "\n\t-N indicates do not retrieve Artists, Models, or Photographers wallpapers"
    printf "\n\t\t(equivalent to '-A -J -M -P -S')"
    printf "\n\t-A indicates do not retrieve Artists wallpapers"
    printf "\n\t-J indicates do not retrieve JAV Idols wallpapers"
    printf "\n\t-M indicates do not retrieve Models wallpapers"
    printf "\n\t-P indicates do not retrieve Photographers wallpapers"
    printf "\n\t-R indicates retrieve latest wallpapers first"
    printf "\n\t-S indicates do not retrieve Suicide Girls wallpapers"
    printf "\n\t-s indicates do not update SUMS after downloading"
    printf "\n\t-u displays this usage message and exits\n"
    exit 1
}

if [ -r /usr/local/share/bash/wallutils ]
then
    . /usr/local/share/bash/wallutils
else
    [ -r ./Utils/wallutils ] && . ./Utils/wallutils
fi

FIND=
LAT=
MLAT=
ARTS=1
JAVS=1
MODS=1
PHOT=1
SUIC=1
UPD=1
numdown=32

while getopts AJMNPRSan:su flag; do
    case $flag in
        N)
            ARTS=
            JAVS=
            MODS=
            PHOT=
            SUIC=
            ;;
        A)
            ARTS=
            ;;
        J)
            JAVS=
            ;;
        M)
            MODS=
            ;;
        P)
            PHOT=
            ;;
        R)
            LAT="-R -p 1"
            MLAT="-l"
            ;;
        S)
            SUIC=
            ;;
        a)
            FIND=1
            ;;
        n)
            numdown=$OPTARG
            ;;
        s)
            UPD=
            ;;
        *)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$WHDIR" ] || WHDIR="/Volumes/Seagate_8TB/Pictures/Work/Wallhaven"

[ -d "$WHDIR" ] || exit
cd "$WHDIR" || exit

# get-anime ${LAT} -p 1 $*
# echo "Running get-anime ${LAT} -n $numdown $*"
get-anime "$LAT" -n "$numdown" -q "$@"
# echo "Running get-top -n $numdown $*"
get-top -n "$numdown" -q "$@"
# get-general -p 1 $*
#echo "Running get-general $*"
#get-general -q $*
# get-people -p 1 $*
#echo "Running get-people $*"
#get-people -q $*
#echo "Running mvem People"
#mvem People
#get-favorites $*

for dir in *
do
    [ -d "$dir" ] || continue
    [ "$dir" = "Anime" ] && continue
    [ "$dir" = "Favorites" ] && continue
    [ "$dir" = "General" ] && continue
    [ "$dir" = "People" ] && continue
    [ "$dir" = "Top" ] && continue
    case "$dir" in
    Artists)
        [ "$ARTS" ] && get-artists "$LAT" -S
        ;;
    JAV_Idol)
        [ "$JAVS" ] && get-models "$MLAT" -n "$numdown" -j -S
        ;;
    Models)
        [ "$MODS" ] && get-models "$MLAT" -n "$numdown" -m -S
        ;;
    Photographers)
        [ "$PHOT" ] && get-photographers "$LAT" -S
        ;;
    Suicide_Girls)
        [ "$SUIC" ] && get-models "$MLAT" -n "$numdown" -s -S
        ;;
    Amateur)
        get_search "$dir" "$dir"
        get_search "$dir" "amateurs"
        get_search "$dir" "nonprofessionals"
        ;;
    Art)
        get_search "$dir" "$dir"
        get_search "$dir" "artwork"
        ;;
    Bella_da_Semana)
        get_search "$dir" "BelladaSemana"
        ;;
    Body_Oil)
        get_search "$dir" "$dir"
        get_search "$dir" "oiled_body"
        ;;
    Body_Paint)
        get_search "$dir" "$dir"
        get_search "$dir" "bodypaint"
        get_search "$dir" "body_painting"
        ;;
    Brazilian)
        get_search "$dir" "$dir"
        get_search "$dir" "Brazilian_Model"
        ;;
    Camel_Toe)
        get_search "$dir" "$dir"
        get_search "$dir" "cameltoe"
        get_search "$dir" "camel_toes"
        ;;
    Celebrity)
        get_search "$dir" "$dir"
        get_search "$dir" "Fake_Celeb"
        get_search "$dir" "Fake_Nudes"
        get_search "$dir" "celebrities"
        get_search "$dir" "famous_people"
        ;;
    Choker)
        get_search "$dir" "$dir"
        get_search "$dir" "Collar"
        ;;
    Colombian)
        get_search "$dir" "$dir"
        get_search "$dir" "Colombian_Model"
        get_search "$dir" "Colombian_Women"
        get_search "$dir" "Sara_Calixto"
        get_search "$dir" "Valery_Ponce"
        get_search "$dir" "Hinata_Suicide"
        get_search "$dir" "Calypso_Muse"
        ;;
    Czech)
        get_search "$dir" "$dir"
        get_search "$dir" "Czech_women"
        get_search "$dir" "Czech_Republic"
        get_search "$dir" "Karin_Spolnikova"
        get_search "$dir" "Michaela_Isizzu"
        get_search "$dir" "Eufrat"
        get_search "$dir" "Marketa_Stroblova"
        get_search "$dir" "Ariel_Piper_Fawn"
        get_search "$dir" "Paula_Shy"
        get_search "$dir" "Charlotta_Phillip"
        ;;
    Domai)
        get_search "$dir" "$dir"
        get_search "$dir" "${dir}.com"
        get_search "$dir" "domai_magazine"
        ;;
    Errotica_Archives)
        get_search "$dir" "$dir"
        get_search "$dir" "Errotica_Archives_Magazine"
        ;;
    FameGirls)
        get_search "$dir" "$dir"
        get_search "$dir" "famegirls.net"
        ;;
    Fantasy_Art)
        get_search "$dir" "$dir"
        get_search "$dir" "fantasy_girl"
        ;;
    Fictional_Character)
        get_search "$dir" "$dir"
        get_search "$dir" "Game_Characters"
        get_search "$dir" "Disharmonica"
        get_search "$dir" "Triss_Merigold"
        get_search "$dir" "Helly_von_Valentine"
        get_search "$dir" "Ann_Takamaki"
        ;;
    Femjoy)
        get_search "$dir" "$dir"
        get_search "$dir" "Femjoy_Magazine"
        get_search "$dir" "Femjoy.com"
        ;;
    FTV_Girls)
        get_search "$dir" "$dir"
        get_search "$dir" "FTV_Girls_Magazine"
        ;;
    Glasses)
        get_search "$dir" "$dir"
        get_search "$dir" "Women_With_Glasses"
        ;;
    Graphis.ne)
        get_search "$dir" "$dir"
        get_search "$dir" "Graphis"
        ;;
    Hard_Nipples)
        get_search "$dir" "$dir"
        get_search "$dir" "Perky_Nipples"
        ;;
    Perky_Breasts)
        get_search "$dir" "$dir"
        get_search "$dir" "Firm_Breasts"
        ;;
    Hegre-Art)
        get_search "$dir" "$dir"
        get_search "$dir" "hegre.com"
        ;;
    Hungarian)
        get_search "$dir" "$dir"
        get_search "$dir" "Hungarian_Women"
        get_search "$dir" "Alisa_I"
        ;;
    Japanese)
        get_search "$dir" "$dir"
        get_search "$dir" "Japanese_women"
        ;;
    Lesbian)
        get_search "$dir" "$dir"
        get_search "$dir" "Lesbians"
        ;;
    Met-Art)
        get_search "$dir" "$dir"
        get_search "$dir" "MetArt_Magazine"
        ;;
    Nubiles)
        get_search "$dir" "$dir"
        get_search "$dir" "Nubiles.net"
        ;;
    OnOff)
        get_search "$dir" "On/Off"
        ;;
    Overwatch)
        get_search "$dir" "$dir"
        get_search "$dir" "Personalami"
        get_search "$dir" "D.Va_\(Overwatch\)"
        ;;
    Playboy)
        get_search "$dir" "$dir"
        get_search "$dir" "Playboy_Plus"
        get_search "$dir" "Playmate"
        ;;
    Polish)
        get_search "$dir" "$dir"
        get_search "$dir" "Polish_Women"
        get_search "$dir" "Polish_model"
        get_search "$dir" "Aleksandra_Ola_Kaczmarek"
        get_search "$dir" "Amanda_Streich"
        get_search "$dir" "Angelika_Wachowska"
        get_search "$dir" "Iga_Wyrwal"
        get_search "$dir" "Justyna_Dabkowska"
        get_search "$dir" "Marta_Gut"
        get_search "$dir" "Monika_Pietrasinska"
        get_search "$dir" "Olga_Kaminska"
        get_search "$dir" "Sandra_Ciechomska"
        ;;
    Pubic_Hair)
        get_search "$dir" "$dir"
        get_search "$dir" "Natural_Pubic_Hair"
        ;;
    Redheads)
        get_search "$dir" "$dir"
        get_search "$dir" "redhead"
        ;;
    Renders)
        get_search "$dir" "$dir"
        get_search "$dir" "render"
        get_search "$dir" "3D"
        get_search "$dir" "CGI"
        get_search "$dir" "digital_art"
        ;;
    Russian)
        get_search "$dir" "$dir"
        get_search "$dir" "Russian_women"
        get_search "$dir" "Russian_girls"
        get_search "$dir" "Russian_Model"
        get_search "$dir" "Anastasia_Martzipanova"
        get_search "$dir" "Disha_Shemetova"
        get_search "$dir" "Ekaterina_Enokaeva"
        get_search "$dir" "Natalia_Andreeva"
        get_search "$dir" "Annabell"
        get_search "$dir" "Danica_A"
        get_search "$dir" "Danica_Jewels"
        get_search "$dir" "Helly_von_Valentine"
        get_search "$dir" "Natali_Nemtchinova"
        get_search "$dir" "Natalya_Andreeva"
        get_search "$dir" "Delilah_G"
        get_search "$dir" "MonroQ"
        get_search "$dir" "Katya_Sambuca"
        get_search "$dir" "Zu_Zu"
        ;;
    SexArt)
        get_search "$dir" "$dir"
        get_search "$dir" "SexArt_Magazine"
        ;;
    Short_Shorts)
        get_search "$dir" "$dir"
        get_search "$dir" "Booty_Shorts"
        ;;
    Smoking)
        get_search "$dir" "$dir"
        get_search "$dir" "Smoke"
        get_search "$dir" "cigarette"
        ;;
    Sucking_Nipples)
        get_search "$dir" "$dir"
        get_search "$dir" "boob_sucking"
        get_search "$dir" "biting_nipples"
        get_search "$dir" "licking_nipples"
        get_search "$dir" "tit_sucking"
        ;;
    Sunglasses)
        get_search "$dir" "$dir"
        get_search "$dir" "Women_With_Shades"
        get_search "$dir" "Women_With_Sunglasses"
        ;;
    SweetSinner)
        get_search "$dir" "$dir"
        get_search "$dir" "Mile_High_Media"
        ;;
    The_Life_Erotic)
        get_search "$dir" "$dir"
        get_search "$dir" "TheLifeErotic"
        ;;
    Tushy)
        get_search "$dir" "$dir"
        get_search "$dir" "Tushy.com"
        ;;
    Ukrainian)
        get_search "$dir" "$dir"
        get_search "$dir" "Ukraine"
        get_search "$dir" "Darina_Litvinova"
        get_search "$dir" "Anna_Sbitnaya"
        get_search "$dir" "Anna_AJ"
        get_search "$dir" "Gloria_Sol"
        get_search "$dir" "Mila_Azul"
        get_search "$dir" "Jasmine_Jazz"
        get_search "$dir" "Jula"
        get_search "$dir" "Kacy_Lane_\(Met-Art\)"
        get_search "$dir" "Kseniia_Kufeld"
        get_search "$dir" "Li_Moon"
        get_search "$dir" "Mara_Blake"
        get_search "$dir" "Marta_E"
        get_search "$dir" "Milena_D"
        get_search "$dir" "Oxana_Chic"
        get_search "$dir" "Katie_Fey"
        get_search "$dir" "Sabrina_Young"
        get_search "$dir" "Samadhi_Amor"
        get_search "$dir" "Ulya_Lexivia"
        get_search "$dir" "Vanda_Mey"
        get_search "$dir" "Viktoria_Yarova"
        ;;
    Vixen.com)
        get_search "$dir" "$dir"
        get_search "$dir" "Vixen"
        ;;
    Waterfall)
        get_search "$dir" "$dir"
        get_search "$dir" "Waterfalls"
        ;;
    Weapon)
        get_search "$dir" "$dir"
        get_search "$dir" "Gun"
        get_search "$dir" "Knife"
        get_search "$dir" "Sword"
        ;;
    Wet)
        get_search "$dir" "$dir"
        get_search "$dir" "Wet_Body"
        get_search "$dir" "Wet_Clothing"
        ;;
    WowGirls)
        get_search "$dir" "$dir"
        get_search "$dir" "Wow_Girls"
        ;;
    *)
        get_search "$dir" "$dir"
        ;;
    esac
done

inst=`type -p linkhaven`
[ "$inst" ] && linkhaven -a -q
[ -x ./wallclean ] && ./wallclean
[ "$FIND" ] && {
  [ -x ./findups ] && {
    # echo "Running ./findups"
    ./findups
  }
}
[ -x ./counts ] && {
    # echo "Running ./counts"
    ./counts
}
[ "$UPD" ] && {
  [ -x ../updsumhaven ] && {
    # echo "Running ../updsumhaven"
    ../updsumhaven > /dev/null
  }
}
