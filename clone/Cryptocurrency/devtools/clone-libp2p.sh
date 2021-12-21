#!/bin/bash

[ -d go-libp2p ] && {
    sudo rm -rf go-libp2p
}

git clone https://github.com/libp2p/go-libp2p.git
