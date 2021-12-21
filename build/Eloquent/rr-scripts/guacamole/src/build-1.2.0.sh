#!/bin/bash

project="guacamole-client"
version="1.2.0"
ask=1
[ "$1" == "-y" ] && ask=

rm -rf ${project}-${version}
tar xzf src/${project}-${version}.tar.gz

patch_dir="$HOME/src/patches-projects/${project}"
here_dir=`pwd`

pnum=0
for patch in $patch_dir/*.patch
do
    [ "$patch" == "$patch_dir/*.patch" ] && continue
    b=`basename $patch`
    patch_name=`echo $b | sed -e "s/.patch//"`
    while true
    do
        if [ "$ask" ]
        then
            read -p "Do you want to apply the patch for $patch_name ? (y/n) " yn
        else
            yn="y"
        fi
        case $yn in
            [Yy]* )
                [ -r ${patch} ] && {
                    cd ${project}-${version}
                    suff=".0$pnum"
                    patch -b -z $suff -p0 < ${patch}
                    pnum=`expr $pnum + 1`
                    cd $here_dir
                }
                break;;
            [Nn]* ) printf "\nSkipping $patch_name.\n"; break;;
                * ) echo "Please answer yes or no.";;
        esac
    done
done

JAVA_VERSION=java-1.8.0-openjdk-amd64
sudo update-java-alternatives -s $JAVA_VERSION
export JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION/
export PATH=$PATH:$JAVA_HOME/bin

[ -d ${project}-${version} ] || {
    [ -x ./clone-${project}-${version}.sh ] || {
        echo "No clone of ${project}-${version} exists here. Exiting."
        exit 1
    }
    ./clone-${project}-${version}.sh
}
cd ${project}-${version}
mvn package 2>&1 | tee ../mvn-build-1.2.0.log
