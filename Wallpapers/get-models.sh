#!/bin/bash
#
## @file Wallpapers/get-models.sh
## @brief Download wallpapers from Wallhaven in all current albums
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2016
## @version 2.0.1
##
get_search() {
    QUERY=`echo $2 | sed -e "s/_/\%2B/g"`
#   numdown=1024
#   [ -x ~/bin/models ] && {
#     cnt=`~/bin/models -c -q $1`
#   }
    # echo "Running get-search ${latest} -n ${numdown} -p 1 -l $1 -s $QUERY"
    get-search ${latest} -q -n ${numdown} -p 1 -l "$1" -s "$QUERY"
#   echo "Running get-search ${latest} -l $1 -s $QUERY"
#   get-search ${latest} -q -l "$1" -s "$QUERY"
}

get_model() {
    model="$1"
    cd "${WHVN}"
    case "$1" in
        Adriana_F)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Adriana_Morriss"
            ;;
        Alena_Hemkova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Scarlett_A"
            get_search "${MODD}/${model}" "Cheryl_C"
            ;;
        Alena_Ushkova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Aliona_Aganova"
            get_search "${MODD}/${model}" "Alena_Aganova"
            get_search "${MODD}/${model}" "Alyona_Ushkova"
            get_search "${MODD}/${model}" "Alena_Night"
            ;;
        Alexandra_Zimny)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Marisa"
            ;;
        Alina_Gorokhova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alina_Gorohova"
            ;;
        Alina_Panevskaya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alina_Panewskaja"
            get_search "${MODD}/${model}" "Alinka_Rainer"
            get_search "${MODD}/${model}" "Alina_Maier"
            get_search "${MODD}/${model}" "Alina_Mayer"
            ;;
        Alisa_I)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alisa_Amore"
            get_search "${MODD}/${model}" "Alisa_A"
            get_search "${MODD}/${model}" "Alisa_Femjoy"
            get_search "${MODD}/${model}" "Alisa_Hegre"
            get_search "${MODD}/${model}" "Jessica_Albanka"
            ;;
        Anastasia_Aleksandrova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Alice_Wonder_\(Met-Art\)"
            get_search "${MODD}/${model}" "Anastasia_Alexandrova"
            get_search "${MODD}/${model}" "Nastya_Aleksandrova"
            ;;
        Anastasia_Martzipanova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anastasya"
            ;;
        Anastasia_Petrova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Chantelle_A"
            ;;
        Anastasia_Scheglova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anastasia_Schlegova"
            get_search "${MODD}/${model}" "Anastasia_Shcheglova"
            get_search "${MODD}/${model}" "Anastasiya_Scheglova"
            ;;
        Anastasia_Sujorukova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anastasia_Sukhorukova"
            ;;
        Angelika_Wachowska)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Jackie_Photodromm"
            get_search "${MODD}/${model}" "Jackie"
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
        Any_Tsareva)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Amy_Tsareva"
            ;;
        Anya_Dmitrieva)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "BerylQ"
            ;;
        Apolonia_Lapiedra)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Apolonia"
            ;;
        Aria_Salazar)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Bambi_Wolfe"
            ;;
        Ariel_Piper_Fawn)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Piper_Fawn"
            ;;
        Avery)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Nona"
            ;;
        Blake_Bartelli)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Blake_Eden"
            ;;
        Brook_Amelia_Wright)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Brook_Wright"
            ;;
        Caramel)
            get_search "${MODD}/${model}" "${model}_\(Met-Art_Model\)"
            ;;
        Carolina_Kris)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Libby_White"
            get_search "${MODD}/${model}" "Libby"
            get_search "${MODD}/${model}" "Carolina_K"
            ;;
        Charlize)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "${model}_\(Met-art\)"
            ;;
        Christina_Tishova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kristina_Tishova"
            ;;
        Clarice_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Elvira_U"
            get_search "${MODD}/${model}" "Clarice"
            ;;
        Conny_Lior)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Connie_Carter"
            get_search "${MODD}/${model}" "Josephine"
            ;;
        Darya_Chekanova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Daria_Chekanova"
            ;;
        Diana_\(Famegirls\))
            get_search "${MODD}/${model}" "Diana_\(Famegirls\)"
            get_search "${MODD}/${model}" "Diana_Jam"
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
        Elle_Tan)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Elle_P"
            ;;
        Ellina_Myuller)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Ellina Muller"
            ;;
        Emmy)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Arina_F"
            ;;
        Eva_Chejova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Eva_Chehova"
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
        Gabbie_Carter)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Gabbie_\(FTV\)"
            ;;
        Galina_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Cecelia"
            ;;
        Polina_Kadynskaya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Georgia_\(model\)"
            get_search "${MODD}/${model}" "Georgia_\(MetArt\)"
            get_search "${MODD}/${model}" "Susza_K."
            ;;
        Hailee_Rain)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Krysten_Pyle"
            ;;
        Hailey_Lynzz)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sofi_Ryan"
            ;;
        Hanna_Hilton)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Hannah_Hilton"
            ;;
        Helen_H)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Vic_E"
            ;;
        Helga_Grey)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Goldie_Baby"
            ;;
        Helly_von_Valentine)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Disharmonica"
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
        Irina_Telicheva)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Tasha_\(Hegre-Art\)"
            get_search "${MODD}/${model}" "Tasha\(Hegre\)"
            ;;
        Isabella_Star)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Emily_Cutie"
            ;;
        Ivette_Blanche)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Linda_L_\(Hegre-Art\)"
            ;;
        Janelle_B)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Janelle_B."
            ;;
        Janesinner)
            get_search "${MODD}/${model}" "${model}_Suicide"
            get_search "${MODD}/${model}" "Jane_Sinner"
            get_search "${MODD}/${model}" "Yana_Sinner"
            ;;
        Jasmine_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Zoi_Gorman"
            get_search "${MODD}/${model}" "Jasmine_Andreas"
            get_search "${MODD}/${model}" "Clio_Photodromm"
            ;;
        Jenni_Gregg)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Jenny_Gregg"
            ;;
        Jia_Lissa)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sherice"
            ;;
        Josephine_B)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Josephine_Jackson"
            get_search "${MODD}/${model}" "Josephine_C."
            ;;
        Julia_Rommelt)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Julia_Roemmelt"
            ;;
        Karina_Avakian)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Karina_Avakyan"
            ;;
        Kate_Fresh)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Lulya_D"
            get_search "${MODD}/${model}" "Lulya"
            ;;
        Katerina_Hartlova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Katarina_Dubrova"
            ;;
        Katerina_Raykh)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Katerina_Raij"
            ;;
        Katerina_Shiryaeva)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Katerina_Shiriaeva"
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
            get_search "${MODD}/${model}" "Anastasia_\(PhotoDromm\)"
            get_search "${MODD}/${model}" "Beverly_A"
            get_search "${MODD}/${model}" "Nastasy"
            get_search "${MODD}/${model}" "Pelageya"
            ;;
        Kiere)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Gala_Ann"
            ;;
        Kristina_Makarova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kris_Strange"
            ;;
        Kristina_Shcherbinina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Liya_Silver"
            ;;
        Krystal_Boyd)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Anjelica"
            get_search "${MODD}/${model}" "Ebbi"
            get_search "${MODD}/${model}" "Katherine_A."
            get_search "${MODD}/${model}" "Ksenia_Kondratyeva"
            ;;
        Lana_Lane_\(MPL_Studios\))
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Lana_Lane"
            ;;
        Lera_Kovalenko)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Valeryia_Kovalenko"
            ;;
        Li_Moon)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Annika_A"
            ;;
        Lidia_Savoderova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kamilla_J"
            ;;
        Liza_Voronina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Liza_B"
            ;;
        Lizzie_Ryan)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Lizzy_Ryan"
            ;;
        Lucia_Javorcekova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Lucia_Javorčeková"
            ;;
        Magen)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Magen_\(Model\)"
            get_search "${MODD}/${model}" "Magen_Hana"
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
        Marit)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Marit_Silalatu"
            ;;
        Marketa_Pechova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Cikita"
            get_search "${MODD}/${model}" "Chikita"
            ;;
        Marry_Queen)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Miela"
            ;;
        Maxa)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Saloma"
            ;;
        Meaghan_Stanfill)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Meg_Cyria"
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
        Milena_D)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sunna"
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
        Muriel)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Muriel_Senderos"
            get_search "${MODD}/${model}" "Muryel_Senderos"
            get_search "${MODD}/${model}" "Muriel_Hegre"
            get_search "${MODD}/${model}" "Muriel_Makovitz"
            ;;
        Mya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Jati"
            get_search "${MODD}/${model}" "Hella_G"
            ;;
        Nancy_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Nancy_Photodromm"
            get_search "${MODD}/${model}" "Nancy_Ace"
            get_search "${MODD}/${model}" "Nancy_Anastasiia"
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
        Natalia_Forrest)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Natalia_Forest"
            ;;
        Natalia_Shilova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Lia"
            ;;
        Natalia_Tihomirova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Natasha_Tijomirova"
            get_search "${MODD}/${model}" "Natali_Tihomirova"
            ;;
        Nikia_Dolceza)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Nikia"
            ;;
        Nina_North)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "FTV_Nina"
            get_search "${MODD}/${model}" "Nina_X."
            ;;
        Octokuro)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Marina_Octokuro"
            ;;
        Olesia_Levina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Olesya_Levina"
            ;;
        Olesya_Bukhtoyarova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Olesia_Bujtoyarova"
            ;;
        Olga_Kaminska)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Olga_Maria_Kaminska"
            ;;
        Olga_Rudik)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Mariposa"
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
        Patritcy_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Maria_Pie"
            ;;
        Paula_Shy)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Paula_De_Sousa"
            get_search "${MODD}/${model}" "Christy_Charming"
            ;;
        Photodromm)
            for photomodel in ${MODD}/Photodromm/*
            do
              [ "${photomodel}" == "${MODD}/Photodromm/*" ] && continue
              [ -d "${photomodel}" ] || continue
              modelname=`basename ${photomodel}`
              get_search "${photomodel}" "${modelname}"
              case "$modelname" in
                Brittie_Photodromm)
                  get_search "${photomodel}" "Brittie"
                  ;;
                Claudia_Photodromm)
                  get_search "${photomodel}" "Claudia"
                  ;;
                Isabelle_Photodromm)
                  get_search "${photomodel}" "Isabelle"
                  ;;
                Justyna_Dabkowska)
                  get_search "${photomodel}" "Justyna"
                  get_search "${photomodel}" "Justyna_Photodromm"
                  ;;
                Karola_Photodromm)
                  get_search "${photomodel}" "Karola"
                  ;;
                Maria_Dezideryeva)
                  get_search "${photomodel}" "Maria_Photodromm"
                  get_search "${photomodel}" "Maria_Dreamgirl"
                  ;;
                Rachel_Photodromm)
                  get_search "${photomodel}" "Taliah"
                  get_search "${photomodel}" "Anna_D"
                  get_search "${photomodel}" "Bree_H"
                  get_search "${photomodel}" "Diana_Dulce"
                  get_search "${photomodel}" "Elina_Dee"
                  ;;
                Yasmin_Photodromm)
                  get_search "${photomodel}" "Yasmin"
                  ;;
                Yulia_Dimetra)
                  get_search "${photomodel}" "Fabiana"
                  get_search "${photomodel}" "Fabiana_\(PhotoDromm\)"
                  ;;
              esac
            done
            ;;
        Playboy)
            for playboymodel in ${MODD}/Playboy/*
            do
              [ -d "${playboymodel}" ] || continue
              modelname=`basename ${playboymodel}`
              get_search "${playboymodel}" "${modelname}"
              case "$modelname" in
                Aleksa_Slusarchi)
                  get_search "${playboymodel}" "Valeria_A"
                  ;;
                Alexandra_Smelova)
                  get_search "${playboymodel}" "Aleksandra_Smelova"
                  get_search "${playboymodel}" "Sasha_Smelova"
                  ;;
                Amelie_B)
                  get_search "${playboymodel}" "Amelie_Belain"
                  ;;
                Anna_Tatu)
                  get_search "${playboymodel}" "Edwige_A"
                  get_search "${playboymodel}" "Edwige"
                  ;;
                Audrey_Pankovna)
                  get_search "${playboymodel}" "Audrey"
                  ;;
                Calypso)
                  get_search "${playboymodel}" "Calypso_Muse"
                  ;;
                Cara_Mell)
                  get_search "${playboymodel}" "Rena_FemJoy"
                  ;;
                Dana_P)
                  get_search "${playboymodel}" "Karissa_Diamond"
                  get_search "${playboymodel}" "Katie_A"
                  ;;
                Darina_Litvinova)
                  get_search "${playboymodel}" "Darina_L"
                  get_search "${playboymodel}" "Candice_B"
                  get_search "${playboymodel}" "Candice_Brielle"
                  ;;
                Dominika_C)
                  get_search "${playboymodel}" "Dominika_Chybova"
                  ;;
                Eden_Arya)
                  get_search "${playboymodel}" "Eden_Hegre"
                  ;;
                Elin_Eneji)
                  get_search "${playboymodel}" "Aya_Beshen"
                  get_search "${playboymodel}" "Elin"
                  get_search "${playboymodel}" "Alina_Photodromm"
                  ;;
                Elizabeth_Marxs)
                  get_search "${playboymodel}" "Elizabeth_Marx"
                  ;;
                Emily_Agnes)
                  get_search "${playboymodel}" "Emily_Shaw"
                  ;;
                Evita_Lima)
                  get_search "${playboymodel}" "Evelina"
                  ;;
                Genevieve_Gandi)
                  get_search "${playboymodel}" "Marianna_Merkulova"
                  get_search "${playboymodel}" "Xana_D"
                  get_search "${playboymodel}" "Erika_A."
                  ;;
                Heidi_Romanova)
                  get_search "${playboymodel}" "Heidi_R"
                  get_search "${playboymodel}" "Heidi_Rom"
                  get_search "${playboymodel}" "Heidi_Romanov"
                  get_search "${playboymodel}" "Adel_C"
                  get_search "${playboymodel}" "Adel_O"
                  get_search "${playboymodel}" "Adel_C."
                  ;;
                Isabella)
                  get_search "${playboymodel}" "Isabella_\(famegirls\)"
                  ;;
                Isabella_D)
                  get_search "${playboymodel}" "Ella_C"
                  ;;
                Jenya)
                  get_search "${playboymodel}" "Jenya_D"
                  get_search "${playboymodel}" "Katie_Fey"
                  get_search "${playboymodel}" "Eugenia"
                  get_search "${playboymodel}" "Eugenia_Diordiychuk"
                  get_search "${playboymodel}" "Eugenia_Dior"
                  get_search "${playboymodel}" "Yevgeniya_Diordiychuk"
                  ;;
                Juniper_Hope)
                  get_search "${playboymodel}" "Hopelesssofrantic_Suicide"
                  get_search "${playboymodel}" "Hopelesssofrantic"
                  ;;
                Kateryna_Marchenko)
                  get_search "${playboymodel}" "Kate_Chromia"
                  ;;
                Katerina_Bolinger)
                  get_search "${playboymodel}" "Cute_Bunny"
                  ;;
                Katy_Jones)
                  get_search "${playboymodel}" "Elina_Sweet"
                  get_search "${playboymodel}" "Kata"
                  get_search "${playboymodel}" "Kate_Jones"
                  get_search "${playboymodel}" "Katerina_C"
                  get_search "${playboymodel}" "Katka"
                  get_search "${playboymodel}" "Margherita"
                  get_search "${playboymodel}" "Nela_Gold"
                  get_search "${playboymodel}" "Nella_Never"
                  get_search "${playboymodel}" "Nordica"
                  get_search "${playboymodel}" "Odara_D"
                  ;;
                Katya_Clover)
                  get_search "${playboymodel}" "Ekaterina_Skaredina"
                  get_search "${playboymodel}" "Clover_\(Femjoy\)"
                  ;;
                Kristina_Uhrinova)
                  get_search "${playboymodel}" "Melisa_Mendiny"
                  get_search "${playboymodel}" "Melisa_Mendini"
                  get_search "${playboymodel}" "Melisa"
                  ;;
                Lilit_A)
                  get_search "${playboymodel}" "Lilit_Ariel"
                  get_search "${playboymodel}" "Ariel_Lilit_A"
                  get_search "${playboymodel}" "Ariela"
                  get_search "${playboymodel}" "Natasha_Udovenko"
                  ;;
                Lily_C)
                  get_search "${playboymodel}" "Lily_Chey"
                  get_search "${playboymodel}" "Raisa"
                  get_search "${playboymodel}" "Guerlain"
                  get_search "${playboymodel}" "Natalia_E"
                  ;;
                Lorena_Garcia)
                  get_search "${playboymodel}" "Lorena_F"
                  get_search "${playboymodel}" "Lorena_G"
                  get_search "${playboymodel}" "Lorena"
                  ;;
                Macy_B)
                  get_search "${playboymodel}" "Jenna_T"
                  get_search "${playboymodel}" "Anna_Demi"
                  get_search "${playboymodel}" "Demi_B"
                  ;;
                Maria_Antsiborenko)
                  get_search "${playboymodel}" "Sofi_A"
                  ;;
                Marketa_Stroblova)
                  get_search "${playboymodel}" "Markéta_Stroblová"
                  get_search "${playboymodel}" "Marketa"
                  get_search "${playboymodel}" "Caprice"
                  get_search "${playboymodel}" "Caprice_A"
                  get_search "${playboymodel}" "Caprice_S"
                  get_search "${playboymodel}" "Caprise"
                  ;;
                Maya)
                  get_search "${playboymodel}" "Maya_Dmitrieva"
                  ;;
                Mila_A)
                  get_search "${playboymodel}" "Milla"
                  get_search "${playboymodel}" "Mila_E"
                  get_search "${playboymodel}" "Milana"
                  ;;
                Mila_Azul)
                  get_search "${playboymodel}" "Ekaterina_Volkova"
                  ;;
                Miluniel_Louis)
                  get_search "${playboymodel}" "Melanie_Nizette"
                  ;;
                Natalia_Andreeva)
                  get_search "${playboymodel}" "Annabell"
                  get_search "${playboymodel}" "Danica_A"
                  get_search "${playboymodel}" "Danica_Jewels"
                  get_search "${playboymodel}" "Natali_Nemtchinova"
                  get_search "${playboymodel}" "Natalia_Nemchinova"
                  get_search "${playboymodel}" "Natalya_Andreeva"
                  get_search "${playboymodel}" "Natali_Andreeva"
                  get_search "${playboymodel}" "Delilah_G"
                  get_search "${playboymodel}" "MonroQ"
                  ;;
                Nicole_Young)
                  get_search "${playboymodel}" "Nika_Kolosova"
                  get_search "${playboymodel}" "Nicole_Ross"
                  ;;
                Niemira)
                  get_search "${playboymodel}" "Nonna_Y."
                  get_search "${playboymodel}" "Niemira_Foxx"
                  ;;
                Roxanna_Dunlop)
                  get_search "${playboymodel}" "Roxanna_June"
                  ;;
                Sabrisse_Aaliyah)
                  get_search "${playboymodel}" "Sabrisse"
                  get_search "${playboymodel}" "Sabrisse_A"
                  ;;
                Sapphira_A)
                  get_search "${playboymodel}" "Sapphira"
                  ;;
                Serena_Wood)
                  get_search "${playboymodel}" "Doria_A."
                  get_search "${playboymodel}" "Serena_J."
                  ;;
                Shannon_Twins)
                  get_search "${playboymodel}" "Karissa_Shannon"
                  get_search "${playboymodel}" "Kristina_Shannon"
                  ;;
                Stefani_Kovalyova)
                  get_search "${playboymodel}" "Izabella"
                  get_search "${playboymodel}" "Ryana"
                  ;;
                Sybil_A)
                  get_search "${playboymodel}" "Kailena"
                  get_search "${playboymodel}" "Sybille_Y"
                  get_search "${playboymodel}" "Sybil"
                  get_search "${playboymodel}" "Davina_E"
                  ;;
                Tanja_Brockmann)
                  get_search "${playboymodel}" "Tanja_Brockamnn"
                  ;;
                Ulyana_Orsk)
                  get_search "${playboymodel}" "Adelina_Dey"
                  get_search "${playboymodel}" "Jordonna"
                  # get_search "${playboymodel}" "Nicolette"
                  ;;
                Uma_Jolie)
                  get_search "${playboymodel}" "Belicia_Segura"
                  get_search "${playboymodel}" "Madeline_Clark"
                  ;;
                Verona_J)
                  get_search "${playboymodel}" "Briana"
                  ;;
                Yana_West)
                  get_search "${playboymodel}" "Rosalyn"
                  get_search "${playboymodel}" "Innes_A"
                  get_search "${playboymodel}" "Yana_Wellis"
                  get_search "${playboymodel}" "Jane_G"
                  ;;
                Yulia_Zubova)
                  get_search "${playboymodel}" "Julia_Zubova"
                  get_search "${playboymodel}" "Julia_Zu"
                  ;;
              esac
            done
            ;;
        Penthouse)
            for penthousemodel in ${MODD}/Penthouse/*
            do
              [ -d "${penthousemodel}" ] || continue
              modelname=`basename ${penthousemodel}`
              get_search "${penthousemodel}" "${modelname}"
              case "$modelname" in
                Heather_Vandeven)
                  get_search "${penthousemodel}" "Heather_V"
                  ;;
              esac
            done
            ;;
        Polina_Pszenicznaia)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Polina_Pshenichnaya"
            ;;
        Portia_Victoria)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Valis_Volkova"
            ;;
        Penelope_G)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Rafaella"
            get_search "${MODD}/${model}" "Raffaella"
            get_search "${MODD}/${model}" "Gyana_A"
            ;;
        Sarika_A)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Darina_Nikitina"
            ;;
        Scarlet_\(Met_Art\))
            get_search "${MODD}/${model}" "${model}"
            ;;
        Selena_Werner)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Selena_Verner"
            ;;
        Simon_\(GoddessNudes\))
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Simon_\(GoddessNudes\]"
            ;;
        Sofi_Shane)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sofie_S"
            ;;
        Sophia_Blake)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Jadoresophia"
            ;;
        Sophia_Sinclair)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Brookliyn"
            ;;
        Sophie_Gem)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sophie_Sweet"
            ;;
        Sofie_Lilith)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sofie_Lilith_\(iStripper.com\)"
            get_search "${MODD}/${model}" "Sofie_\(MetArt.com\)"
            get_search "${MODD}/${model}" "Nadine_\(PhotoDromm.com\)"
            ;;
        Sonya_D)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sonya_D_\(Met-Art\)"
            ;;
        Stefania_Valentinovna_Iodkovskaya)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Stefania_Iodkovskaya"
            ;;
        Stefanija)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Flower_Femjoy"
            ;;
        Sveta_Akatyeva)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Svetlana_Akatieva"
            get_search "${MODD}/${model}" "Svetlana_Akatyeva"
            ;;
        Sveta_Grashchenkova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Sveta_Statham"
            ;;
        Tatyana_Bakhtina)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Tanya_Bahtina"
            ;;
        Tommie_Jo)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Tommi_Jo"
            ;;
        Valeria_Kika)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Kika"
            ;;
        Vanessa_Angel)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Vanessa_A"
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
        Viktoriia_Aliko)
            get_search "${MODD}/${model}" "Paula_U"
            get_search "${MODD}/${model}" "Aksana_K"
            get_search "${MODD}/${model}" "Hilary_C"
            get_search "${MODD}/${model}" "Hilary_C."
            get_search "${MODD}/${model}" "Hilary_C_\(Met_Art\)"
            get_search "${MODD}/${model}" "Hillary_Chacier"
            get_search "${MODD}/${model}" "Victoria_Aliko"
            get_search "${MODD}/${model}" "Viktoria_Aliko"
            ;;
        Viola_Bailey)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Viola_Paige"
            ;;
        Vos)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Vos_Met-art"
            ;;
        Wilma_Togoony)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Wilma"
            ;;
        Whitney_Sarka)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Tabitha"
            get_search "${MODD}/${model}" "Lynne_\(Hegre\)"
            ;;
        Yara_Eggiman)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Yara_\(Hegre-Art\)"
            ;;
        Yulia_Liepa)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Julia_Liepa"
            ;;
        Yulia_Silenkova)
            get_search "${MODD}/${model}" "${model}"
            get_search "${MODD}/${model}" "Julia_Silenkova"
            get_search "${MODD}/${model}" "Lilia_Kot"
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
        Tinami)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "MiiTao"
            ;;
        Utsunomiya_Shion)
            get_search "${JAVD}/${model}" "${model}"
            get_search "${JAVD}/${model}" "Shion_Utsunomiya"
            get_search "${JAVD}/${model}" "Rara_Anzai"
            get_search "${JAVD}/${model}" "Rion"
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
        Anette_Dawn)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Anette_Down"
            ;;
        Avrora)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Avrora_Suicide"
            ;;
        Brea_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Brea"
            ;;
        Coralinne_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Sara_Calixto"
            get_search "${SUGD}/${model}" "PetiteMarie"
            ;;
        Ela_Savanas)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Ela_Photodromm"
            ;;
        Elisa_Rose)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "ElisaRose"
            get_search "${SUGD}/${model}" "Elisa_Suicide"
            ;;
        Ellie_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Elise_Laurenne"
            ;;
        Enrapture)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Elise_Tails"
            get_search "${SUGD}/${model}" "Enrapturex"
            ;;
        Ivory_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Ivory"
            ;;
        Jessicalou_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "JessicaLou"
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
        Lucy_Collett)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "LucyV_Suicide"
            ;;
        Lure_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Lurelady"
            ;;
        Lyuba_Menyaeva)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Lyuba"
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
        Natasha_Legeyda)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Natashalegeyda_Suicide"
            ;;
        NattyBohh)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "NattyBohh_Suicide"
            ;;
        Nefka)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Micaela_Nefka"
            ;;
        Octavia_May)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Octavia_Suicide"
            get_search "${SUGD}/${model}" "Octaviamay_\(Suicide_Girls\)"
            get_search "${SUGD}/${model}" "Octaviamay"
            ;;
        Scribbles_Suicide)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Jo_Evans"
            ;;
        Sierhaus)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Sierhaus_Suicide"
            ;;
        *Suicide_Girls*)
            get_search "${SUGD}/${model}" "${model}"
            mname=`echo ${model} | sed -e "s/Suicide_Girls/\(Suicide_Girls\)/"`
            get_search "${SUGD}/${model}" "${mname}"
            ;;
        Sunnie_Jones)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Sunniejones"
            ;;
        Valeria_Yakisel)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Valerig_Suicide"
            ;;
        Valeriya)
            get_search "${SUGD}/${model}" "${model}"
            get_search "${SUGD}/${model}" "Valeriya_Suicide"
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
numdown=480
sums=1

# Argument -l indicates retrieve latest wallpapers.
# Argument -d indicates debug mode.
# Argument -m indicates only do Models subdir.
# Argument -n numdown specifies number of downloads per search
# Argument -j, only JAV_Idol.
# Argument -s, only Suicide_Girls.
# Following arguments can indicate specific model folders/names
# Default is all models in specified subdir(s)

usage() {
    echo "Usage: get-models [-l] [-d] [-m] [-j] [-n numdown] [-s] [-u] [model names]"
    echo "Argument -l indicates retrieve latest wallpapers"
    echo "Argument -d indicates debug mode"
    echo "Argument -m indicates only do Models subdir"
    echo "Argument -n numdown specifies number of downloads per search"
    echo "Argument -j, only JAV_Idol"
    echo "Argument -s, only Suicide_Girls"
    echo "Argument -S, do not update SUMS file"
    echo "Following arguments can indicate specific model folders/names"
    echo "Default is all models in specified subdir(s)"
    exit 1
}

while getopts jlmdn:sSu flag; do
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
            numdown=$OPTARG
            ;;
        d)
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
    for name in $MODELS
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
    [ "$sums" ] && {
      [ -x ${TOP}/updsumhaven ] && {
        # echo "Running ${TOP}/updsumhaven -m"
        [ "$debug" ] || ${TOP}/updsumhaven -m > /dev/null
      }
    }
  fi
}

cd "${WHVN}"

[ "$SUIC" ] && {
  # The Suicide_Girls subdirectory
  [ "$debug" ] || cd ${SUGD}
  if [ "$MODELS" ]
  then
    for name in $MODELS
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
    [ "$sums" ] && {
      [ -x ${TOP}/updsumhaven ] && {
        # echo "Running ${TOP}/updsumhaven -s"
        [ "$debug" ] || ${TOP}/updsumhaven -s > /dev/null
      }
    }
  fi
}

cd "${WHVN}"

[ "$JAVC" ] && {
  # The JAV_Idol subdirectory
  [ "$debug" ] || cd ${JAVD}
  if [ "$MODELS" ]
  then
    for name in $MODELS
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
    [ "$sums" ] && {
      [ -x ${TOP}/updsumhaven ] && {
        # echo "Running ${TOP}/updsumhaven -j"
        [ "$debug" ] || ${TOP}/updsumhaven -j > /dev/null
      }
    }
  fi
}
