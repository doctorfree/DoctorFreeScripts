#!/bin/bash

[ -d mining-rig-resetter ] && {
    rm -rf mining-rig-resetter
}

git clone https://github.com/BernhardSchlegel/mining-rig-resetter.git
