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
    numdown=1024
#   [ -x ~/bin/models ] && {
#     cnt=`~/bin/models -c -q $1`
#   }
    echo "Running ./get-search ${latest} -n ${numdown} -p 1 -l $1 -s $QUERY"
    ./get-search ${latest} -q -n ${numdown} -p 1 -l "$1" -s "$QUERY"
#   echo "Running ./get-search ${latest} -l $1 -s $QUERY"
#   ./get-search ${latest} -q -l "$1" -s "$QUERY"
}

get_model() {
    model="$1"
    cd "${WHVN}"
    case "$1" in
        Aleksa_Slusarchi)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Valeria_A"
            ;;
        Alena_Ushkova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Aliona_Aganova"
            get_search "${MODD}/${model}" "Alena_Aganova"
            get_search "${MODD}/${model}" "Alyona_Ushkova"
            get_search "${MODD}/${model}" "Alena_Night"
            ;;
        Alexandra_Smelova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Aleksandra_Smelova"
            get_search "${MODD}/${model}" "Sasha_Smelova"
            ;;
        Alina_Panevskaya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alina_Panewskaja"
            get_search "${MODD}/${model}" "Alinka_Rainer"
            get_search "${MODD}/${model}" "Alina_Maier"
            ;;
        Alisa_I)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alisa_Amore"
            get_search "${MODD}/${model}" "Alisa_A"
            get_search "${MODD}/${model}" "Alisa_Femjoy"
            get_search "${MODD}/${model}" "Jessica_Albanka"
            ;;
        Anita_Silver)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anita_C"
            get_search "${MODD}/${model}" "Vasilisa_Mudraja"
            ;;
        Anna_Sbitnaya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anna_AJ"
            get_search "${MODD}/${model}" "Anna_S"
            ;;
        Anna_Tatu)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Edwige_A"
            get_search "${MODD}/${model}" "Edwige"
            ;;
        Annele_Grace)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anna_Grace"
            get_search "${MODD}/${model}" "Ana_Grace"
            ;;
        Annely_Gerritsen)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anneli"
            get_search "${MODD}/${model}" "Pinky_June"
            ;;
        Aria_Salazar)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Bambi_Wolfe"
            ;;
        Blake_Bartelli)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Blake_Eden"
            ;;
        Brook_Amelia_Wright)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Brook_Wright"
            ;;
        Cara_Mell)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Rena_FemJoy"
            ;;
        Caramel)
            get_search "${MODD}/${model}" "${model}_\(Met-Art_Model\)"
            ;;
        Carolina_Kris)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Libby_White"
            get_search "${MODD}/${model}" "Libby"
            ;;
        Charlize)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "${model}_\(Met-art\)"
            ;;
        Conny_Lior)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Connie_Carter"
            get_search "${MODD}/${model}" "Josephine"
            ;;
        Dana_P)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Karissa_Diamond"
            get_search "${MODD}/${model}" "Katie_A"
            ;;
        Darina_Litvinova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Candice_B"
            ;;
        Dillion_Harper)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kelsey_Hayes"
            ;;
        Dina_P)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Violla_A"
            get_search "${MODD}/${model}" "Myza"
            ;;
        Divina_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Davina_A"
            ;;
        Ela_Savanas)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ela"
            ;;
        Elin_Eneji)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Elin"
            ;;
        Elizabeth_Marxs)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Elizabeth_Marx"
            ;;
        Ellina_Myuller)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ellina Muller"
            ;;
        Foxy_Di)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Angel_C"
            get_search "${MODD}/${model}" "Foxi_Di"
            get_search "${MODD}/${model}" "Katoa"
            get_search "${MODD}/${model}" "Medina_U"
            get_search "${MODD}/${model}" "Nensi"
            get_search "${MODD}/${model}" "Nensi_B"
            ;;
        Genevieve_Gandi)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Xana_D"
            ;;
        Georgia)
            get_search "${MODD}/${model}" "${model}_\(model\)"
            get_search "${MODD}/${model}" "Polina_Kadynskaya"
            get_search "${MODD}/${model}" "Susza_K."
            ;;
        Hailee_Rain)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Krysten_Pyle"
            ;;
        Hanna_Hilton)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Hannah_Hilton"
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
            get_search "${MODD}/${model}" "Paula_U"
            ;;
        Irina_Buromskih)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anya_MPL"
            get_search "${MODD}/${model}" "Irma_B"
            get_search "${MODD}/${model}" "Fibby"
            get_search "${MODD}/${model}" "Fibby_Femjoy"
            get_search "${MODD}/${model}" "Irin"
            get_search "${MODD}/${model}" "Ira"
            ;;
        Isabella_D)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ella_C"
            ;;
        Jasmine_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Zoi_Gorman"
            ;;
        Jenya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Jenya_D"
            get_search "${MODD}/${model}" "Katie_Fey"
            get_search "${MODD}/${model}" "Eugenia"
            get_search "${MODD}/${model}" "Eugenia_Diordiychuk"
            get_search "${MODD}/${model}" "Yevgeniya_Diordiychuk"
            ;;
        Justyna_Photodromm)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Justyna"
            ;;
        Karina_Avakian)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Karina_Avakyan"
            ;;
        Katerina_Bolinger)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Cute_Bunny"
            ;;
        Katerina_Hartlova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Katarina_Dubrova"
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
            get_search "${MODD}/${model}" "Clover_\(Femjoy\)"
            ;;
        Keeley_Hazell)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "keeley_hazel"
            get_search "${MODD}/${model}" "Keely_Hazel"
            get_search "${MODD}/${model}" "Kelley_Hazell"
            ;;
        Kiara_Diletto)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alina_N"
            get_search "${MODD}/${model}" "Beverly_A"
            get_search "${MODD}/${model}" "Nastasy"
            get_search "${MODD}/${model}" "Pelageya"
            ;;
        Kristina_Makarova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kris_Strange"
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
        Lilit_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ariela"
            get_search "${MODD}/${model}" "Natasha_Udovenko"
            ;;
        Lily_C)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Raisa"
            get_search "${MODD}/${model}" "Guerlain"
            get_search "${MODD}/${model}" "Natalia_E"
            ;;
        Liza_Voronina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Liza_B"
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
        Malinda)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Malinda_A"
            ;;
        Maria_Antsiborenko)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sofi_A"
            ;;
        Maria_Demina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Maria_Dyomina"
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
        Maxa)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Saloma"
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
        Mila_Azul)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ekaterina_Volkova"
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
        Nadya_Nabakova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Bunny_Colby"
            ;;
        Nadya_Rusu)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Nadia_Rusu"
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
            get_search "${MODD}/${model}" "Natali_Nemtchinova"
            get_search "${MODD}/${model}" "Natalya_Andreeva"
            get_search "${MODD}/${model}" "Delilah_G"
            get_search "${MODD}/${model}" "MonroQ"
            ;;
        Natalia_Tihomirova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Natasha_Tijomirova"
            get_search "${MODD}/${model}" "Natali_Tihomirova"
            ;;
#       Pammie_Lee)
#           get_search "${MODD}/${model}" "${model}"
#           get_search "${MODD}/${model}" "Anastasiya Platonova"
#           get_search "${MODD}/${model}" "Lubachka"
#           get_search "${MODD}/${model}" "Lubashka"
#           get_search "${MODD}/${model}" "Paula T"
#           get_search "${MODD}/${model}" "ShpitsyQ"
#           get_search "${MODD}/${model}" "Stacy Bloom"
#           get_search "${MODD}/${model}" "Winona"
#           ;;
        Paula_Shy)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Paula_De_Sousa"
            ;;
        Penelope_G)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Rafaella"
            get_search "${MODD}/${model}" "Raffaella"
            get_search "${MODD}/${model}" "Gyana_A"
            ;;
        Sabrisse_Aaliyah)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sabrisse"
            get_search "${MODD}/${model}" "Sabrisse_A"
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
            get_search "${MODD}/${model}" "Sofie_Lilith_\(iStripper.com\)"
            get_search "${MODD}/${model}" "Sofie_\(MetArt.com\)"
            get_search "${MODD}/${model}" "Nadine_\(PhotoDromm.com\)"
            ;;
        Stefani_Kovalyova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Izabella"
            get_search "${MODD}/${model}" "Ryana"
            ;;
        Stefanija)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Flower_Femjoy"
            ;;
        Sveta_Grashchenkova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sveta_Statham"
            ;;
        Sybil_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kailena"
            get_search "${MODD}/${model}" "Sybille_Y"
            get_search "${MODD}/${model}" "Davina_E"
            ;;
        Uma_Jolie)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Belicia_Segura"
            get_search "${MODD}/${model}" "Madeline_Clark"
            ;;
        Victoria_Sokolova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Viktoria_Sokolova"
            get_search "${MODD}/${model}" "Cali"
            ;;
        Vika_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alisa_G"
            ;;
        Whitney_Sarka)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Tabitha"
            get_search "${MODD}/${model}" "Lynne_\(Hegre\)"
            ;;
        Yana_West)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Rosalyn"
            get_search "${MODD}/${model}" "Innes_A"
            get_search "${MODD}/${model}" "Yana_Wellis"
            get_search "${MODD}/${model}" "Jane_G"
            ;;
        Yulia_Liepa)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Julia_Liepa"
            ;;
        Zuzana_Drabinova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Raylene_Richards"
            ;;
        *)
            get_search "${MODD}/${model}" "${model}"
            ;;
    esac
    cd "${WHVN}/${MODD}"
}

get_jav() {
    model="$1"
    cd "${WHVN}"
    case "${model}" in
        Julia_Kyoka)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "Julia_Boin"
            ;;
        Madoka_Hitomi)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "Hitomi_Madoka"
            ;;
        Meisa_Chibana)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "Chibana_Meisa"
            ;;
        Minami_Kojima)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "Kojima_Minami"
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
    cd "${WHVN}/${JAVD}"
}

get_suicide() {
    model="$1"
    cd "${WHVN}"
    case "${model}" in
        Alyona_German)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Aliona_German"
            get_search "${SUGD}/${model}" "Alenagerman_Suicide"
            get_search "${SUGD}/${model}" "Алёна"
            ;;
        Avrora)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Avrora_Suicide"
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
        Keshia_Hamlani)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Keshia_Suicide"
            ;;
        Lure_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Lurelady"
            ;;
        Milenci)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Milenci_Suicide"
            ;;
        Mille)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Mille_Suicide"
            ;;
        Misc)
            cd "${WHVN}/${SUGD}"
            ;;
        NattyBohh)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "NattyBohh_Suicide"
            ;;
        Nefka)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Micaela_Nefka"
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
    cd "${WHVN}/${SUGD}"
}

TOP="/Volumes/Seagate_8TB/Pictures/Work"
WHVN="${TOP}/Wallhaven"
MODD="Models"
JAVD="JAV_Idol"
SUGD="Suicide_Girls"
MODS=1
JAVC=1
SUIC=1
debug=
latest=
sums=1

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
    echo "Argument -S, do not update SUMS file"
    echo "Following arguments can indicate specific model folders/names"
    echo "Default is all models in specified subdir(s)"
    exit 1
}

while getopts jlmnsSu flag; do
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
        S)
            sums=
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

cd "${WHVN}"

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
  [ "$sums" ] && {
    [ -x ${TOP}/updsumhaven ] && {
      echo "Running ${TOP}/updsumhaven -m"
      [ "$debug" ] || ${TOP}/updsumhaven -m > /dev/null
    }
  }
}

cd "${WHVN}"

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
  [ "$sums" ] && {
    [ -x ${TOP}/updsumhaven ] && {
      echo "Running ${TOP}/updsumhaven -s"
      [ "$debug" ] || ${TOP}/updsumhaven -s > /dev/null
    }
  }
}

cd "${WHVN}"

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
  [ "$sums" ] && {
    [ -x ${TOP}/updsumhaven ] && {
      echo "Running ${TOP}/updsumhaven -j"
      [ "$debug" ] || ${TOP}/updsumhaven -j > /dev/null
    }
  }
}
