#!/bin/bash

[ -d CryptoCards ] || {
    tar xzf CryptoCards.tgz
}

cd CryptoCards

for year in 52 56 60 69
do
    cd 19$year
    npm install
    npx webpack --config webpack.config.js
    cd ..
done
