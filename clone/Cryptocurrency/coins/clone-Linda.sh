#!/bin/bash

coin="Linda"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/Lindacoin/Linda.git

[ -r ${patch} ] && tar xzvf ${patch}
