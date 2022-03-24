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
# sudo apt install libtag1-dev
#
# Configure options include:
# --enable-outputs        Enable outputs screen [default=no]
# --enable-visualizer     Enable music visualizer screen [default=no]
# --enable-clock          Enable clock screen [default=no]
#
# Usage: ./build-ncmpcpp.sh [-i]
# Where -i indicates install ncmpcpp after configuring and compiling

usage() {
    printf "\nUsage: ./build-ncmpcpp.sh [-acCi] [-p prefix] [-u]"
    printf "\nWhere:"
    printf "\n\t-a indicates clone repo and run autogen script"
    printf "\n\t-c indicates clone repo and exit"
    printf "\n\t-C indicates clone repo, run autogen, and configure"
    printf "\n\t-i indicates clone, configure, build, and install"
    printf "\n\t-p prefix specifies installation prefix (default /usr/local)"
    printf "\n\t-u displays this usage message and exits\n"
    printf "\nNo arguments: clone, configure with prefix=/usr/local, build\n"
    exit 1
}

PROJ=ncmpcpp
CLONE_ONLY=
CONFIGURE_ONLY=
AUTOGEN_ONLY=
INSTALL=
PREFIX=
while getopts "acCip:u" flag; do
    case $flag in
        a)
            AUTOGEN_ONLY=1
            ;;
        c)
            CLONE_ONLY=1
            ;;
        C)
            CONFIGURE_ONLY=1
            ;;
        i)
            INSTALL=1
            ;;
        p)
            PREFIX="$OPTARG"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ -d ${PROJ} ] || rm -rf ${PROJ}

have_gh=`type -p gh`
if [ "${have_gh}" ]
then
    gh repo clone ${PROJ}/${PROJ}
else
    git clone https://github.com/${PROJ}/${PROJ}.git
fi
[ "${CLONE_ONLY}" ] && exit 0

cd ${PROJ}
./autogen.sh
[ "${AUTOGEN_ONLY}" ] && exit 0

prefix=
[ "${PREFIX}" ] && prefix="--prefix=${PREFIX}"
./configure ${prefix} \
            --enable-outputs \
            --enable-visualizer \
            --enable-clock \
            --enable-unicode \
            --without-iconv \
            --with-curl \
            --with-taglib
#           --enable-static-boost
[ "${CONFIGURE_ONLY}" ] && exit 0

make

[ "${INSTALL}" ] && sudo make install
