#!/bin/bash

[ -d eth-erc721-token ] && {
    rm -rf eth-erc721-token
}

git clone https://github.com/sunsingerus/eth-erc721-token.git
