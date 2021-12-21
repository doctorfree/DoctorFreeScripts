#!/bin/bash

[ -d pyethereum ] && {
    rm -rf pyethereum
}

git clone https://github.com/ethereum/pyethereum.git
