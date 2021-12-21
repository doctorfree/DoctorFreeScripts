#!/bin/bash

#wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
# If this download doesn’t work, maybe visit the Oracle website and
# find the link that does.

PREFIX="/usr/local/BerkeleyDB.4.8"

rm -rf db-4.8.30.NC
tar xzvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix/
LDFLAGS="-Wl,-rpath=${PREFIX}/lib" \
    ../dist/configure --prefix=${PREFIX} --enable-cxx --enable-shared
make
sudo make install

#In addition to compiling and installing the Berkeley DB 4.8 lib, I still had issues and had to create the following symbolic links so the headers and lib files could be found. Thanks to the thread here for that.
#
#sudo ln -s /usr/local/BerkeleyDB.4.8 /usr/include/db4.8
#sudo ln -s /usr/include/db4.8/include/* /usr/include
#sudo ln -s /usr/include/db4.8/lib/* /usr/lib

