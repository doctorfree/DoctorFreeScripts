#!/bin/bash

project="guacamole-client"
patch="${project}-patch.tgz"
branch=793

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/apache/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}

cd ${project}
gh pr checkout ${branch}
cd ..
mv ${project} ${project}-${branch}
[ -d ${project}- ] && {
    mv ${project}- ${project}
}
