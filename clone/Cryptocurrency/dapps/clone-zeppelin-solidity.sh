#!/bin/bash

[ -d zeppelin-solidity ] && {
    rm -rf zeppelin-solidity
}

git clone https://github.com/OpenZeppelin/zeppelin-solidity.git
