#!/bin/bash

gitproj="nextcloud"
project="ios"
patch="${gitproj}-${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/${gitproj}/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
