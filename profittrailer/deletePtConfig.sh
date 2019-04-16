#!/bin/bash

DOM="https://ronrecord.ddns.net"
PORT=8443
LIC="c106dd53f98c396ce9d891cff5672924"
SAPI="settingsapi/config"
INVALID="Invalid selection. Please enter one of the displayed numeric values."

deleteconf() {
    if [ "$tellme" ]
    then
        echo "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*' ${DOM}:${PORT}/${SAPI}/delete?configName=$1&license=${LIC}"
    else
        curl -X POST \
            --header 'Content-Type: application/json' \
            --header 'Accept: */*' \
            "${DOM}:${PORT}/${SAPI}/delete?configName=$1&license=${LIC}"
    fi
}

usage() {
    echo "Usage: deletePtConfig [-i] [-n] [-u] [-c ConfigName]"
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
                        echo "Deleting configuration: $conf"
                        deleteconf "$conf"
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
            deleteconf "${CN}"
            break
        }
    done
fi
[ "$?" -ne 0 ] && {
    echo "Could not find configuration name: ${CN}. Exiting."
    exit 2
}
