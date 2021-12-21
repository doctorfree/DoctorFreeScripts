#!/bin/bash

project="MMM-EmbedYoutube"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/nitpum/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
