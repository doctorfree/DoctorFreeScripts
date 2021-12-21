#!/bin/bash

tool="simplesh"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/rafaelstz/simplesh.git

[ -r ${patch} ] && tar xzvf ${patch}
