#!/bin/bash

coin="namecoin-core"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/namecoin/namecoin-core.git

[ -r ${patch} ] && tar xzvf ${patch}
