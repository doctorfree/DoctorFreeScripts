#!/bin/bash

[ -d etherwallet ] && {
    rm -rf etherwallet
}

git clone https://github.com/kvhnuke/etherwallet.git
