#!/bin/bash

coin="litecoin"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/litecoin-project/litecoin.git

[ -r ${patch} ] && tar xzvf ${patch}
