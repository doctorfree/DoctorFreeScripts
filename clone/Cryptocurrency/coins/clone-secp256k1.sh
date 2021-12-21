#!/bin/bash

coin="secp256k1"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/bitcoin-core/secp256k1.git

[ -r ${patch} ] && tar xzvf ${patch}
