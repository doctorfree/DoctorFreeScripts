#!/bin/bash

project="guacamole-client"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/apache/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}

cd ${project}
gh pr checkout 454
cd ..
mv ${project} ${project}-454
[ -d ${project}- ] && {
    mv ${project}- ${project}
}
