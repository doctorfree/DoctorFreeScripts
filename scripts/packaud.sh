#!/bin/bash
#
## @file packaud.sh
## @brief Archive and compress my Audacity project files
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 30-Jan-2015
## @version 1.0.1
##
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.
#

[ "${AUDROOT}" ] || AUDROOT=/Audio

# Set this to your Audacity project directory or specify with the -a option
AUD_DIR="${AUDROOT}/Audacity"
REPORT=
DONE=1
TELL=
USAGE=
VERBOSE=

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "\nUsage: packaud [-a audacity dir] [-d] [-r] [-v] [-u]\n"
    printf "\nWhere:\n\taudacity dir is your Audacity project directory\n"
    printf "\t-d indicates a dry run (tell me what you would do)\n"
    printf "\t-r report which artist/titles are not compressed archives\n"
    printf "\t-v verbose mode\n"
    printf "\t-u displays this usage message\n"
    printf "\nAudacity directory = ${AUD_DIR}\n\n"
    exit 1
}

## @fn Archive()
## @brief Create a compressed tar archive of the specified directory
## @param param1 Directory to archive
Archive() {
    Arch_Dir="$1"
    if [ -d "$Arch_Dir" ]
    then
        Nospace=`echo $Arch_Dir | sed -e "s/ /_/g"`
        if [ "$TELL" ]
        then
            echo "tar cf - $Arch_Dir | gzip -9 > ${Nospace}-Audacity.tar.gz" 
            echo "rm -rf $Arch_Dir"
        else
            printf "\tCreating compressed tar archive of $Arch_Dir ... "
            tar cf - "$Arch_Dir" | gzip -9 > "${Nospace}-Audacity.tar.gz"
            rm -rf "$Arch_Dir"
            printf "done.\n"
        fi
    else
        echo "No directory $Arch_Dir - no archive created."
    fi
}

while getopts a:druv flag; do
    case $flag in
        a)
            AUD_DIR="$OPTARG"
            ;;
        d)
            TELL=1
            ;;
        r)
            REPORT=1
            TELL=1
            ;;
        v)
            VERBOSE=1
            ;;
        u)
            USAGE=1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$USAGE" ] && usage

[ -d "$AUD_DIR" ] || {
    echo "$AUD_DIR does not exist or is not a directory. Exiting."
    usage
}

cd "$AUD_DIR"
for Artist in *
do
    [ -d "$Artist" ] || {
        [ "$VERBOSE" ] && {
            echo "$Artist does not exist or is not a directory. Skipping."
        }
        continue
    }

    [ "$REPORT" ] || {
        [ "$VERBOSE" ] && {
            printf "\nArchiving and compressing titles by ${Artist}\n"
        }
    }
    cd "$Artist"

    for Album in *
    do
        [ -r "$Album" ] || continue
        Last="${Album: -15}"
        [ "$Last" = "Audacity.tar.gz" ] && continue
        Last="${Album: -4}"
        [ "$Last" = ".aup" ] && {
            Aname="${Album:0:${#Album}-4}"
            [ -d "${Aname}_data" ] || {
              [ -f "${Aname}.aup" ] && {
                printf "\nFound aup file ${Artist}/${Album} but no data dir."
                printf " Skipping.\n"
                continue
              }
            }
            if [ -d "$Aname" ]
            then
                if [ "$REPORT" ]
                then
                    echo "Found directory ${Artist}/${Aname}"
                    DONE=
                else
                    echo "$Aname already exists. Skipping."
                fi
                continue
            else
                [ "$TELL" ] || mkdir "$Aname"
            fi
            if [ "$TELL" ]
            then
                if [ "$REPORT" ]
                then
                    echo "Need to archive and compress ${Artist}/${Aname}"
                    DONE=
                else
                    echo "mv $Album $Aname"
                    echo "mv ${Aname}_data $Aname"
                fi
            else
                mv "$Album" "$Aname"
                mv "${Aname}_data" "$Aname"
            fi
            [ "$REPORT" ] || Archive "$Aname"
            continue
        }
        Last="${Album: -5}"
        [ "$Last" = "_data" ] && {
            Aname="${Album:0:${#Album}-5}"
            [ -f "${Aname}.aup" ] || {
              [ -d "${Aname}_data" ] && {
                printf "\nFound data ${Artist}/${Album} but no project file."
                printf " Skipping.\n"
                continue
              }
            }
            if [ -d "$Aname" ]
            then
                if [ "$REPORT" ]
                then
                    echo "Found directory ${Artist}/${Aname}"
                    DONE=
                else
                    echo "$Aname already exists. Skipping."
                fi
                continue
            else
                [ "$TELL" ] || mkdir "$Aname"
            fi
            if [ "$TELL" ]
            then
                if [ "$REPORT" ]
                then
                    echo "Need to archive and compress ${Artist}/${Aname}"
                    DONE=
                else
                    echo "mv $Album $Aname"
                    echo "mv ${Aname}.aup $Aname"
                fi
            else
                mv "$Album" "$Aname"
                mv "${Aname}.aup" "$Aname"
            fi
            [ "$REPORT" ] || Archive "$Aname"
            continue
        }
        if [ -d "$Album" ]
        then
            if [ "$REPORT" ]
            then
                echo "Need to archive and compress ${Artist}/${Album}"
                DONE=
            else
                Archive "$Album"
            fi
        else
            [ "$VERBOSE" ] && {
                echo "$Album does not exist or is not a directory. Skipping."
            }
        fi
    done
    cd ..
    [ "$REPORT" ] || {
        [ "$VERBOSE" ] && {
            printf "Done archiving and compressing titles by $Artist\n"
        }
    }
done

[ "$DONE" ] && {
    [ "$REPORT" ] && echo "All artists/titles archived and compressed"
}

exit 0
