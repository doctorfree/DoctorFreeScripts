#!/bin/bash

project="roon-web-controller"
patch="$HOME/src/patches/${project}.patch"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/pluggemi/${project}.git

[ -r ${patch} ] && {
    patch -b -p0 < ${patch}
}
