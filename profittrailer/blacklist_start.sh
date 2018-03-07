#!/bin/bash

PT_DIR="/usr/local/lib/ProfitTrailer"
BL_JAR="ProfitTrailer-blacklist.jar"
BL_LOG="${PT_DIR}/logs/ProfitTrailer-blacklist.log"

[ -d ${PT_DIR} ] || {
    echo "${PT_DIR} does not exist or is not a directory. Exiting."
    exit 1
}

cd ${PT_DIR}
[ -f ${BL_LOG} ] || touch ${BL_LOG}
[ -f ${BL_JAR} ] || {
    echo "${BL_JAR} does not exist or is not a regular file. Exiting."
    exit 1
}

pm2 start ${PT_DIR}/ProfitTrailer-blacklist.sh --name "blacklist"
