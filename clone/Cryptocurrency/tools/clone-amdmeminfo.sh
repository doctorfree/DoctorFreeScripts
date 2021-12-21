#!/bin/bash

tool="amdmeminfo"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/ystarnaud/amdmeminfo.git

[ -r ${patch} ] && tar xzvf ${patch}
