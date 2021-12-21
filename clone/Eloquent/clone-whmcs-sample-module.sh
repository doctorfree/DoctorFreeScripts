#!/bin/bash

project="whmcs1"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone ssh://gitlab.ecld.io/eloquent/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
