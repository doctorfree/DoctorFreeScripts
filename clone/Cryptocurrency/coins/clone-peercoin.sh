#!/bin/bash

coin="peercoin"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/peercoin/peercoin.git

[ -r ${patch} ] && tar xzvf ${patch}
