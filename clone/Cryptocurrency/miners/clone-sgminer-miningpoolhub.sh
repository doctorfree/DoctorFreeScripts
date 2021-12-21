#!/bin/bash

miner="sgminer"
vendor="miningpoolhub"
folder="${miner}-${vendor}"
patch="Patches/${folder}-patch.tgz"

[ -d ${folder} ] && {
    rm -rf ${folder}
}

git clone https://github.com/miningpoolhub/sgminer.git --recursive
[ -r ${patch} ] && tar xzvf ${patch}
mv ${miner} ${folder}
