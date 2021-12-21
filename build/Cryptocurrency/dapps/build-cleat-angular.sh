#!/bin/bash
#
DIR="cleat-angular"

[ -d $DIR ] || ./clone-${DIR}.sh

cd ${DIR}

npm install
ng build
