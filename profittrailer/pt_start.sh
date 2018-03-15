#!/bin/bash

PT_DIR=/usr/local/lib/ProfitTrailer
LOG=ProfitTrailer.log

[ -d ${PT_DIR} ] || {
    echo "${PT_DIR} does not exist or is not a directory. Exiting."
    exit 1
}

cd ${PT_DIR}
pm2 start ${PT_DIR}/pm2-ProfitTrailer.json
sleep 10
inst=`type -p grcat`
if [ "$inst" ]
then
    tail -f ${PT_DIR}/logs/${LOG} | grcat conf.profittrailer
else
    tail -f ${PT_DIR}/logs/${LOG}
fi
