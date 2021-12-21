#!/bin/bash

coin="LykkeWallet"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/nikagamkrelidze/LykkeWallet.git

[ -r ${patch} ] && tar xzvf ${patch}
