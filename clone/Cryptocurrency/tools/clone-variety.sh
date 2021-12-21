#!/bin/bash

tool="variety-slideshow"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/peterlevi/variety-slideshow.git

[ -r ${patch} ] && tar xzvf ${patch}
