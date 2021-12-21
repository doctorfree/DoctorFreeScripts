#!/bin/bash

[ -d pyethapp ] && {
    sudo rm -rf pyethapp
}

git clone https://github.com/ethereum/pyethapp
