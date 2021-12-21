#!/bin/bash

coin="monocle"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/vertcoin/${coin}.git

[ -r ${patch} ] && tar xzvf ${patch}
