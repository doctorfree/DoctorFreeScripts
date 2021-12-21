#!/bin/bash

project="lotus"

[ -d ${project} ] || {
    ./clone-lotus.sh
    ./checkout-lotus.sh
}

cd ${project}

export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

#make clean && make all
make all
[ "$1" == "-i" ] && sudo make install
