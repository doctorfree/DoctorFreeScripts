#!/bin/bash

TOP=$HOME/src/coins/mooncoin
BDB="/usr/local/BerkeleyDB.4.8"
BDBINC="${BDB}/include"
BDBLIB="${BDB}/lib"
OS=`uname`

[ -d ${TOP} ] || {
    echo "$TOP does not exist or is not a directory. Exiting."
    exit 1
}
cd ${TOP}
./autogen.sh
if [ -d ${BDB} ]
then
    BDB_CFLAGS="-I${BDBINC}" BDB_LIBS="-L${BDBLIB} -ldb -ldb_cxx" ./configure
else
    ./configure --disable-wallet
fi
BDB_CFLAGS="-I${BDBINC}" BDB_LIBS="-L${BDBLIB} -ldb -ldb_cxx" make
BDB_CFLAGS="-I${BDBINC}" BDB_LIBS="-L${BDBLIB} -ldb -ldb_cxx" make check
if [ "$OS" == "Darwin" ]
then
    sudo make deploy
else
    sudo make install
fi
