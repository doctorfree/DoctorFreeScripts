#!/bin/bash

project="guacamole-client"
patch="${project}-patch.tgz"

[ -d ${project}-ec ] && {
    rm -rf ${project}-ec-
    mv ${project}-ec ${project}-ec-
}

git clone ssh://gitlab.ecld.io/eloquent/${project}.git ${project}-ec

[ -r ${patch} ] && tar xzvf ${patch}
