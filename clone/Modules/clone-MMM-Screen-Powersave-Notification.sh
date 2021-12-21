#!/bin/bash

project="MMM-Screen-Powersave-Notification"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/Tom-Hirschberger/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
