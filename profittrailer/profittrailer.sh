#!/bin/bash

INST_DIR=/usr/local/lib/ProfitTrailer

[ -d ${INST_DIR} ] || {
    echo "${INST_DIR} does not exist or is not a directory. Exiting."
    exit 1
}

cd ${INST_DIR}

java -Djava.net.preferIPv4Stack=true -Dsun.stdout.encoding=UTF-8 -jar ProfitTrailer.jar -XX:+UseConcMarkSweepGC -Xmx512m -Xms512m

read -p "Press <ENTER> or CTRL-C to abort ... "
