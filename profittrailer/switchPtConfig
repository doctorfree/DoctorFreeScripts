#!/bin/bash

DOM="https://ronrecord.ddns.net"
PORT=8443
SAPI="settingsapi/config"
INVALID="Invalid selection. Please enter one of the displayed numeric values."
PT_DIR="/usr/local/lib/ProfitTrailer"
LIC=`grep license ${PT_DIR}/application.properties | \
       awk -F "=" ' { print $2 } ' | sed -e "s/ //g" | tr -dc '[:print:]'`

switchconf() {
    if [ "$tellme" ]
    then
        echo "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*' ${DOM}:${PORT}/${SAPI}/switch?configName=$1&license=${LIC}"
    else
        curl -X POST \
            --header 'Content-Type: application/json' \
            --header 'Accept: */*' \
            "${DOM}:${PORT}/${SAPI}/switch?configName=$1&license=${LIC}"
    fi
}

usage() {
    echo "Usage: switchPtConfig [-i] [-n] [-u] [-c ConfigName]"
    exit 1
}
  
interactive=
tellme=
while getopts ic:nu flag; do
    case $flag in
        c)
            CN=$OPTARG
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
                        echo "Switching to configuration: $conf"
                        switchconf "$conf"
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
    listPtConfigs | while read config
    do
        [ "$CN" == "$config" ] && {
            echo "Found matching config name: $config"
            switchconf "${CN}"
            break
        }
    done
fi
[ "$?" -ne 0 ] && {
    echo "Could not find configuration name: ${CN}. Exiting."
    exit 2
}
