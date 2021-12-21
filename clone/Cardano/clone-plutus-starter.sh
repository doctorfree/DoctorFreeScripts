#!/bin/bash

project="plutus-starter"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/input-output-hk/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
