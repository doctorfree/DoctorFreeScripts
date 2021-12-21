#!/bin/bash

[ -d go-ipfs ] && {
    rm -rf go-ipfs
}

git clone https://github.com/ipfs/go-ipfs.git
