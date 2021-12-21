#!/bin/bash

project="ChainReactApp2017"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/infinitered/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}

cd ${project}
yarn install
