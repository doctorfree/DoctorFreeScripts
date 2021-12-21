#!/bin/bash

fold="desktop"
coin="musiccoin"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}
[ -d ${fold} ] && {
    rm -rf ${fold}
}

git clone https://github.com/Musicoin/desktop.git
mv ${fold} ${coin}

[ -r ${patch} ] && tar xzvf ${patch}
