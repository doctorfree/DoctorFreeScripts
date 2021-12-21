#!/bin/bash

project="powerdns-php"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/exonet/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
