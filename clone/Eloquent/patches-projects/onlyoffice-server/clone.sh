#!/bin/bash

project="onlyoffice-server"
build="DocumentServer"
gitpath="https://github.com/ONLYOFFICE"
patch_dir="$HOME/src/patches-projects/${project}"
here_dir=`pwd`

[ -d ${build} ] && {
    rm -rf ${build}-
    mv ${build} ${build}-
}

git clone --recursive ${gitpath}/${build}.git
cd ${build}

pnum=0
for patch in $patch_dir/*.patch
do
    [ "$patch" == "$patch_dir/*.patch" ] && continue
    b=`basename $patch`
    patch_name=`echo $b | sed -e "s/.patch//"`
    while true
    do
        read -p "Do you want to apply the patch for $patch_name ? (y/n) " yn
        case $yn in
            [Yy]* )
                [ -r ${patch} ] && {
                    suff=".0$pnum"
                    patch -b -z $suff -p0 < ${patch}
                    pnum=`expr $pnum + 1`
                }
                break;;
            [Nn]* ) printf "\nSkipping $patch_name.\n"; break;;
                * ) echo "Please answer yes or no.";;
        esac
    done
done

cd $here_dir
