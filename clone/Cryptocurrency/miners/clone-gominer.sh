#!/bin/bash

miner="gominer"
patch="Patches/${miner}-patch.tgz"

[ -d ${miner} ] && {
    rm -rf ${miner}
}

git clone https://github.com/decred/${miner}.git
[ -r ${patch} ] && tar xzvf ${patch}
