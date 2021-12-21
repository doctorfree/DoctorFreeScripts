#!/bin/bash

coin="EthereumKit"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/D-Technologies/EthereumKit.git

[ -r ${patch} ] && tar xzvf ${patch}
