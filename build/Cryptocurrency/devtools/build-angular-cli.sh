#!/bin/bash
#
DIR="angular-cli"

[ -d ${DIR} ] || ./clone-angular-cli.sh

cd ${DIR}

sudo npm install -g @angular/cli
