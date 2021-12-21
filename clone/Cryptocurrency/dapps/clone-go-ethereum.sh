#!/bin/bash

[ -d go-ethereum ] && {
    rm -rf go-ethereum
}

git clone https://github.com/ethereum/go-ethereum.git
