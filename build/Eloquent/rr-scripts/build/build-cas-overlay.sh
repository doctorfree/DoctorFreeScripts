#!/bin/bash

JAVA_VERSION=java-1.11.0-openjdk-amd64

sudo update-java-alternatives -s $JAVA_VERSION
export JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION/
export PATH=$PATH:$JAVA_HOME/bin

PACKAGE=cas-gradle-overlay-template
[ -d $PACKAGE ] || {
    [ -x ./clone-$PACKAGE.sh ] || {
        echo "No clone of $PACKAGE exists here. Exiting."
        exit 1
    }
    ./clone-$PACKAGE.sh
}
cd $PACKAGE
sudo ./build.sh package
sudo ./build.sh copy
sudo ./build.sh gencert
sudo keytool -importkeystore -srckeystore /etc/cas/thekeystore -destkeystore /etc/cas/thekeystore -deststoretype pkcs12
