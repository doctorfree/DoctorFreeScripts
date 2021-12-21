#!/bin/bash

project="roon-extension-http-api"
patch="$HOME/src/RoonCommandLine/patches/${project}.patch"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/st0g1e/${project}.git

[ -r ${patch} ] && {
    patch -b -p0 < ${patch}
}
