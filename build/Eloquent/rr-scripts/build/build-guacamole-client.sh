#!/bin/bash

JAVA_VERSION=java-1.8.0-openjdk-amd64
sudo update-java-alternatives -s $JAVA_VERSION
export JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION/
export PATH=$PATH:$JAVA_HOME/bin

PACKAGE=guacamole-client
[ -d $PACKAGE ] || {
    [ -x ./clone-$PACKAGE.sh ] || {
        echo "No clone of $PACKAGE exists here. Exiting."
        exit 1
    }
    ./clone-$PACKAGE.sh
}
cd $PACKAGE
mvn package
