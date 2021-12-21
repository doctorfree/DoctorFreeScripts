#!/bin/bash

[ -d pydevp2p ] && {
    sudo rm -rf pydevp2p
}

git clone https://github.com/ethereum/pydevp2p.git
