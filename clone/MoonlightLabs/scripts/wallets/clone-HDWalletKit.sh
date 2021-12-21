#!/bin/bash

coin="HDWalletKit"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/yuzushioh/HDWalletKit.git

[ -r ${patch} ] && tar xzvf ${patch}
