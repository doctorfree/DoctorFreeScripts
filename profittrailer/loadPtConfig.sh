#!/bin/bash

DOM="https://ronrecord.ddns.net"
PORT=8443
LIC="c106dd53f98c396ce9d891cff5672924"
SAPI="settingsapi/settings"
INVALID="Invalid selection. Please enter one of the displayed numeric values."
filetypes="APPLICATION DCA PAIRS INDICATORS HOTCONFIG"
usejq=

loadconf() {
    if [ "$tellme" ]
    then
      echo "curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' ${DOM}:${PORT}/${SAPI}/load?fileName=$1&configName=$2&license=${LIC}"
    else
      usejq=`type -p jq`
      if [ "$usejq" ]
      then
        curl -X POST \
          --header 'Content-Type: application/json' \
          --header 'Accept: application/json' \
          "${DOM}:${PORT}/${SAPI}/load?fileName=$1&configName=$2&license=${LIC}" \
          2> /dev/null | jq '.'
      else
        curl -X POST \
          --header 'Content-Type: application/json' \
          --header 'Accept: application/json' \
          "${DOM}:${PORT}/${SAPI}/load?fileName=$1&configName=$2&license=${LIC}"
      fi
    fi
}

usage() {
    echo "Usage: loadPtConfig [-i] [-n] [-u] [-c ConfigName] [-f fileName]"
    exit 1
}
  
interactive=
tellme=
[ $# -eq 0 ] && interactive=1
while getopts ic:f:nu flag; do
    case $flag in
        c)
            CN=$OPTARG
            ;;
        f)
            FN=$OPTARG
            ;;
        i)
            interactive=1
            ;;
        n)
            tellme=1
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

if [ "$interactive" ]
then
    for i in `listPtConfigs`
    do
        configlist="$configlist $i"
    done

    PS3="Enter the number of your choice: "
    while true
    do
        select file in $filetypes "Quit"
        do
            case $file in
                "Quit")
                    echo "Quit selected. Exiting."
                    exit 0
                ;;
                *)
                    valid=
                    for i in $filetypes
                    do
                        [ "$i" == "$file" ] && {
                            valid=1
                            break
                        }
                    done
                    if [ "$valid" ]
                    then
                        echo "Using filetype: $file"
                        FN="$file"
                        break 2
                    else
                        echo "$INVALID"
                    fi
                ;;
            esac
        done
    done
    while true
    do
        select conf in $configlist "Quit"
        do
            case $conf in
                "Quit")
                    echo "Quit selected. Exiting."
                    exit 0
                ;;
                *)
                    valid=
                    for i in $configlist
                    do
                        [ "$i" == "$conf" ] && {
                            valid=1
                            break
                        }
                    done
                    if [ "$valid" ]
                    then
                        loadconf "${FN}" "$conf"
                        break 2
                    else
                        echo "$INVALID"
                    fi
                ;;
            esac
        done
    done
else
    [ "$CN" ] || {
        echo "One of -i or -c configName must be specified"
        usage
    }
    [ "$FN" ] || {
        echo "One of -i or -f fileName must be specified"
        usage
    }
    listPtConfigs | while read config
    do
        [ "$CN" == "$config" ] && {
            loadconf "${FN}" "${CN}"
            break
        }
    done
fi
[ "$?" -ne 0 ] && {
    echo "Could not find configuration name: ${CN}. Exiting."
    exit 2
}
