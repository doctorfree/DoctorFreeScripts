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
    echo "Running ./get-search -p 1 -l $1 -s $QUERY"
    ./get-search -q -p 1 -l "$1" -s "$QUERY"
    echo "Running ./get-search -l $1 -s $QUERY"
    ./get-search -q -l "$1" -s "$QUERY"
}

HERE=`pwd`

cd Models
for model in *
do
    [ -d "${model}" ] || continue
    cd "${HERE}"
    case "${model}" in
        Anna_Sbitnaya)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Anna_AJ"
            get_search "Models/${model}" "Anna_S"
            ;;
        Caramel)
            get_search "Models/${model}" "${model}_(Met-Art_Model)"
            ;;
        Coralinne_Suicide)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Sara_Calixto"
            ;;
        Darina_Litvinova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Candice_B"
            ;;
        Elin_Eneji)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Elin"
            ;;
        Georgia)
            get_search "Models/${model}" "${model}_(model)"
            ;;
        Heidi_Romanova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Adel"
            get_search "Models/${model}" "Elina"
            get_search "Models/${model}" "Heidi_R"
            get_search "Models/${model}" "Heidi_Rom"
            get_search "Models/${model}" "Heidi_Romanov"
            get_search "Models/${model}" "Adel_C"
            get_search "Models/${model}" "Adel_O"
            get_search "Models/${model}" "Adel_C."
            ;;
        Li_Moon)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Annika_A"
            ;;
        Maria_Antsiborenko)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Sofi_A"
            ;;
        Mila_A)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Milla"
            get_search "Models/${model}" "Mila_E"
            get_search "Models/${model}" "Milana"
            ;;
        Natalia_Andreeva)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Annabell"
            get_search "Models/${model}" "Danica"
            ;;
        *Suicide_Girls*)
            get_search "Models/${model}" "${model}"
            mname=`echo ${model} | sed -e "s/Suicide_Girls/\(Suicide_Girls\)/"`
            get_search "Models/${model}" "${mname}"
            ;;
        *)
            get_search "Models/${model}" "${model}"
            ;;
    esac
    cd Models
done
cd "${HERE}"
