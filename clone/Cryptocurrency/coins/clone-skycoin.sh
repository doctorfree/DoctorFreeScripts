#!/bin/bash

coin="skycoin"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/skycoin/skycoin.git

[ -r ${patch} ] && tar xzvf ${patch}
