#!/bin/bash

DOMAIN="https://ronrecord.ddns.net"
PORT=8443
TOKEN="rrsleig205ujc04tj0x9cugr04slt"

usejq=`type -p jq`
if [ "$usejq" ]
then
    curl -X GET --header 'Accept: application/json' \
             "${DOMAIN}:${PORT}/api/sales/log?token=${TOKEN}" \
             2> /dev/null | jq '.' 
else
    curl -X GET --header 'Accept: application/json' \
             "${DOMAIN}:${PORT}/api/sales/log?token=${TOKEN}"
fi
