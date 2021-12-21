#!/bin/bash

gitproj="nextcloud"
for project in client-building desktop ios server spreed
do
    patch="${gitproj}-${project}-patch.tgz"

    [ -d ${project} ] && {
        rm -rf ${project}-
        mv ${project} ${project}-
    }

    echo ""
    echo "Cloning Nextcloud project repository $project"
    echo ""
    git clone https://github.com/${gitproj}/${project}.git

    [ -r ${patch} ] && tar xzvf ${patch}
done
