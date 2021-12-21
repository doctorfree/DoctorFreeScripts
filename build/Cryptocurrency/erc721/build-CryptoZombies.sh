#!/bin/bash

[ -d CryptoZombies ] || {
    tar xzf CryptoZombies-1.0.0.tgz
}

cd CryptoZombies

npm install
truffle compile
