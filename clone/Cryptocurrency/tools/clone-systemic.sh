#!/bin/bash

tool="Systemic2"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/stefano-meschiari/Systemic2.git

[ -r ${patch} ] && tar xzvf ${patch}
