#!/bin/bash

[ -d solidity-stringutils ] && {
    rm -rf solidity-stringutils
}

git clone https://github.com/Arachnid/solidity-stringutils.git
