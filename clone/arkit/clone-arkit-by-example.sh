#!/bin/bash

tool="arkit-by-example"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/markdaws/arkit-by-example.git

[ -r ${patch} ] && tar xzvf ${patch}
