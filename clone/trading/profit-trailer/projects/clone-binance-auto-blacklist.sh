#!/bin/bash

[ -d binance-auto-blacklist ] && {
    rm -rf binance-auto-blacklist
}

git clone https://github.com/bennettca/binance-auto-blacklist.git
