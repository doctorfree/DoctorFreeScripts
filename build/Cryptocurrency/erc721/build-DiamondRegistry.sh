#!/bin/bash

[ -d DiamondRegistry ] || {
    ./clone-DiamondRegistry.sh
}

cd DiamondRegistry

npm install
mkdir github.com
mkdir github.com/Arachnid
git clone https://github.com/Arachnid/solidity-stringutils.git
mv solidity-stringutils github.com/Arachnid/solidity-stringutils

truffle compile
