#!/bin/bash

project="synergy-core"

[ -d ${project} ] || {
    git clone https://github.com/symless/${project}.git
}

cd ${project}
[ -d build ] || mkdir build
cd build
cmake ..
make

# Missing build dependencies probably mean one of these is not installed
# sudo apt install -y \
#   qtcreator \
#   qtbase5-dev \
#   qttools5-dev \
#   cmake \
#   make \
#   g++ \
#   xorg-dev \
#   libssl-dev \
#   libx11-dev \
#   libsodium-dev \
#   libgl1-mesa-glx \
#   libegl1-mesa \
#   libcurl4-openssl-dev \
#   libavahi-compat-libdnssd-dev \
#   qtdeclarative5-dev \
#   libqt5svg5-dev \
#   libsystemd-dev \
#   libnotify-dev \
#   libgdk-pixbuf2.0-dev \
#   libglib2.0-dev
