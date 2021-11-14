#!/bin/bash

TAG=$1

[ "$TAG" ] || {
    echo "Usage: gitshow tagname"
    exit 1
}

git tag | while read tag
do
    [ "$TAG" == "$tag" ] && {
        git show $TAG
        exit 0
    }
done

[ $? -eq 0 ] || {
    echo "Tag $TAG not found"
    echo "Current tags:"
    git tag
    exit 1
}

exit 0

