#!/bin/bash

[ -d p2pool-vtc ] && {
    rm -rf p2pool-vtc
}

git clone https://github.com/vertcoin/p2pool-vtc.git
