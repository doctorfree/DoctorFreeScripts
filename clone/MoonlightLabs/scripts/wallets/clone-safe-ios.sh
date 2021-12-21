#!/bin/bash

coin="safe-ios"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/gnosis/safe-ios.git

[ -r ${patch} ] && tar xzvf ${patch}
