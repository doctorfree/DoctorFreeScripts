#!/bin/bash

coin="LykkeWalletAPI"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/LykkeCity/LykkeWalletAPI.git

[ -r ${patch} ] && tar xzvf ${patch}
