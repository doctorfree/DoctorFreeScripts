#!/bin/bash

project="LdapRecord"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/DirectoryTree/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
