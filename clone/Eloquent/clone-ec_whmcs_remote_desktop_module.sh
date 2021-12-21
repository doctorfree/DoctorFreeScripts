#!/bin/bash

project="ec_whmcs_remote_desktop_module"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone ssh://gitlab.ecld.io/eloquent/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
