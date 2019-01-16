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
        Aleksa_Slusarchi)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Valeria_A"
            ;;
        Alexandra_Smelova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Aleksandra_Smelova"
            ;;
        Alisa_I)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Alisa_Amore"
            get_search "Models/${model}" "Alisa_A"
            get_search "Models/${model}" "Jessica_Albanka"
            ;;
        Annele_Grace)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Anna_Grace"
            get_search "Models/${model}" "Ana_Grace"
            ;;
        Anna_Sbitnaya)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Anna_AJ"
            get_search "Models/${model}" "Anna_S"
            ;;
        Annely_Gerritsen)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Anneli"
            get_search "Models/${model}" "Pinky_June"
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
        Ellie_Suicide)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Elise_Laurenne"
            ;;
        Ellina_Myuller)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Ellina Muller"
            ;;
        Georgia)
            get_search "Models/${model}" "${model}_(model)"
            ;;
        Hailee_Rain)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Krysten_Pyle"
            ;;
        Heather_Vandeven)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Heather_V"
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
        Hilary_C)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Viktoriia_Aliko"
            ;;
        Justyna_Photodromm)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Justyna"
            ;;
        Katerina_Bolinger)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Cute_Bunny"
            ;;
        Kateryna_Marchenko)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Kate_Chromia"
            ;;
        Kristina_Shcherbinina)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Liya_Silver"
            ;;
        Kristina_Uhrinova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Melisa_Mendiny"
            get_search "Models/${model}" "Melisa_Mendini"
            ;;
        Krystal_Boyd)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Katherine_A."
            ;;
        Lera_Kovalenko)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Valeryia_Kovalenko"
            ;;
        Li_Moon)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Annika_A"
            ;;
        Maria_Antsiborenko)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Sofi_A"
            ;;
        Marketa_Pechova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Cikita"
            get_search "Models/${model}" "Chikita"
            ;;
        Marketa_Stroblova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Markéta_Stroblová"
            get_search "Models/${model}" "Marketa"
            get_search "Models/${model}" "Caprice"
            get_search "Models/${model}" "Caprice_A"
            get_search "Models/${model}" "Caprice_S"
            get_search "Models/${model}" "Caprise"
            ;;
        Melissa_Clarke)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Mellisa_Clarke"
            ;;
        Michelle_H._Paghie)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Michelle_H"
            get_search "Models/${model}" "The_Red_Fox"
            get_search "Models/${model}" "Red_Fox"
            ;;
        Mila_A)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Milla"
            get_search "Models/${model}" "Mila_E"
            get_search "Models/${model}" "Milana"
            ;;
        Milena_D)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Taya_Karpenko"
            ;;
        Monika_C)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Monica_M"
            get_search "Models/${model}" "Monika_Mohrova"
            ;;
        Nancy_A)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Nancy_Photodromm"
            ;;
        Natalia_Andreeva)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Annabell"
            get_search "Models/${model}" "Danica_A"
            get_search "Models/${model}" "Danica_Jewels"
            ;;
        Octavia_Suicide)
            get_search "Models/${model}" "${model}"
            mname=`echo ${model} | sed -e "s/_Suicide/may_\(Suicide_Girls\)/"`
            get_search "Models/${model}" "${mname}"
            ;;
        Sapphira_A)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Sapphira"
            ;;
        Sarika_A)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Darina_Nikitina"
            ;;
        Scribbles_Suicide)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Jo_Evans"
            ;;
        Selena_Werner)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Selena_Verner"
            ;;
        *Suicide_Girls*)
            get_search "Models/${model}" "${model}"
            mname=`echo ${model} | sed -e "s/Suicide_Girls/\(Suicide_Girls\)/"`
            get_search "Models/${model}" "${mname}"
            ;;
        Sveta_Grashchenkova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Sveta_Statham"
            ;;
        Sybil_A)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Kailena"
            ;;
        Victoria_Sokolova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Viktoria_Sokolova"
            ;;
        Zuzana_Drabinova)
            get_search "Models/${model}" "${model}"
            get_search "Models/${model}" "Raylene_Richards"
            ;;
        *)
            get_search "Models/${model}" "${model}"
            ;;
    esac
    cd Models
done
cd "${HERE}"
