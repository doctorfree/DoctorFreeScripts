#!/bin/bash
PKG="doctorfree-scripts"
PKG_NAME="DoctorFreeScripts"
PKG_VER="1.0"
TOP="usr"
LOCAL="${TOP}/local"
DESTDIR="${LOCAL}/${PKG_NAME}"
SRC=${HOME}/src/Scripts
# Subdirectory in which to create the distribution files
OUT_DIR="dist/${PKG_NAME}_${PKG_VER}"

SUBDIRS="Config IFTTT binance chrome-themes \
         clone coinmarketcap doc profittrailer systemd"

[ -d "${SRC}" ] || {
    echo "$SRC does not exist or is not a directory. Exiting."
    exit 1
}

cd "${SRC}"
sudo rm -rf dist
mkdir dist

[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR}
mkdir ${OUT_DIR}
cp -a pkg ${OUT_DIR}/DEBIAN

echo "Package: ${PKG}
Version: ${PKG_VER}
Section: misc
Priority: optional
Architecture: armhf
Depends: qterminal (>= 0.14.1)
Maintainer: ${DEBFULLNAME} <${DEBEMAIL}>
Build-Depends: debhelper (>= 11)
Standards-Version: 4.1.3
Homepage: https://gitlab.com/doctorfree/Scripts
Description: General Purpose Command Line Tools
 Manage your system from the command line" > ${OUT_DIR}/DEBIAN/control

for dir in "${TOP}" "${LOCAL}" "${DESTDIR}" "${TOP}/share" "${TOP}/share/applications" \
            "${TOP}/share/doc" "${TOP}/share/doc/${PKG}"
do
    [ -d ${OUT_DIR}/${dir} ] || sudo mkdir ${OUT_DIR}/${dir}
    sudo chown root:root ${OUT_DIR}/${dir}
done

for dir in bin etc ${SUBDIRS}
do
    [ -d ${OUT_DIR}/${DESTDIR}/${dir} ] && sudo rm -rf ${OUT_DIR}/${DESTDIR}/${dir}
done

sudo cp -a Utils/bin ${OUT_DIR}/${DESTDIR}/bin
for util in Utils/*
do
    [ -d "${util}" ] && continue
    b=`basename ${util}`
    [ "$b" == "README.md" ] && continue
    sudo cp ${util} ${OUT_DIR}/${DESTDIR}/bin/$b
done
for script in Wallpapers/*.sh
do
    grep ${script} .gitignore > /dev/null || {
        b=`basename ${script}`
        dest=`echo ${b} | sed -e "s/\.sh//"`
        sudo cp ${script} ${OUT_DIR}/${DESTDIR}/bin/${dest}
    }
done

for script in *.sh
do
    grep ${script} .gitignore > /dev/null || {
        dest=`echo ${script} | sed -e "s/\.sh//"`
        sudo cp ${script} ${OUT_DIR}/${DESTDIR}/bin/${dest}
    }
done

sudo cp Config/autostart/*.desktop "${OUT_DIR}/${TOP}/share/applications"
sudo cp AUTHORS ${OUT_DIR}/${TOP}/share/doc/${PKG}/AUTHORS
sudo cp LICENSE ${OUT_DIR}/${TOP}/share/doc/${PKG}/copyright
sudo cp CHANGELOG.md ${OUT_DIR}/${TOP}/share/doc/${PKG}/changelog
sudo cp README.md ${OUT_DIR}/${TOP}/share/doc/${PKG}/README
sudo gzip -9 ${OUT_DIR}/${TOP}/share/doc/${PKG}/changelog

for dir in ${SUBDIRS}
do
    sudo cp -a ${dir} ${OUT_DIR}/${DESTDIR}/${dir}
done

[ -f .gitignore ] && {
    while read ignore
    do
        sudo rm -f ${OUT_DIR}/${DESTDIR}/${ignore}
    done < .gitignore
}

sudo chmod 755 ${OUT_DIR}/${DESTDIR}/bin/*

cd dist
sudo dpkg-deb --build ${PKG_NAME}_${PKG_VER}
cd ${PKG_NAME}_${PKG_VER}
echo "Creating compressed tar archive of ${PKG_NAME} ${PKG_VER} distribution"
tar cf - usr | gzip -9 > ../${PKG_NAME}_${PKG_VER}-dist.tar.gz
echo "Creating zip archive of ${PKG_NAME} ${PKG_VER} distribution"
zip -q -r ../${PKG_NAME}_${PKG_VER}-dist.zip usr
