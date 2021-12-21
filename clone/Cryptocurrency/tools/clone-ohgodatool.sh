#!/bin/bash

tool="OhGodATool"
patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

git clone https://github.com/OhGodACompany/OhGodATool.git

[ -r ${patch} ] && tar xzvf ${patch}
