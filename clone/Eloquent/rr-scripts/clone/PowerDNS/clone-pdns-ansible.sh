#!/bin/bash

project="pdns-ansible"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/PowerDNS/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
