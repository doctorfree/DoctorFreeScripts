#!/bin/bash
#
# Guacamole server has many dependencies in order to support a wide variety
# of protocols and features. Required dependencies are:
#
# 1) Cairo (http://cairographics.org/)
# 2) libjpeg-turbo (http://libjpeg-turbo.virtualgl.org/)
#    OR libjpeg (http://www.ijg.org/)
# 3) libpng (http://www.libpng.org/pub/png/libpng.html)
# 4) OSSP UUID (http://www.ossp.org/pkg/lib/uuid/)
#
# Optional but desired dependencies (at least one is required):
#   RDP:
#       * FreeRDP (http://www.freerdp.com/)
#   SSH:
#       * libssh2 (http://www.libssh2.org/)
#       * OpenSSL (https://www.openssl.org/)
#       * Pango (http://www.pango.org/)
#   Telnet:
#       * libtelnet (https://github.com/seanmiddleditch/libtelnet)
#       * Pango (http://www.pango.org/)
#   VNC:
#       * libVNCserver (http://libvnc.github.io/)
#   Support for audio within VNC:
#       * PulseAudio (http://www.freedesktop.org/wiki/Software/PulseAudio/)
#   Support for SFTP file transfer for VNC or RDP:
#       * libssh2 (http://www.libssh2.org/)
#       * OpenSSL (https://www.openssl.org/)
#   Support for WebP image compression:
#       * libwebp (https://developers.google.com/speed/webp/)
#   "guacenc" video encoding utility:
#       * FFmpeg (https://ffmpeg.org/)
#
# You will also need autoconf/automake/libtool and friends to build from source

PACKAGE=guacamole-server
[ -d $PACKAGE ] || {
    [ -x ./clone-$PACKAGE.sh ] || {
        echo "No clone of $PACKAGE exists here. Exiting."
        exit 1
    }
    ./clone-$PACKAGE.sh
}
cd $PACKAGE
autoreconf -fi
./configure --with-init-dir=/etc/init.d
make
