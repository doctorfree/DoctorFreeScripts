#!/bin/bash

JAVA_VERSION=java-1.8.0-openjdk-amd64
sudo update-java-alternatives -s $JAVA_VERSION
export JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION/
export PATH=$PATH:$JAVA_HOME/bin
project="guacamole-server"

ask=1
[ "$1" == "-y" ] && ask=

rm -rf ${project}

[ -x ./clone-${project}.sh ] || {
    echo "No clone of ${project} exists here. Exiting."
    exit 1
}
./clone-${project}.sh

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
                    cd ${project}
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

cd ${project}
autoreconf -fi
./configure --with-init-dir=/etc/init.d
make 2>&1 | tee ../guacamole-server-build.log
