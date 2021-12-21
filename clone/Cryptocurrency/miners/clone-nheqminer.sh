#!/bin/bash

[ -d nheqminer ] && {
    rm -rf nheqminer
}

git clone https://github.com/nicehash/nheqminer.git
