#!/bin/bash

INST_DIR=/opt/nextcloud

plat=`uname -s`
# Try to figure out which system we are on
if [ "$plat" == "Linux" ]
then
    echo "Detected platform, ${plat}, not supported. Build Nextcloud iOS client with XCode. Exiting."
    exit 1
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
        exit 1
    fi
fi

# Carthage dependencies
[ -d ios ] || git clone https://github.com/nextcloud/ios.git
cd ios
# carthage update
# Due to issues with carthage and XCode 12, use the following command when building
# dependencies for XCode 12
./wcarthage update --no-use-binaries --platform iOS --cache-builds
carthage build --platform ios

