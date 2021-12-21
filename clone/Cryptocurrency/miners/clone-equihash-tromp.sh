#!/bin/bash

[ -d equihash ] && {
    rm -rf equihash
}
[ -d equihash-tromp ] && {
    rm -rf equihash-tromp
}

git clone https://github.com/tromp/equihash.git

mv equihash equihash-tromp
