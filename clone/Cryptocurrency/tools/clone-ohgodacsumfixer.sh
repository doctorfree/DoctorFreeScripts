#!/bin/bash

tool="OhGodACsumFixer"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/OhGodACompany/OhGodACsumFixer.git

[ -r ${patch} ] && tar xzvf ${patch}
