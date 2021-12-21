#!/bin/bash

coin="etherwallet"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/kvhnuke/etherwallet.git

[ -r ${patch} ] && tar xzvf ${patch}
