#!/bin/bash

JAVA_VERSION=java-1.11.0-openjdk-amd64

sudo update-java-alternatives -s $JAVA_VERSION
export JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION/
export PATH=$PATH:$JAVA_HOME/bin

PACKAGE=cas-server
[ -d $PACKAGE ] || {
    [ -x ./clone-$PACKAGE.sh ] || {
        echo "No clone of $PACKAGE exists here. Exiting."
        exit 1
    }
    ./clone-$PACKAGE.sh
}
cd $PACKAGE
git checkout master

./gradlew build install --parallel -x test -x javadoc -x check --build-cache --configure-on-demand
