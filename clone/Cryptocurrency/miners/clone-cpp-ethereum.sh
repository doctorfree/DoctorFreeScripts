#!/bin/bash

[ -d cpp-ethereum ] && {
    rm -rf cpp-ethereum
}

git clone https://github.com/Genoil/cpp-ethereum/
