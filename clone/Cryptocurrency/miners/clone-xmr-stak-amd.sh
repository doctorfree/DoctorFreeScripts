#!/bin/bash

miner="xmr-stak-amd"
patch="Patches/${miner}-patch.tgz"


[ -d ${miner} ] && {
    rm -rf ${miner}
}

git clone https://github.com/fireice-uk/${miner}.git
[ -r ${patch} ] && tar xzvf ${patch}
