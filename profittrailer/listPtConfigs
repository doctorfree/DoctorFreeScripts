#!/bin/bash

DOMAIN="https://ronrecord.ddns.net"
PORT=8443
PT_DIR="/usr/local/lib/ProfitTrailer"
LIC=`grep license ${PT_DIR}/application.properties | \
       awk -F "=" ' { print $2 } ' | sed -e "s/ //g" | tr -dc '[:print:]'`

curl -X POST --header 'Content-Type: application/json' \
             --header 'Accept: text/plain' \
             ${DOMAIN}:${PORT}/settingsapi/config/list?license=${LICENSE} \
             2> /dev/null \
             | sed -e "s/\[//" -e "s/\"//g" -e "s/\]//" \
             | awk -F "," ' { for(i=1;i<=NF;i++) print $i } '
