#!/bin/bash

project="ONLYOFFICE"
build="build_tools"
docbld="DocumentBuilder"

if [ -x ./clone-onlyoffice-build.sh ]
then
    ./clone-onlyoffice-build.sh
else
    if [ -x ../../clone/Nextcloud/clone-onlyoffice-build.sh ]
    then
        ../../clone/Nextcloud/clone-onlyoffice-build.sh
    else
        echo "OnlyOffice clone script clone-onlyoffice-build.sh not found."
        [ "$1" == "-f" ] || {
            echo "To build without using the Eloquent Cloud clone script,"
            echo "execute this build script with the -f option:"
            echo "    ./build-onlyoffice.sh -f"
            exit 1
        }
    fi
fi

[ -d ${project} ] || mkdir ${project}
cd ${project}

[ -d ${build} ] || {
    git clone https://github.com/${project}/${build}.git
}

[ -d ${docbld} ] || {
    git clone https://github.com/${project}/${docbld}.git
}

cd ${build}/tools/linux
rm -f ../../../build_automate_server.log
./automate.py server 2>&1 | /usr/bin/tee -a ../../../build_automate_server.log
