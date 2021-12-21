#!/bin/bash

[ -d pyethereum ] && {
    sudo rm -rf pyethereum
}

git clone https://github.com/ethereum/pyethereum.git
