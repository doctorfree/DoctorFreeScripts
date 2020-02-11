#!/bin/bash
#
## @file mirror.sh
## @brief Convenience script to manage multiple MagicMirror configurations
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2020, Ronald Joe Record, all rights reserved.
## @date Written 1-feb-2020
## @version 1.0.0
##
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

MM="${HOME}/MagicMirror"
CONFDIR="${MM}/config"
# Set the IP and PORT to the values on your system
IP="10.0.1.67"
PORT="8080"
CONFS=

[ -d "${CONFDIR}" ] || {
    printf "\nCONFDIR does not exist or is not a directory. Exiting.\n"
    exit 1
}
cd "${CONFDIR}"

getconfs() {
    numconfs=0
    for i in config-*.js
    do
        j=`echo $i | awk -F "-" ' { print $2 } ' | sed -e "s/.js//"`
        CONFS="${CONFS} $j"
        [ "$1" == "usage" ] && {
            numconfs=`expr $numconfs + 1`
            [ $numconfs -gt 8 ] && {
                CONFS="${CONFS}\n\t"
                numconfs=0
            }
        }
    done
}

usage() {
    getconfs usage
    printf "\nUsage: mirror <command> [args]"
    printf "\nWhere <command> can be one of the following:"
    printf "\n\tlist <active|installed|configs>, select, restart, start, stop, status, getb, setb <num>"
    printf "\nor specify a config file to use with one of:"
    printf "\n\t${CONFS}"
    printf "\nor any other config file you have created in ${CONFDIR} of the form:"
    printf "\n\tconfig-<name>.js"
    printf "\nA config filename argument will be resolved into a config filename of the form:"
    printf "\n\tconfig-\$argument.js"
    printf "\n\nExamples:"
    printf "\n\tmirror list active\t\t# lists active modules"
    printf "\n\tmirror list configs\t\t# lists available configuration files"
    printf "\n\tmirror restart\t\t# Restart MagicMirror"
    printf "\n\tmirror fractals\t\t# Installs configuration file config-fractals.js"
    printf " and restarts MagicMirror"
    printf "\n\tmirror status\t\t# Displays MagicMirror status"
    printf "\n\tmirror getb\t\t# Displays current MagicMirror brightness level"
    printf "\n\tmirror setb 150\t\t# Sets MagicMirror brightness level to 150"
    printf "\n\tmirror -u\t\t# Display this usage message\n"
    exit 1
}

list_usage() {
    printf "\nList Usage: mirror list <active|installed|configs>"
    printf "\nWhere 'active', 'installed', or 'configs' must be specified."
    printf "\nThis command will list either all active or installed modules or all configs.\n"
    usage
}

setb_usage() {
    printf "\nSetb Usage: mirror setb [number]"
    printf "\nWhere 'number' is an integer value in the range 0-200\n"
    usage
}

setconf() {
    conf=$1
    mv config.js config-$$.js
    ln -s config-${conf}.js config.js
    npm run --silent config:check > /dev/null
    [ $? -eq 0 ] || {
        printf "\nMagicMirror configuration config-${conf}.js needs work."
        printf "\nTry again after you have addressed these issues:\n"
        npm run --silent config:check
        rm -f config.js
        mv config-$$.js config.js
        exit 1
    }
    [ -L config-$$.js ] && rm -f config-$$.js
    pm2 restart mm --update-env
    sleep 10
    if [ "${conf}" == "blank" ]
    then
        curl -X GET http://${IP}:${PORT}/api/brightness/0 2> /dev/null | jq .
    else
        curl -X GET http://${IP}:${PORT}/api/brightness/180 2> /dev/null | jq .
    fi
}

# If invoked with no arguments present a menu of options to select from
[ "$1" ] || {
    PS3='Please enter your MagicMirror command choice (numeric): '
    options=("list active modules" "list installed modules" "list configurations" "select configuration" "restart" "start" "stop" "status" "get brightness" "set brightness" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "list active modules")
                mirror list active
                break
                ;;
            "list installed modules")
                mirror list installed
                break
                ;;
            "list configurations")
                mirror list configs
                break
                ;;
            "select configuration")
                printf "======================================================\n\n"
                mirror select
                break
                ;;
            "get brightness")
                mirror getb
                break
                ;;
            "set brightness")
                while true
                do
                  read -p "Enter a brightness level between 0 and 200 or 'exit' to quit" answer
                  [ "$answer" == "exit" ] && break
                  if [ $answer -ge 0 ] && [ $answer -le 200 ]
                  then
                      printf "\nSetting MagicMirror Brightness Level to $answer\n"
                      curl -X GET http://${IP}:${PORT}/api/brightness/$answer 2> /dev/null | jq .
                      break
                  else
                      printf "\nBrightness setting $answer out of range or not a number"
                      printf "\nValid brightness values are integer values [0-200]\n"
                  fi
                done
                break
                ;;
            "quit")
                printf "\nExiting"
                break
                ;;
            *)
                mirror $opt
                break
                ;;
        esac
    done
    exit 0
}

# TODO: convert use of "$1" to getopts argument processing
while getopts u flag; do
    case $flag in
        u)
            usage
            ;;
    esac
done

[ "$1" == "select" ] && {
    getconfs select
    PS3='Please enter your MagicMirror configuration choice (numeric): '
    options=(${CONFS} quit)
    select opt in "${options[@]}"
    do
        case $opt in
            quit)
                printf "\nExiting"
                break
                ;;
            *)
                printf "\nInstalling config-${opt}.js MagicMirror configuration file\n"
                setconf ${opt}
                break
                ;;
        esac
    done
    exit 0
}

[ "$1" == "restart" ] && {
    printf "\nRestarting MagicMirror\n"
    pm2 restart mm --update-env
    printf "\nDone\n"
    exit 0
}

[ "$1" == "start" ] && {
    printf "\nStarting MagicMirror\n"
    pm2 start mm --update-env
    printf "\nDone\n"
    exit 0
}

[ "$1" == "stop" ] && {
    printf "\nStopping MagicMirror\n"
    pm2 stop mm --update-env
    printf "\nDone\n"
    exit 0
}

[ "$1" == "status" ] && {
    printf "\nMagicMirror Status:\n"
    pm2 status mm --update-env
    CONF=`readlink -f ${CONFDIR}/config.js`
    printf "\nUsing config file `basename ${CONF}`"
    printf "\nDone\n"
    exit 0
}

[ "$1" == "getb" ] && {
    printf "\nGetting MagicMirror Brightness Level\n"
    curl -X GET http://${IP}:${PORT}/api/brightness 2> /dev/null | jq .
    exit 0
}

[ "$1" == "list" ] && {
    [ "$2" ] || {
        printf "\nArgument of 'active', 'installed', or 'configs' required to list modules."
        list_usage
    }
    if [ "$2" == "active" ]
    then
        printf "\nListing Active MagicMirror modules\n"
        curl -X GET http://${IP}:${PORT}/api/modules 2> /dev/null | jq .
    else
        if [ "$2" == "installed" ]
        then
            printf "\nListing Installed MagicMirror modules\n"
            curl -X GET http://${IP}:${PORT}/api/modules/installed 2> /dev/null | jq .
        else
            if [ "$2" == "configs" ]
            then
                printf "\nListing MagicMirror configuration files:\n\n"
                ls -1 *.js
            else
                printf "\nmirror list $2 is not an accepted 2nd argument."
                printf "\nValid 2nd arguments to the list command are 'active', 'installed', and 'configs'"
                list_usage
            fi
        fi
    fi
    exit 0
}

[ "$1" == "setb" ] && {
    [ "$2" ] || {
        printf "\nNumeric argument required to specify Mirror brightness.\n"
        setb_usage
    }
    if [ "$2" -ge 0 ] && [ "$2" -le 200 ]
    then
        printf "\nSetting MagicMirror Brightness Level to $2\n"
        curl -X GET http://${IP}:${PORT}/api/brightness/$2 2> /dev/null | jq .
    else
        printf "\nBrightness setting $2 out of range or not a number"
        printf "\nValid brightness values are integer values [0-200]\n"
        setb_usage
    fi
    exit 0
}

if [ "$1" == "normal" ]
then
    mode="default"
else
    mode="$1"
fi
[ "$1" == "waterfall" ] && mode="waterfalls"
[ "$1" == "fractal" ] && mode="fractals"

if [ -f config-${mode}.js ]
then
    setconf ${mode}
else
    printf "\nNo configuration file config-${mode}.js found.\n\n"
    usage
fi
exit 0
