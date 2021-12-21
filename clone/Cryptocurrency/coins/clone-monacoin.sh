#!/bin/bash

coin="monacoin"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/${coin}project/${coin}.git

[ -r ${patch} ] && tar xzvf ${patch}
