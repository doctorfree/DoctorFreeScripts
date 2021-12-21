#!/bin/bash

# Change this to the name of the Github project
tool="ARPaint"

patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/oabdelkarim/${tool}.git

[ -r ${patch} ] && tar xzvf ${patch}
