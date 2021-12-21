#!/bin/bash

tool="grc"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/garabik/grc.git

[ -r ${patch} ] && tar xzvf ${patch}
