#!/bin/bash

TAG="$1"
shift

usage() {
    echo "Usage: gitbranch [-n] tagname branchname"
    exit 1
}

if [ "$TAG" = "-n" ]
then
    shift
    TAG="$1"
    BNM="$2"
    echo "git checkout -b $BNM $TAG"
else
    [ "$BNM" ] || {
        echo "Empty branch name. Exiting."
        usage
    }
    [ "$TAG" ] || {
        echo "Empty tag name. Exiting."
        usage
    }
    git checkout -b $BNM $TAG
fi

