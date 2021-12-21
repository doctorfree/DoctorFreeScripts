#!/bin/bash

[ -d stellar-go ] && {
    rm -rf stellar-go
}
[ -d go ] && {
    rm -rf go
}

git clone https://github.com/stellar/go.git
mv go stellar-go
