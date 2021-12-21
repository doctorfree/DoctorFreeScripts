#!/bin/bash

miner="sgminer"
vendor="dev"
folder="${miner}-${vendor}"
patch="Patches/${folder}-patch.tgz"

[ -d ${folder} ] && {
    rm -rf ${folder}
}

git clone https://github.com/sgminer-dev/sgminer.git --recursive
[ -r ${patch} ] && tar xzvf ${patch}
mv ${miner} ${folder}
