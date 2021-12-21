#!/bin/bash

[ -d cpuminer-opt ] && {
    rm -rf cpuminer-opt
}

git clone https://github.com/JayDDee/cpuminer-opt.git
