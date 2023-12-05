#!/bin/sh
#
# Build cppcms
cd $BASEDIR

git clone https://github.com/artyom-beilis/cppcms.git
cd cppcms

cmake . -DCMAKE_INSTALL_PREFIX=$OUTPUT/cppcms/usr/local
make
make install
