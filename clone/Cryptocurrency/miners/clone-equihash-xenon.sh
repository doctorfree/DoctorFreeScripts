#!/bin/bash

[ -d equihash-xenon ] && {
    rm -rf equihash-xenon
}

git clone https://github.com/xenoncat/equihash-xenon.git
