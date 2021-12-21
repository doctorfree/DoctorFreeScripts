#!/bin/bash

project="ONLYOFFICE"
build="build_tools"
patchproj="patches-projects"
patch_dir="$HOME/src/${patchproj}/onlyoffice-server/build_tools"
here_dir=`pwd`

# First clone our patches repository
[ -d ${patchproj} ] || {
    git clone ssh://gitlab.ecld.io/eloquent/${patchproj}.git
}

[ -d ${project} ] || mkdir ${project}
cd ${project}

[ -d ${build} ] && {
    rm -rf ${build}-
    mv ${build} ${build}-
}

git clone https://github.com/${project}/${build}.git

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

cd ${here_dir}/${project}
[ -f ${patch_dir}/../patch.sh ] && {
    cp ${patch_dir}/../patch.sh patch.sh
    chmod 755 patch.sh
}
cd ${here_dir}
