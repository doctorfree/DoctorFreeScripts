#!/bin/bash

[ -d ethminer ] && {
    rm -rf ethminer
}

git clone https://github.com/ethereum-mining/ethminer.git
cd ethminer
git submodule update --init --recursive
