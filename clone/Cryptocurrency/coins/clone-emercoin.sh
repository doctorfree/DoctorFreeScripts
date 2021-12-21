#!/bin/bash

coin="emercoin"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/emercoin/emercoin.git

[ -r ${patch} ] && tar xzvf ${patch}
