#!/bin/bash

[ -d xmr-stak-cpu ] && {
    rm -rf xmr-stak-cpu
}

git clone https://github.com/fireice-uk/xmr-stak-cpu.git
