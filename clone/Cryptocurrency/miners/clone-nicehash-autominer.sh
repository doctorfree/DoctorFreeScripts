#!/bin/bash

miner="ethos-nicehash-autominer"
patch="Patches/${miner}-patch.tgz"

[ -d ${miner} ] && {
    rm -rf ${miner}
}

git clone https://github.com/foraern/ethos-nicehash-autominer.git
[ -r ${patch} ] && tar xzvf ${patch}
