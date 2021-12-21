#!/bin/bash

gitpath="https://github.com/apereo"
project="cas-configserver-overlay"
patch_dir="$HOME/src/patches-projects/${project}"
here_dir=`pwd`

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone $gitpath/${project}.git

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
                    cd ${project}
                    patch -b -z '.00' -p0 < ${patch}
                    cd $here_dir
                }
                break;;
            [Nn]* ) printf "\nSkipping $patch_name.\n"; break;;
                * ) echo "Please answer yes or no.";;
        esac
    done
done
