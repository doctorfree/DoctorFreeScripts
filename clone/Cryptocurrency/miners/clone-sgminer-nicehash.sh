#!/bin/bash

miner="sgminer"
vendor="nicehash"
folder="${miner}-${vendor}"
patch="Patches/${folder}-patch.tgz"

[ -d ${folder} ] && {
    rm -rf ${folder}
}

git clone https://github.com/nicehash/${miner}.git --recursive
[ -r ${patch} ] && tar xzvf ${patch}
mv ${miner} ${folder}
