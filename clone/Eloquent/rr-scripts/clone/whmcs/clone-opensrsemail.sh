#!/bin/bash

project="whmcs-opensrsemail"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/nathanoertel/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
