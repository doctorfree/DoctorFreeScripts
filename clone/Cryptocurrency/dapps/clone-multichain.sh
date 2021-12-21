#!/bin/bash

[ -d multichain ] && {
    rm -rf multichain
}

git clone https://github.com/MultiChain/multichain.git
