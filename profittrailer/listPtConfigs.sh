#!/bin/bash

DOMAIN="https://ronrecord.ddns.net"
PORT=8443
LICENSE="c106dd53f98c396ce9d891cff5672924"

curl -X POST --header 'Content-Type: application/json' \
             --header 'Accept: text/plain' \
             ${DOMAIN}:${PORT}/settingsapi/config/list?license=${LICENSE} \
             2> /dev/null \
             | sed -e "s/\[//" -e "s/\"//g" -e "s/\]//" \
             | awk -F "," ' { for(i=1;i<=NF;i++) print $i } '
