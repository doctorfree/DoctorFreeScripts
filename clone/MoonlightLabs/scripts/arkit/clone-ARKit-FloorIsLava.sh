#!/bin/bash

tool="ARKit-FloorIsLava"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/arirawr/${tool}.git

[ -r ${patch} ] && tar xzvf ${patch}
