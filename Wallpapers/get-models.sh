#!/bin/bash
#
## @file Wallpapers/get-models.sh
## @brief Download wallpapers from Wallhaven in all current albums
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 1.0.1
##
get_search() {
    QUERY=`echo $2 | sed -e "s/_/\%2B/g"`
    echo "Running ./get-search ${latest} -n 2048 -p 1 -l $1 -s $QUERY"
    ./get-search ${latest} -q -n 2048 -p 1 -l "$1" -s "$QUERY"
    echo "Running ./get-search ${latest} -l $1 -s $QUERY"
    ./get-search ${latest} -q -l "$1" -s "$QUERY"
}

get_model() {
    model="$1"
    cd "${HERE}"
    case "$1" in
        Aleksa_Slusarchi)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Valeria_A"
            ;;
        Alexandra_Smelova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Aleksandra_Smelova"
            ;;
        Alina_Panevskaya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alina_Panewskaja"
            get_search "${MODD}/${model}" "Alinka_Rainer"
            ;;
        Alisa_I)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alisa_Amore"
            get_search "${MODD}/${model}" "Alisa_A"
            get_search "${MODD}/${model}" "Jessica_Albanka"
            ;;
        Anita_Silver)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anita_C"
            get_search "${MODD}/${model}" "Vasilisa_Mudraja"
            ;;
        Annele_Grace)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anna_Grace"
            get_search "${MODD}/${model}" "Ana_Grace"
            ;;
        Anna_Sbitnaya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anna_AJ"
            get_search "${MODD}/${model}" "Anna_S"
            ;;
        Annely_Gerritsen)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anneli"
            get_search "${MODD}/${model}" "Pinky_June"
            ;;
        Blake_Bartelli)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Blake_Eden"
            ;;
        Cara_Mell)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Rena_FemJoy"
            ;;
        Caramel)
            get_search "${MODD}/${model}" "${model}_(Met-Art_Model)"
            ;;
        Carolina_Kris)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Libby_White"
            get_search "${MODD}/${model}" "Libby"
            ;;
        Darina_Litvinova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Candice_B"
            ;;
        Elin_Eneji)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Elin"
            ;;
        Ellina_Myuller)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ellina Muller"
            ;;
        Foxy_Di)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Angel_C"
            get_search "${MODD}/${model}" "Katoa"
            get_search "${MODD}/${model}" "Nensi"
            get_search "${MODD}/${model}" "Medina_U"
            get_search "${MODD}/${model}" "Nensi_B"
            ;;
        Genevieve_Gandi)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Xana_D"
            ;;
        Georgia)
            get_search "${MODD}/${model}" "${model}_(model)"
            ;;
        Hailee_Rain)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Krysten_Pyle"
            ;;
        Heather_Vandeven)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Heather_V"
            ;;
        Heidi_Romanova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Adel"
            get_search "${MODD}/${model}" "Elina"
            get_search "${MODD}/${model}" "Heidi_R"
            get_search "${MODD}/${model}" "Heidi_Rom"
            get_search "${MODD}/${model}" "Heidi_Romanov"
            get_search "${MODD}/${model}" "Adel_C"
            get_search "${MODD}/${model}" "Adel_O"
            get_search "${MODD}/${model}" "Adel_C."
            ;;
        Hilary_C)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Viktoriia_Aliko"
            ;;
        Jasmine_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Zoi_Gorman"
            ;;
        Jenya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Katie_Fey"
            get_search "${MODD}/${model}" "Eugenia"
            get_search "${MODD}/${model}" "Eugenia_Diordiychuk"
            get_search "${MODD}/${model}" "Yevgeniya_Diordiychuk"
            ;;
        Justyna_Photodromm)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Justyna"
            ;;
        Katerina_Bolinger)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Cute_Bunny"
            ;;
        Kateryna_Marchenko)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kate_Chromia"
            ;;
        Katy_Jones)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Elina_Sweet"
            get_search "${MODD}/${model}" "Kata"
            get_search "${MODD}/${model}" "Kate_Jones"
            get_search "${MODD}/${model}" "Katerina"
            get_search "${MODD}/${model}" "Katerina_C"
            get_search "${MODD}/${model}" "Katka"
            get_search "${MODD}/${model}" "Margherita"
            get_search "${MODD}/${model}" "Nela_Gold"
            get_search "${MODD}/${model}" "Nella_Never"
            get_search "${MODD}/${model}" "Nordica"
            get_search "${MODD}/${model}" "Odara_D"
            ;;
        Katya_Clover)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ekaterina_Skaredina"
            ;;
        Kristina_Shcherbinina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Liya_Silver"
            ;;
        Kristina_Uhrinova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Melisa_Mendiny"
            get_search "${MODD}/${model}" "Melisa_Mendini"
            ;;
        Krystal_Boyd)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Katherine_A."
            ;;
        Lera_Kovalenko)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Valeryia_Kovalenko"
            ;;
        Li_Moon)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Annika_A"
            ;;
        Lucia_Javorcekova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Lucia_Javorčeková"
            ;;
        Malena_Fendi)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Malena_F"
            get_search "${MODD}/${model}" "Malena"
            get_search "${MODD}/${model}" "Lada_Brik"
            get_search "${MODD}/${model}" "Black_Cherry"
            ;;
        Maria_Antsiborenko)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sofi_A"
            ;;
        Maria_Ryabushkina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Maria_Rya"
            get_search "${MODD}/${model}" "Melena_A"
            ;;
        Mariko_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Mariko"
            ;;
        Marketa_Pechova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Cikita"
            get_search "${MODD}/${model}" "Chikita"
            ;;
        Marketa_Stroblova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Markéta_Stroblová"
            get_search "${MODD}/${model}" "Marketa"
            get_search "${MODD}/${model}" "Caprice"
            get_search "${MODD}/${model}" "Caprice_A"
            get_search "${MODD}/${model}" "Caprice_S"
            get_search "${MODD}/${model}" "Caprise"
            ;;
        Melissa_Clarke)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Mellisa_Clarke"
            ;;
        Michelle_H._Paghie)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Michelle_H"
            get_search "${MODD}/${model}" "The_Red_Fox"
            get_search "${MODD}/${model}" "Red_Fox"
            ;;
        Mila_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Milla"
            get_search "${MODD}/${model}" "Mila_E"
            get_search "${MODD}/${model}" "Milana"
            ;;
        Milena_D)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Taya_Karpenko"
            ;;
        Monika_C)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Monica_M"
            get_search "${MODD}/${model}" "Monika_Mohrova"
            ;;
        Monika_V)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Tempe"
            ;;
        Nancy_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Nancy_Photodromm"
            ;;
        Nata_Lee)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Natalya_Krasavina"
            ;;
        Natalia_Andreeva)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Annabell"
            get_search "${MODD}/${model}" "Danica_A"
            get_search "${MODD}/${model}" "Danica_Jewels"
            ;;
        Natalia_Tihomirova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Natasha_Tijomirova"
            get_search "${MODD}/${model}" "Natali_Tihomirova"
            ;;
        Paula_Shy)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Paula_De_Sousa"
            ;;
        Sapphira_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sapphira"
            ;;
        Sarika_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Darina_Nikitina"
            ;;
        Selena_Werner)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Selena_Verner"
            ;;
        Sofie_Lilith)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sofie_Lilith_(iStripper.com)"
            get_search "${MODD}/${model}" "Sofie_(MetArt.com)"
            get_search "${MODD}/${model}" "Nadine_(PhotoDromm.com)"
            ;;
        Sveta_Grashchenkova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sveta_Statham"
            ;;
        Sybil_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kailena"
            get_search "${MODD}/${model}" "Sybille_Y"
            ;;
        Victoria_Sokolova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Viktoria_Sokolova"
            get_search "${MODD}/${model}" "Cali"
            ;;
        Yana_West)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Rosalyn"
            get_search "${MODD}/${model}" "Innes_A"
            get_search "${MODD}/${model}" "Yana_Wellis"
            get_search "${MODD}/${model}" "Jane_G"
            ;;
        Zuzana_Drabinova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Raylene_Richards"
            ;;
        *)
            get_search "${MODD}/${model}" "${model}"
            ;;
    esac
    cd "${HERE}/${MODD}"
}

get_jav() {
    model="$1"
    cd "${HERE}"
    case "${model}" in
        Julia_Kyoka)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "Julia_Boin"
            ;;
        Utsunomiya_Shion)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "Shion_Utsunomiya"
            get_search "${JAVD}/${model}" "Rara_Anzai"
            ;;
        *)
            get_search "${JAVD}/${model}" "${model}"
            ;;
    esac
    cd "${HERE}/${JAVD}"
}

get_suicide() {
    model="$1"
    cd "${HERE}"
    case "${model}" in
        Alyona_German)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Aliona_German"
            get_search "${SUGD}/${model}" "Alenagerman_Suicide"
            ;;
        Coralinne_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Sara_Calixto"
            ;;
        Ellie_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Elise_Laurenne"
            ;;
        Ivory_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Ivory"
            ;;
        Katrina_Novikova)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Killer_Suicide"
            get_search "${SUGD}/${model}" "Killer_Katrin"
            get_search "${SUGD}/${model}" "Natalia_M"
            ;;
        Milenci)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Milenci_Suicide"
            ;;
        Misc)
            cd "${HERE}/${SUGD}"
            ;;
        Octavia_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            mname=`echo ${model} | sed -e "s/_Suicide/may_\(Suicide_Girls\)/"`
            get_search "${SUGD}/${model}" "${mname}"
            ;;
        Scribbles_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Jo_Evans"
            ;;
        *Suicide_Girls*)
            get_search "${SUGD}/${model}" "${model}"
            mname=`echo ${model} | sed -e "s/Suicide_Girls/\(Suicide_Girls\)/"`
            get_search "${SUGD}/${model}" "${mname}"
            ;;
        *)
            get_search "${SUGD}/${model}" "${model}"
            ;;
    esac
    cd "${HERE}/${SUGD}"
}

HERE=`pwd`
MODD="Models"
JAVD="JAV_Idol"
SUGD="Suicide_Girls"
MODS=1
JAVC=1
SUIC=1
debug=
latest=

# Argument -l indicates retrieve latest wallpapers.
# Argument -n indicates debug mode.
# Argument -m indicates only do Models subdir.
# Argument -j, only JAV_Idol.
# Argument -s, only Suicide_Girls.
# Following arguments can indicate specific model folders/names
# Default is all models in specified subdir(s)

usage() {
    echo "Usage: get-models [-l] [-n] [-m] [-j] [-s] [-u] [model names]"
    echo "Argument -l indicates retrieve latest wallpapers"
    echo "Argument -n indicates debug mode"
    echo "Argument -m indicates only do Models subdir"
    echo "Argument -j, only JAV_Idol"
    echo "Argument -s, only Suicide_Girls"
    echo "Following arguments can indicate specific model folders/names"
    echo "Default is all models in specified subdir(s)"
    exit 1
}

while getopts jlmnsu flag; do
    case $flag in
        j)
            MODS=
            SUIC=
            ;;
        m)
            SUIC=
            JAVC=
            ;;
        l)
            latest="-R"
            ;;
        n)
            debug=1
            ;;
        s)
            MODS=
            JAVC=
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))
MODELS="$*"
[ "$MODS" ] && {
  # The Models subdirectory
  [ "$debug" ] || cd ${MODD}
  if [ "$MODELS" ]
  then
    for name in $*
    do
      [ "$debug" ] && {
        echo "Calling get_model() for $name"
        continue
      }
      [ -d "${name}" ] || continue
      get_model "$name"
    done
  else
    for name in *
    do
      [ "$debug" ] && {
        echo "Calling get_model() for $name"
        continue
      }
      [ -d "${name}" ] || continue
      get_model "$name"
    done
  fi
}

cd "${HERE}"

[ "$SUIC" ] && {
  # The Suicide_Girls subdirectory
  [ "$debug" ] || cd ${SUGD}
  if [ "$MODELS" ]
  then
    for name in $*
    do
      [ "$debug" ] && {
        echo "Calling get_suicide() for $name"
        continue
      }
      [ -d "${name}" ] || continue
      get_suicide "$name"
    done
  else
    for name in *
    do
      [ "$debug" ] && {
        echo "Calling get_suicide() for $name"
        continue
      }
      [ -d "${name}" ] || continue
      get_suicide "$name"
    done
  fi
}

cd "${HERE}"

[ "$JAVC" ] && {
  # The JAV_Idol subdirectory
  [ "$debug" ] || cd ${JAVD}
  if [ "$MODELS" ]
  then
    for name in $*
    do
      [ "$debug" ] && {
        echo "Calling get_jav() for $name"
        continue
      }
      [ -d "${name}" ] || continue
      get_jav "$name"
    done
  else
    for name in *
    do
      [ "$debug" ] && {
        echo "Calling get_jav() for $name"
        continue
      }
      [ -d "${name}" ] || continue
      get_jav "$name"
    done
  fi
}
