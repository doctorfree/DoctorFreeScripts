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

[ -d "${CONFDIR}" ] || {
    echo "$CONFDIR does not exist or is not a directory. Exiting."
    exit 1
}
cd "${CONFDIR}"

[ "$1" ] || {
    echo "Command argument required to specify Mirror mode."
    echo "Example valid commands include 'mirror slides' or 'mirror normal'"
    echo "The argument will be resolved into a config filename of the form:"
    echo "    config-$argument.js"
    echo "Exiting."
    exit 1
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
    rm -f config.js
    ln -s config-${mode}.js config.js
    pm2 restart mm
    sleep 10
    if [ "${mode} == "blank" ]
    then
        curl -X GET http://10.0.1.67:8080/api/brightness/0 | jq .
    else
        curl -X GET http://10.0.1.67:8080/api/brightness/180 | jq .
    fi
else
    echo "No configuration file config-${mode}.js found. Exiting."
    exit 1
fi
