#!/bin/bash

[ -d solidity ] && {
    rm -rf solidity
}

git clone https://github.com/ethereum/solidity.git
