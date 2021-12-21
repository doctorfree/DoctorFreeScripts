#!/bin/bash

[ -d CryptoMons ] || {
    ./clone-CryptoMons.sh
}

cd CryptoMons

npm install
npx webpack --config webpack.config.js
