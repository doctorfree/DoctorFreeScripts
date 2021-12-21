#!/bin/bash

INST_DIR=/opt/nextcloud

plat=`uname -s`
# Try to figure out which system we are on
if [ "$plat" == "Linux" ]
then
    export OPENSSL_ROOT_DIR=/usr/lib/x86_64-linux-gnu
    export Qt5_DIR=/usr/lib/x86_64-linux-gnu/cmake/Qt5
    export Qt5Keychain_DIR=/usr/lib/x86_64-linux-gnu/cmake/Qt5Keychain
    KEYCHAIN_DEFINES="-DQTKEYCHAIN_LIBRARIES=/usr/lib/x86_64-linux-gnu \
          -DQTKEYCHAIN_INCLUDE_DIR=/usr/include/qt5keychain"
else
    if [ "$plat" == "Darwin" ]
    then
        export OPENSSL_ROOT_DIR=/usr/local/Cellar/openssl@1.1/1.1.1g
        export Qt5_DIR=/usr/local/Cellar/qt/5.14.1/lib/cmake/Qt5
        export Qt5Keychain_DIR=/usr/local/Cellar/qtkeychain/0.11.1/lib/cmake/Qt5Keychain
        KEYCHAIN_DEFINES="-DQTKEYCHAIN_LIBRARIES=/usr/local/Cellar/qtkeychain/0.11.1/lib \
          -DQTKEYCHAIN_INCLUDE_DIR=/usr/local/Cellar/qtkeychain/0.11.1/include/qt5keychain"
    else
        echo "Unable to detect a supported platform: ${plat}. Exiting."
#       exit 1
    fi
fi

#Build server
[ -d server ] || git clone https://github.com/nextcloud/server.git
cd server
# install dependencies
make dev-setup

# build for development
make build-js

# build for development and watch edits
# make watch-js

# build for production with minification
# make build-js-production

# Uncomment the following line to install in ${INST_DIR}
# sudo make DESTDIR=/ install
