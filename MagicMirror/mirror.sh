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
IP="10.0.1.67"
PORT="8080"

[ -d "${CONFDIR}" ] || {
    echo "$CONFDIR does not exist or is not a directory. Exiting."
    exit 1
}
cd "${CONFDIR}"

usage() {
    echo "Usage: mirror <command> [args]"
    echo "Where <command> can be one of the following:"
    echo "    list <active|installed|configs>, restart, start, stop, status, getb, setb <num>"
    echo "or specify a config file to use with one of:"
    echo "    normal, blank, fractals, waterfalls, photographers, models, tuigirls"
    echo "or any other config file you have created in ${CONFDIR} of the form:"
    echo "    config-<name>.js"
    echo "Example valid commands include 'mirror blank' or 'mirror normal'"
    echo "The argument will be resolved into a config filename of the form:"
    echo "    config-\$argument.js"
    echo "Exiting."
    exit 1
}

list_usage() {
    echo "Usage: mirror list <active|installed|configs>"
    echo "Where 'active', 'installed', or 'configs' must be specified."
    echo "This command will list either all active or installed modules or all configs."
    exit 1
}

setb_usage() {
    echo "Usage: mirror setb [number]"
    echo "Where 'number' is an integer value in the range 0-200"
    exit 1
}

[ "$1" ] || {
    echo "Command argument required to specify Mirror mode."
    usage
}

[ "$1" == "restart" ] && {
    echo "Restarting MagicMirror"
    pm2 restart mm
    echo "Done"
    exit 0
}

[ "$1" == "start" ] && {
    echo "Starting MagicMirror"
    pm2 start mm
    echo "Done"
    exit 0
}

[ "$1" == "stop" ] && {
    echo "Stopping MagicMirror"
    pm2 stop mm
    echo "Done"
    exit 0
}

[ "$1" == "status" ] && {
    echo "MagicMirror Status:"
    pm2 status mm
    CONF=`readlink -f ${CONFDIR}/config.js`
    echo "Using config file `basename ${CONF}`"
    echo "Done"
    exit 0
}

[ "$1" == "getb" ] && {
    echo "Getting MagicMirror Brightness Level"
    curl -X GET http://${IP}:${PORT}/api/brightness 2> /dev/null | jq .
    exit 0
}

[ "$1" == "list" ] && {
    [ "$2" ] || {
        echo "Argument of 'active', 'installed', or 'configs' required to list modules."
        list_usage
    }
    if [ "$2" == "active" ]
    then
        echo "Listing Active MagicMirror modules"
        curl -X GET http://${IP}:${PORT}/api/modules 2> /dev/null | jq .
    else
        if [ "$2" == "installed" ]
        then
            echo "Listing Installed MagicMirror modules"
            curl -X GET http://${IP}:${PORT}/api/modules/installed 2> /dev/null | jq .
        else
            if [ "$2" == "configs" ]
            then
                echo "Listing MagicMirror configuration files:"
                echo ""
                ls -1 *.js
            else
                echo "mirror list $2 is not an accepted 2nd argument."
                echo "Valid 2nd arguments to the list command are 'active', 'installed', and 'configs'"
                list_usage
            fi
        fi
    fi
    exit 0
}

[ "$1" == "setb" ] && {
    [ "$2" ] || {
        echo "Numeric argument required to specify Mirror brightness."
        setb_usage
    }
    if [ "$2" -ge 0 ] && [ "$2" -le 200 ]
    then
        echo "Setting MagicMirror Brightness Level to $2"
        curl -X GET http://${IP}:${PORT}/api/brightness/$2 2> /dev/null | jq .
    else
        echo "Brightness setting $2 out of range or not a number"
        echo "Valid brightness values are integer values [0-200]"
        setb_usage
    fi
    exit 0
}

if [ "$1" == "normal" ]
then
    mode="vertical"
else
    mode="$1"
fi
[ "$1" == "waterfall" ] && mode="waterfalls"
[ "$1" == "fractal" ] && mode="fractals"

if [ -f config-${mode}.js ]
then
    mv config.js config-$$.js
    ln -s config-${mode}.js config.js
    npm run --silent config:check > /dev/null
    [ $? -eq 0 ] || {
        echo "MagicMirror configuration config-${mode}.js needs work."
        echo "Try again after you have addressed these issues:"
        npm run --silent config:check
        rm -f config.js
        mv config-$$.js config.js
        exit 1
    }
    [ -L config-$$.js ] && rm -f config-$$.js
    pm2 restart mm
    sleep 10
    if [ "${mode}" == "blank" ]
    then
        curl -X GET http://${IP}:${PORT}/api/brightness/0 2> /dev/null | jq .
    else
        curl -X GET http://${IP}:${PORT}/api/brightness/180 2> /dev/null | jq .
    fi
else
    echo "No configuration file config-${mode}.js found."
    usage
fi
