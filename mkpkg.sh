#!/bin/bash
PKG="doctorfree-scripts"
PKG_NAME="DoctorFreeScripts"
PKG_VER="3.1"
TOP="usr"
LOCAL="${TOP}/local"
DESTDIR="${LOCAL}/${PKG_NAME}"
SRC=${HOME}/src/Scripts
SUDO=sudo
GCI=

# Subdirectory in which to create the distribution files
OUT_DIR="dist/${PKG_NAME}_${PKG_VER}"

SUBDIRS="Config IFTTT binance chrome-themes \
         clone coinmarketcap doc profittrailer systemd"
DOT_FILES="bash_aliases bash_profile bashrc dircolors vimrc"
IMG_FILES="Scripts-Logo.png Vertical.png"
ETC_FILES="Doxyfile crontab-peakhours.in"

[ -d "${SRC}" ] || {
  [ -d "/builds/doctorfree/Scripts" ] || {
    echo "$SRC does not exist or is not a directory. Exiting."
    exit 1
  }
  SRC="/builds/doctorfree/Scripts"
  SUDO=
  GCI=1
}

cd "${SRC}"
${SUDO} rm -rf dist
mkdir dist

[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR}
mkdir ${OUT_DIR}
cp -a pkg ${OUT_DIR}/DEBIAN
chmod 755 ${OUT_DIR} ${OUT_DIR}/DEBIAN ${OUT_DIR}/DEBIAN/*

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

chmod 644 ${OUT_DIR}/DEBIAN/control

for dir in "${TOP}" "${LOCAL}" "${DESTDIR}" "${TOP}/share" "${TOP}/share/applications" \
            "${TOP}/share/doc" "${TOP}/share/doc/${PKG}"
do
    [ -d ${OUT_DIR}/${dir} ] || ${SUDO} mkdir ${OUT_DIR}/${dir}
    ${SUDO} chown root:root ${OUT_DIR}/${dir}
done

for dir in bin etc share ${SUBDIRS}
do
    [ -d ${OUT_DIR}/${DESTDIR}/${dir} ] && ${SUDO} rm -rf ${OUT_DIR}/${DESTDIR}/${dir}
done

${SUDO} cp -a Utils/bin ${OUT_DIR}/${DESTDIR}/bin
for util in Utils/*
do
    [ -d "${util}" ] && continue
    b=`basename ${util}`
    [ "$b" == "README.md" ] && continue
    ${SUDO} cp ${util} ${OUT_DIR}/${DESTDIR}/bin/$b
done
for script in Wallpapers/*.sh
do
    grep ${script} .gitignore > /dev/null || {
        b=`basename ${script}`
        dest=`echo ${b} | sed -e "s/\.sh//"`
        ${SUDO} cp ${script} ${OUT_DIR}/${DESTDIR}/bin/${dest}
    }
done

for script in *.sh
do
    grep ${script} .gitignore > /dev/null || {
        dest=`echo ${script} | sed -e "s/\.sh//"`
        ${SUDO} cp ${script} ${OUT_DIR}/${DESTDIR}/bin/${dest}
    }
done

${SUDO} cp Config/autostart/*.desktop "${OUT_DIR}/${TOP}/share/applications"
${SUDO} cp AUTHORS ${OUT_DIR}/${TOP}/share/doc/${PKG}/AUTHORS
${SUDO} cp LICENSE ${OUT_DIR}/${TOP}/share/doc/${PKG}/copyright
${SUDO} cp CHANGELOG.md ${OUT_DIR}/${TOP}/share/doc/${PKG}/changelog
${SUDO} cp README.md ${OUT_DIR}/${TOP}/share/doc/${PKG}/README
${SUDO} gzip -9 ${OUT_DIR}/${TOP}/share/doc/${PKG}/changelog

for dir in ${SUBDIRS}
do
    ${SUDO} cp -a ${dir} ${OUT_DIR}/${DESTDIR}/${dir}
done

[ -d ${OUT_DIR}/${DESTDIR}/share ] || ${SUDO} mkdir -p ${OUT_DIR}/${DESTDIR}/share
[ -d ${OUT_DIR}/${DESTDIR}/share/bash ] || ${SUDO} mkdir -p ${OUT_DIR}/${DESTDIR}/share/bash
${SUDO} cp ${DOT_FILES} ${OUT_DIR}/${DESTDIR}/share/bash
[ -d ${OUT_DIR}/${DESTDIR}/share/images ] || ${SUDO} mkdir -p ${OUT_DIR}/${DESTDIR}/share/images
${SUDO} cp ${IMG_FILES} ${OUT_DIR}/${DESTDIR}/share/images
[ -d ${OUT_DIR}/${DESTDIR}/etc ] || ${SUDO} mkdir -p ${OUT_DIR}/${DESTDIR}/etc
${SUDO} cp ${ETC_FILES} ${OUT_DIR}/${DESTDIR}/etc

[ -f .gitignore ] && {
    while read ignore
    do
        ${SUDO} rm -f ${OUT_DIR}/${DESTDIR}/${ignore}
    done < .gitignore
}

${SUDO} chmod 755 ${OUT_DIR}/${DESTDIR}/bin/*

cd dist
${SUDO} dpkg-deb --build ${PKG_NAME}_${PKG_VER}
cd ${PKG_NAME}_${PKG_VER}
echo "Creating compressed tar archive of ${PKG_NAME} ${PKG_VER} distribution"
tar cf - usr | gzip -9 > ../${PKG_NAME}_${PKG_VER}-dist.tar.gz
[ "${GCI}" ] || {
    echo "Creating zip archive of ${PKG_NAME} ${PKG_VER} distribution"
    zip -q -r ../${PKG_NAME}_${PKG_VER}-dist.zip usr
}
