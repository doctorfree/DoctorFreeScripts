#!/bin/bash

project="pdns-cli"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/catalyst/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
