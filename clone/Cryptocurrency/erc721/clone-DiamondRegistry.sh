#!/bin/bash

[ -d DiamondRegistry ] && {
    rm -rf DiamondRegistry
}

git clone https://github.com/dexioio/DiamondRegistry.git
