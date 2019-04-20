#!/bin/bash

DOMAIN="https://ronrecord.ddns.net"
PORT=8443
PT_DIR="/usr/local/lib/ProfitTrailer"
TOKEN=`grep server.api_token ${PT_DIR}/application.properties | \
       awk -F "=" ' { print $2 } ' | sed -e "s/ //g" | tr -dc '[:print:]'`

usejq=`type -p jq`
if [ "$usejq" ]
then
    curl -X GET --header 'Accept: application/json' \
             "${DOMAIN}:${PORT}/api/buys/log?token=${TOKEN}" \
             2> /dev/null | jq '.' 
else
    curl -X GET --header 'Accept: application/json' \
             "${DOMAIN}:${PORT}/api/buys/log?token=${TOKEN}"
fi
