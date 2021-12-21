#!/bin/bash

project="sample-gateway-module"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

# Determine the current global git configuration setting
ELO=
LAB=
email=`git config --global -l | grep user.email | awk -F "=" ' { print $2 } '`
if [ "$email" == "rrecord@eloquentcloud.com" ]
then
    ELO=1
else
    [ "$email" == "gitlab@ronrecord.com" ] && LAB=1
fi

# Set the global git configuration for Github
git config --global user.name "Ronald Record"
git config --global user.email "github@ronrecord.com"

git clone https://github.com/WHMCS/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}

# Restore global git configuration setting
if [ "${ELO}" ]
then
    git config --global user.name "Ron Record"
    git config --global user.email "rrecord@eloquentcloud.com"
else
    [ "${LAB}" ] && {
        git config --global user.name "Ron Record"
        git config --global user.email "gitlab@ronrecord.com"
    }
fi
