#!/bin/bash

project="node-roon-api"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/RoonLabs/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
