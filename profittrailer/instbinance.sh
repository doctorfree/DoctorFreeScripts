#!/bin/bash

NAM=ProfitTrailer
INST_DIR=/usr/local/lib/${NAM}
VER=1.2.6.18
TOP="${HOME}/src/trading/profit-trailer"
BAK=${TOP}/Bak
JAR=${TOP}/${NAM}-${VER}/${NAM}.jar

[ -f ${JAR} ] || {
    echo "$JAR does not exist. Exiting."
    exit 1
}

[ -d ${TOP}/binance/installed ] || {
    echo "$TOP/binance/installed does not exist. Exiting."
    exit 1
}

[ -d ${INST_DIR}/trading ] || mkdir -p ${INST_DIR}/trading
cd ${TOP}/binance/installed
sudo cp *.properties *.json ${INST_DIR} 
sudo cp trading/* ${INST_DIR}/trading
sudo cp ${JAR} ${INST_DIR}
sudo cp ${TOP}/profittrailer.sh /usr/local/bin/profittrailer
sudo chmod 755 /usr/local/bin/profittrailer
