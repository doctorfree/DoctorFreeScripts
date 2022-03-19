#!/bin/bash
#
# Repo: https://github.com/ncmpcpp/ncmpcpp
# Project: https://rybczak.net/ncmpcpp/
#
# To install from the distribution repo:
# sudo apt install ncmpcpp
#
# To build and install from source see the following
#
# Dependencies include:
# sudo apt install libboost
# sudo apt install libboost-all-dev
# sudo apt install libmpdclient-dev
# sudo apt install libcurl4-openssl-dev
# sudo apt install libfftw3-dev
#
# Configure options include:
# --enable-outputs        Enable outputs screen [default=no]
# --enable-visualizer     Enable music visualizer screen [default=no]
# --enable-clock          Enable clock screen [default=no]
#
# Usage: ./build-ncmpcpp.sh [-i]
# Where -i indicates install ncmpcpp after configuring and compiling

PROJ=ncmpcpp

[ -d ${PROJ} ] || rm -rf ${PROJ}

have_gh=`type -p gh`
if [ "${have_gh}" ]
then
    gh repo clone ${PROJ}/${PROJ}
else
    git clone https://github.com/${PROJ}/${PROJ}.git
fi

cd ${PROJ}
./autogen.sh

./configure --enable-outputs \
            --enable-visualizer \
            --enable-clock \
            --enable-static-boost

make

[ "$1" == "-i" ] && sudo make install
