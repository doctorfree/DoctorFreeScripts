#!/bin/bash

tool="OhGodADecode"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/OhGodACompany/OhGodADecode.git

[ -r ${patch} ] && tar xzvf ${patch}
