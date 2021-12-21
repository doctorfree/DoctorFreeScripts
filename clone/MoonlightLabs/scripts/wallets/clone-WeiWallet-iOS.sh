#!/bin/bash

coin="WeiWallet-iOS"
patch="${coin}-patch.tgz"

[ -d ${coin} ] && {
    rm -rf ${coin}
}

git clone https://github.com/popshootjapan/WeiWallet-iOS.git

[ -r ${patch} ] && tar xzvf ${patch}
